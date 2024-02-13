--liquibase formatted sql
--changeset verushan:1

CREATE FUNCTION UdfGetMaxGoalCount (@Date DATE) 
RETURNS int 
AS 
BEGIN 
    DECLARE @maxValue int;

    SELECT @maxValue = CASE
        WHEN MAX(Result.[GoalsFor]) > MAX(Result.[GoalsAgainst]) THEN MAX(Result.[GoalsFor])
        ELSE MAX(Result.[GoalsAgainst])
        END
        FROM
        Result
        LEFT JOIN Fixture ON Fixture.[FixtureID] = Result.[FixtureID]
        WHERE CONVERT(DATE, Fixture.[Date]) = CONVERT(DATE, @Date);

    RETURN @maxValue;
END;