USE SoccerDB;
GO

CREATE VIEW ViewFixtureResults AS
SELECT
    Fixture.FixtureID,
    Team.Name AS TeamName,
    Opponent.Name AS OpponentName,
    Fixture.Date,
    CASE
        WHEN Result.GoalsFor > Result.GoalsAgainst THEN 'Win'
        WHEN Result.GoalsFor < Result.GoalsAgainst THEN 'Loss'
        ELSE 'Draw'
    END AS Result
FROM
    dbo.Fixture Fixture
JOIN
    [dbo].Team Team ON Fixture.TeamID = Team.TeamID
JOIN
    [dbo].Team Opponent ON Fixture.OpponentID = Opponent.TeamID
LEFT JOIN
    [dbo].Result Result ON Fixture.FixtureID = Result.ResultID;
GO