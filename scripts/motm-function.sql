CREATE FUNCTION GetManOfTheMatch (@FixtureID INT)
RETURNS NVARCHAR(255)
AS
BEGIN
    DECLARE @Result NVARCHAR(255);

    SELECT TOP 1 @Result = p.Name + ' ' + p.Surname
    FROM ViewPlayerFixtureScores v
    INNER JOIN Player p ON v.PlayerID = p.PlayerID
    WHERE v.FixtureID = @FixtureID
    ORDER BY v.Score DESC;

    IF @Result IS NULL
        SET @Result = 'No player found for the given fixture';

    RETURN @Result;
END;
