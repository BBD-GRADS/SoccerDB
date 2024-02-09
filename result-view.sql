USE SoccerDB;
GO

ALTER VIEW FixtureResults AS
SELECT
    f.FixtureID,
    t.Name AS TeamName,
    f.Opponent,
    f.Date,
    CASE
        WHEN r.GoalsFor > r.GoalsAgainst THEN 'Win'
        WHEN r.GoalsFor < r.GoalsAgainst THEN 'Loss'
        ELSE 'Draw'
    END AS Result
FROM
    dbo.Fixture f
JOIN
    dbo.Team t ON f.TeamID = t.TeamID
LEFT JOIN
    dbo.Result r ON f.FixtureID = r.ResultID;
GO

-- view the db
SELECT * FROM dbo.FixtureResults;