DELETE 
FROM PlayerFixtureStats
FROM Fixture
LEFT JOIN PlayerFixtureStats ON PlayerFixtureStats.FixtureID = Fixture.FixtureID
WHERE Fixture.Date >= GETDATE();