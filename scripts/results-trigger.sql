--liquibase formatted sql
--changeset verushan:1

CREATE TRIGGER TrgResultsInsert ON Result INSTEAD OF
INSERT
    AS BEGIN IF EXISTS (
        SELECT
            1
        FROM
            Inserted InsertedResult
            INNER JOIN Fixture ON InsertedResult.FixtureID = Fixture.FixtureID
        WHERE
            Fixture.Date >= GETDATE()
    ) BEGIN
    RAISERROR (
        'Cannot insert the result for a fixture in the future.', 1, 1 
    );
END
ELSE BEGIN
INSERT INTO
    Result (FixtureID, GoalsFor, GoalsAgainst)
SELECT
    Inserted.FixtureId,
    Inserted.GoalsFor,
    Inserted.GoalsAgainst
FROM
    Inserted;
END
END;