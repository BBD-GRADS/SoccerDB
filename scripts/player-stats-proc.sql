--liquibase formatted sql
--changeset verushan:2

CREATE PROCEDURE ProcGetSeasonScore AS
SELECT
    Player.[PlayerID],
    Player.[Name],
    Player.[Surname],
    (
        SUM(PlayerFixtureStats.[Assists]) + 
        SUM(PlayerFixtureStats.[Goals]) + 
        SUM(PlayerFixtureStats.[Tackles]) + 
        SUM(PlayerFixtureStats.[YellowCards]) + 
        SUM(PlayerFixtureStats.[RedCards]) - 
        SUM(PlayerFixtureStats.[Fouls])
    ) AS [Season Score]
FROM
    Player
    LEFT JOIN PlayerFixtureStats ON PlayerFixtureStats.[PlayerID] = Player.[PlayerID]
    LEFT JOIN Fixture ON PlayerFixtureStats.[FixtureID] = Fixture.[FixtureID]
WHERE
    YEAR(Fixture.[Date]) = YEAR(GETDATE())
GROUP BY
    Player.[PlayerID],
    Player.[Name],
    Player.[Surname]
ORDER BY
    [Season Score] DESC;