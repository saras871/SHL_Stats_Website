
namespace ShlStatsApi.Models;

public class GoalieStatsDto
{
    public string Name { get; set; }  = "";
    public string Team { get; set; }  = "";
    public decimal SavePercentage { get; set; }
    public decimal GoalsAgainstAverage { get; set; }
    public int GamesPlayed { get; set; }
    public int? Saves { get; set; }
    public int? GoalsAgainst { get; set; }
    public int? Shutouts { get; set; }
    public int RankScore { get; set; }
    public int Position { get; set; }
    public int RegGames { get; set; }
    public int PlayoffGames { get; set; }
    public int? RelegationGames { get; set; }
}

public class GoalieClutchDto
{
    public string Name { get; set; }  = "";
    public string Team { get; set; }  = "";
    public double SaveDiff { get; set; }
    public double GaaDiff { get; set; }
    public double ClutchScore { get; set; }
    public int RegGames { get; set; }
    public int PlayoffGames { get; set; }
}