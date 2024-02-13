--liquibase formatted sql
--changeset verushan:1

CREATE VIEW ViewUpcomingMatches AS
SELECT TOP(100) PERCENT
    Fixture.[FixtureID],
    Team.[Name] AS TeamName,
    Opponent.[Name] AS OpponentName,
    FORMAT(Fixture.[Date], 'dddd, dd MMM yyyy ''at'' HH:mm') AS DateOfMatch
FROM
    Fixture
LEFT JOIN
    [dbo].Team Team ON Fixture.TeamID = Team.TeamID
LEFT JOIN
    [dbo].Team Opponent ON Fixture.OpponentID = Opponent.TeamID
LEFT JOIN
    [dbo].Result Result ON Fixture.FixtureID = Result.ResultID
WHERE
    Fixture.Date >= GETDATE();