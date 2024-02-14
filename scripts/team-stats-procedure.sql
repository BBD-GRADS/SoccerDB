--liquibase formatted sql
--changeset faheemah:1

CREATE PROCEDURE ProcGetTeamStats
AS
BEGIN
    SELECT
        t.Name AS TeamName,
        COUNT(f.FixtureID) AS MP,
        SUM(CASE WHEN t.TeamID = f.TeamID AND r.GoalsFor > r.GoalsAgainst THEN 1
                 WHEN t.TeamID = f.OpponentID AND r.GoalsAgainst > r.GoalsFor THEN 1
                 ELSE 0 END) AS W,
        SUM(CASE WHEN t.TeamID = f.TeamID AND r.GoalsFor < r.GoalsAgainst THEN 1
                 WHEN t.TeamID = f.OpponentID AND r.GoalsAgainst < r.GoalsFor THEN 1
                 ELSE 0 END) AS L,
        SUM(CASE WHEN r.GoalsFor = r.GoalsAgainst THEN 1 ELSE 0 END) AS D,
        SUM(CASE WHEN t.TeamID = f.TeamID THEN r.GoalsFor
                 WHEN t.TeamID = f.OpponentID THEN r.GoalsAgainst
                 ELSE 0 END) AS GF,
        SUM(CASE WHEN t.TeamID = f.TeamID THEN r.GoalsAgainst
                 WHEN t.TeamID = f.OpponentID THEN r.GoalsFor
                 ELSE 0 END) AS GA,
        SUM(CASE WHEN (t.TeamID = f.TeamID AND r.GoalsFor > r.GoalsAgainst) OR
                      (t.TeamID = f.OpponentID AND r.GoalsAgainst > r.GoalsFor) THEN 3
                 WHEN r.GoalsFor = r.GoalsAgainst THEN 1
                 ELSE 0 END) AS Pts
    FROM
        dbo.Team t
    LEFT JOIN
        dbo.Fixture f ON t.TeamID IN (f.TeamID, f.OpponentID)
    LEFT JOIN
        dbo.Result r ON f.FixtureID = r.FixtureID
    GROUP BY
        t.TeamID, t.Name
    ORDER BY
        Pts DESC
END;

--changeset verushan:1

ALTER PROCEDURE ProcGetTeamStats
AS
BEGIN
    SELECT
        t.Name AS TeamName,
        COUNT(CASE WHEN f.Date <= GETDATE() THEN 1 END) AS MP,
        ISNULL(SUM(CASE WHEN t.TeamID = f.TeamID AND r.GoalsFor > r.GoalsAgainst THEN 1
                 WHEN t.TeamID = f.OpponentID AND r.GoalsAgainst > r.GoalsFor THEN 1
                 ELSE 0 END), 0) AS W,
        ISNULL(SUM(CASE WHEN t.TeamID = f.TeamID AND r.GoalsFor < r.GoalsAgainst THEN 1
                 WHEN t.TeamID = f.OpponentID AND r.GoalsAgainst < r.GoalsFor THEN 1
                 ELSE 0 END), 0) AS L,
        ISNULL(SUM(CASE WHEN r.GoalsFor = r.GoalsAgainst THEN 1 ELSE 0 END), 0) AS D,
        ISNULL(SUM(CASE WHEN t.TeamID = f.TeamID THEN r.GoalsFor
                 WHEN t.TeamID = f.OpponentID THEN r.GoalsAgainst
                 ELSE 0 END), 0) AS GF,
        ISNULL(SUM(CASE WHEN t.TeamID = f.TeamID THEN r.GoalsAgainst
                 WHEN t.TeamID = f.OpponentID THEN r.GoalsFor
                 ELSE 0 END), 0) AS GA,
        ISNULL(SUM(CASE WHEN (t.TeamID = f.TeamID AND r.GoalsFor > r.GoalsAgainst) OR
                      (t.TeamID = f.OpponentID AND r.GoalsAgainst > r.GoalsFor) THEN 3
                 WHEN r.GoalsFor = r.GoalsAgainst THEN 1
                 ELSE 0 END), 0) AS Pts
    FROM
        dbo.Team t
    LEFT JOIN
        dbo.Fixture f ON t.TeamID IN (f.TeamID, f.OpponentID)
    LEFT JOIN
        dbo.Result r ON f.FixtureID = r.FixtureID
    GROUP BY
        t.TeamID, t.Name
    ORDER BY
        Pts DESC
END;