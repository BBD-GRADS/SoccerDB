--liquibase formatted sql
--changeset verushan:1

CREATE FUNCTION UdfGetTeamTally (@TeamID int) RETURNS TABLE AS RETURN
SELECT
    Team.[Name],
    COUNT(
        CASE
            WHEN GoalsFor > GoalsAgainst THEN 1
            WHEN (
                Fixture.[OpponentID] = @TeamID
                AND GoalsAgainst > GoalsFor
            ) THEN 1
        END
    ) AS Wins,
    COUNT(
        CASE
            WHEN GoalsFor < GoalsAgainst THEN 1
            WHEN (
                Fixture.[OpponentID] = @TeamID
                AND GoalsAgainst < GoalsFor
            ) THEN 1
        END
    ) AS Losses,
    COUNT(
        CASE
            WHEN Result.[GoalsFor] = Result.[GoalsAgainst] THEN 1
            WHEN (
                Fixture.[OpponentID] = @TeamID
                AND GoalsAgainst = GoalsFor
            ) THEN 1
        END
    ) AS Draws
FROM
    Team,
    Fixture
    LEFT JOIN Result ON Fixture.[FixtureID] = Result.[FixtureID]
WHERE
    Team.[TeamID] = @TeamID
    AND (
        Fixture.[TeamID] = @TeamID
        OR Fixture.[OpponentID] = @TeamID
    )
    AND YEAR(Fixture.Date) = YEAR(GETDATE())
GROUP BY
    Team.[Name];