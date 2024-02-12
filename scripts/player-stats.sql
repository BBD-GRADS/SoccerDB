USE SoccerDB;

SELECT
    Player.[PlayerID],
    Player.[Name],
    (
        SUM(PlayerFixtureStats.[Assists]) + 
        SUM(PlayerFixtureStats.[Goals]) +
        SUM(PlayerFixtureStats.[Tackles]) +
        SUM(PlayerFixtureStats.[YellowCards]) +
        SUM(PlayerFixtureStats.[RedCards]) -
        SUM(PlayerFixtureStats.[Fouls])
    ) AS [SeasonScore]
FROM
    Player
    LEFT JOIN PlayerFixtureStats ON Player.[PlayerID] = PlayerFixtureStats.[PlayerID]
GROUP BY Player.[PlayerID], Player.[Name]