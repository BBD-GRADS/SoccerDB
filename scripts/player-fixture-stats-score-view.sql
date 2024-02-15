--liquibase formatted sql
--changeset verushan:1

CREATE VIEW ViewPlayerFixtureScores AS
SELECT
    Player.[PlayerID],
    Player.[Name],
    Player.[Surname],
    PC.PositionName,
    T.TeamID,
    F.FixtureID,
    PFS.Saves,
    PFS.Assists,
    PFS.Goals,
    PFS.Tackles,
    PFS.YellowCards,
    PFS.RedCards,
    PFS.Fouls,
    PFS.GameTimeInMinutes,
    CASE
        WHEN PC.PositionID BETWEEN 12 AND 17 THEN
            PFS.Goals * 0.8 + PFS.Assists * 0.4 + PFS.Tackles * 0.3 + 
            PFS.Saves - PFS.Fouls * 0.4 - PFS.YellowCards * 0.6 - PFS.RedCards * 1.5
        WHEN PC.PositionID BETWEEN 7 AND 11 THEN
            PFS.Goals * 0.5 + PFS.Assists * 0.7 + PFS.Tackles * 0.4 + 
            PFS.Saves * 0.9 - PFS.Fouls * 0.4 - PFS.YellowCards * 0.6 - PFS.RedCards * 1.5
        WHEN PC.PositionID BETWEEN 2 AND 6 THEN
            PFS.Goals * 0.6 + PFS.Assists * 0.6 + PFS.Tackles * 0.8 + 
            PFS.Saves * 0.5 - PFS.Fouls * 0.3 - PFS.YellowCards * 0.7 - PFS.RedCards * 1.5
        WHEN PC.PositionID = 1 THEN
            PFS.Goals * 0.7 + PFS.Assists * 0.6 + PFS.Tackles * 0.3 + 
            PFS.Saves * 0.9 - PFS.Fouls * 0.5 - PFS.YellowCards * 0.5 - PFS.RedCards * 1.5
    END AS Score
FROM
    Player
RIGHT JOIN PositionCode PC ON Player.PositionCodeID = PC.PositionID
RIGHT JOIN Team T ON T.TeamID = Player.TeamID
RIGHT JOIN Fixture F ON F.TeamID = T.TeamID
RIGHT JOIN PlayerFixtureStats PFS ON Player.PlayerID = PFS.PlayerID AND F.FixtureID = PFS.FixtureID
WHERE
    YEAR([Date]) = YEAR(GETDATE());