using Dapper;
using Microsoft.Data.SqlClient;
using ShlStatsApi.Models;

public class GoalieRepository
{
    private readonly string _connectionString;

    // Get connection string from appsettings.json
    public GoalieRepository(IConfiguration config)
    {
        _connectionString = config.GetConnectionString("Default");
    }
    // NOTE: Weighted averages are used throughout (stat * games played) to avoid skew from small sample sizes.
    // Explore section Goalie ranking 
    public async Task<IEnumerable<GoalieStatsDto>> GetRanking()
    {
        // Create a new SQL connection using the connection string. Automatically disposes when done.
        using var connection = new SqlConnection(_connectionString);
// Ranked equally based on both SVS% (higher is better) and GAA (lower is better).
// Combines rankings from SVS% and GAA into a single RankScore
// Lower RankScore = better overall performance
// Only includes goalies with at least 10 games played in regular season.
        var sql = @"
        WITH RankedGoalies AS (
    SELECT  
        p.FirstName + ' ' + p.LastName AS Name,
        t.Name AS Team,
        gs.SavePercentage,
        gs.GoalsAgainstAverage,
        gs.GoalsAgainst,
        gs.Saves,
        gs.Shutouts,
        gs.GamesPlayed,

        RANK() OVER (ORDER BY gs.SavePercentage DESC) +
        RANK() OVER (ORDER BY gs.GoalsAgainstAverage ASC) AS RankScore

    FROM GoalieStats gs
    JOIN Players p ON p.PlayerId = gs.PlayerId
    JOIN Team t ON t.TeamId = p.TeamId

    WHERE gs.Competition = 'Regular'
    AND gs.GamesPlayed > 10
)

SELECT *,
    ROW_NUMBER() OVER (ORDER BY RankScore ASC) AS Position

FROM RankedGoalies
ORDER BY RankScore ASC";

        return await connection.QueryAsync<GoalieStatsDto>(sql);
    }

// Clutch section Goalie ranking
    public async Task<IEnumerable<GoalieClutchDto>> GetClutch()
    {
        using var connection = new SqlConnection(_connectionString);
// Ranked based on how much better/worse they performed in playoffs compared to regular season. 
// Only includes goalies with at least 2 games played in both regular season and playoffs. 
// Clutch score is calculated as the difference in SVS% and the difference in GAA.
// Positive score = better performance in playoffs. Negative score = worse performance in playoffs.
        var sql = @"
        WITH GoalieSplit AS (
    SELECT
        p.PlayerId,
        p.FirstName,
        p.LastName,
        t.Name AS Team,


        SUM(CASE WHEN gs.Competition = 'Regular' THEN gs.SavePercentage * gs.GamesPlayed ELSE 0 END)
            / NULLIF(SUM(CASE WHEN gs.Competition = 'Regular' THEN gs.GamesPlayed ELSE 0 END),0) AS RegSavePct,

        SUM(CASE WHEN gs.Competition = 'Regular' THEN gs.GoalsAgainstAverage * gs.GamesPlayed ELSE 0 END)
            / NULLIF(SUM(CASE WHEN gs.Competition = 'Regular' THEN gs.GamesPlayed ELSE 0 END),0) AS RegGAA,

        SUM(CASE WHEN gs.Competition = 'Regular' THEN gs.GamesPlayed ELSE 0 END) AS RegGames,

        SUM(CASE WHEN gs.Competition = 'Playoff' THEN gs.SavePercentage * gs.GamesPlayed ELSE 0 END)
            / NULLIF(SUM(CASE WHEN gs.Competition = 'Playoff' THEN gs.GamesPlayed ELSE 0 END),0) AS PlayoffSavePct,

        SUM(CASE WHEN gs.Competition = 'Playoff' THEN gs.GoalsAgainstAverage * gs.GamesPlayed ELSE 0 END)
            / NULLIF(SUM(CASE WHEN gs.Competition = 'Playoff' THEN gs.GamesPlayed ELSE 0 END),0) AS PlayoffGAA,

        SUM(CASE WHEN gs.Competition = 'Playoff' THEN gs.GamesPlayed ELSE 0 END) AS PlayoffGames

    FROM GoalieStats gs
    JOIN Players p ON p.PlayerId = gs.PlayerId
    JOIN Team t ON t.TeamId = p.TeamId
    WHERE gs.GamesPlayed > 0
    GROUP BY p.PlayerId, p.FirstName, p.LastName, t.Name
)

SELECT
    FirstName + ' ' + LastName AS Name,
    Team,

    ISNULL(PlayoffSavePct - RegSavePct, 0) AS SaveDiff,
    ISNULL(RegGAA - PlayoffGAA, 0) AS GaaDiff,

    ISNULL(
        (PlayoffSavePct - RegSavePct) + (RegGAA - PlayoffGAA), 0) AS ClutchScore

FROM GoalieSplit

WHERE PlayoffGames >= 2
AND RegGames >= 2

ORDER BY ClutchScore DESC";

        return await connection.QueryAsync<GoalieClutchDto>(sql);
    }
// Team section ranking - overall (regular season + playoffs + relegation)
    public async Task<IEnumerable<GoalieStatsDto>> GetTeamOverall()
    {
        using var connection = new SqlConnection(_connectionString);
// Ranked based on combined performance (SVS% and GAA) of all goalies in the team across all competitions. 
        var sql = @"

SELECT  
    t.Name AS Team,

    SUM(gs.SavePercentage * gs.GamesPlayed) 
        / NULLIF(SUM(gs.GamesPlayed),0) AS SavePercentage,

    SUM(gs.GoalsAgainstAverage * gs.GamesPlayed) 
        / NULLIF(SUM(gs.GamesPlayed),0) AS GoalsAgainstAverage,
SUM(CASE WHEN gs.Competition = 'Playoff' THEN gs.GamesPlayed ELSE 0 END) AS PlayoffGames,
SUM(CASE WHEN gs.Competition = 'Relegation' THEN gs.GamesPlayed ELSE 0 END) AS RelegationGames,


    RANK() OVER (
        ORDER BY 
        SUM(gs.SavePercentage * gs.GamesPlayed) 
        / SUM(gs.GamesPlayed) DESC
    )
    +
    RANK() OVER (
        ORDER BY 
        SUM(gs.GoalsAgainstAverage * gs.GamesPlayed) 
        / SUM(gs.GamesPlayed) ASC
    ) AS RankScore

FROM GoalieStats gs  
JOIN Players p ON p.PlayerId = gs.PlayerId  
JOIN Team t ON t.TeamId = p.TeamId  

WHERE gs.GamesPlayed > 0
AND gs.Competition IN ('Regular','Playoff','Relegation')
GROUP BY t.Name  

ORDER BY RankScore ASC";


        return await connection.QueryAsync<GoalieStatsDto>(sql);
    }
// Team section ranking - regular season 
public async Task<IEnumerable<GoalieStatsDto>> GetTeamRegular()
    {
        using var connection = new SqlConnection(_connectionString);
// Ranked based on combined performance (SVS% and GAA) of all goalies in the team in the regular season. 
        var sql = @"

SELECT  
    t.Name AS Team,

    SUM(gs.SavePercentage * gs.GamesPlayed) 
        / NULLIF(SUM(gs.GamesPlayed),0) AS SavePercentage,

    SUM(gs.GoalsAgainstAverage * gs.GamesPlayed) 
        / NULLIF(SUM(gs.GamesPlayed),0) AS GoalsAgainstAverage,

    RANK() OVER (
        ORDER BY 
        SUM(gs.SavePercentage * gs.GamesPlayed) 
        / SUM(gs.GamesPlayed) DESC
    )
    +
    RANK() OVER (
        ORDER BY 
        SUM(gs.GoalsAgainstAverage * gs.GamesPlayed) 
        / SUM(gs.GamesPlayed) ASC
    ) AS RankScore

FROM GoalieStats gs  
JOIN Players p ON p.PlayerId = gs.PlayerId  
JOIN Team t ON t.TeamId = p.TeamId  

WHERE gs.GamesPlayed > 0
AND gs.Competition = 'Regular'
GROUP BY t.Name  

ORDER BY RankScore ASC";


        return await connection.QueryAsync<GoalieStatsDto>(sql);
    }

}