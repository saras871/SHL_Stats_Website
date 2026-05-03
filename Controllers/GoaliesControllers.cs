using Microsoft.AspNetCore.Mvc;

[ApiController]
[Route("api/[controller]")]
public class GoaliesController : ControllerBase
{
    private readonly GoalieRepository _repo;

    public GoaliesController(GoalieRepository repo)
    {
        _repo = repo;
    }

    [HttpGet("ranking")]
    public async Task<IActionResult> GetRanking()
    {
        var result = await _repo.GetRanking();
        return Ok(result);
    }
    [HttpGet("clutch")]
public async Task<IActionResult> GetClutch()
{
    var result = await _repo.GetClutch();
    return Ok(result);
}
    [HttpGet("teamOverall")]
public async Task<IActionResult> GetTeamOverall()
{
    var result = await _repo.GetTeamOverall();
    return Ok(result);
}
  [HttpGet("teamRegular")]
public async Task<IActionResult> GetTeamRegular()
{
    var result = await _repo.GetTeamRegular();
    return Ok(result);
}
}