--liquibase formatted sql
--changeset verushan:1
CREATE TABLE [dbo].[Team] (
    [TeamID] [int] IDENTITY(1, 1) PRIMARY KEY NOT NULL,
    [Name] [varchar](120) NOT NULL,
    [IsOurClub] [bit] NOT NULL DEFAULT 1
);

CREATE TABLE [dbo].[StaffCode] (
    [StaffCodeID] [int] IDENTITY(1, 1) PRIMARY KEY NOT NULL,
    [StaffCodeType] [varchar](120) NOT NULL
);

CREATE TABLE [dbo].[Staff] (
    [StaffID] [int] IDENTITY(1, 1) PRIMARY KEY NOT NULL,
    [StaffCodeID] [int] NOT NULL,
    [TeamID] [int] NOT NULL,
    [Name] [varchar](120) NOT NULL,
    [Surname] [varchar](120) NOT NULL,
    FOREIGN KEY (TeamID) REFERENCES [dbo].Team(TeamID),
    FOREIGN KEY (StaffCodeID) REFERENCES [dbo].StaffCode(StaffCodeID)
);

CREATE TABLE [dbo].[PositionCode] (
    [PositionID] [int] IDENTITY(1, 1) PRIMARY KEY NOT NULL,
    [PositionName] [varchar](120) NOT NULL
);

CREATE TABLE [dbo].[Player] (
    [PlayerID] [int] IDENTITY(1, 1) PRIMARY KEY NOT NULL,
    [PositionCodeID] [int] NOT NULL,
    [TeamID] [int] NOT NULL,
    [Name] [varchar](120) NOT NULL,
    [Surname] [varchar](120) NOT NULL,
    [DateOfBirth] [date] NULL,
    FOREIGN KEY (PositionCodeID) REFERENCES [dbo].PositionCode(PositionID),
    FOREIGN KEY (TeamID) REFERENCES [dbo].Team(TeamID),
    CONSTRAINT ChkDatePast CHECK (
        [DateOfBirth] < GETDATE()
        OR [DateOfBirth] IS NULL
    )
);

CREATE TABLE [dbo].[Fixture] (
    [FixtureID] [int] IDENTITY(1, 1) PRIMARY KEY NOT NULL,
    [TeamID] [int] NOT NULL,
    [OpponentID] [int] NOT NULL,
    [Away] [bit] NOT NULL,
    [Date] [datetime2] NULL,
    FOREIGN KEY (TeamID) REFERENCES [dbo].Team(TeamID),
    FOREIGN KEY (OpponentID) REFERENCES [dbo].Team(TeamID)
);

CREATE TABLE [dbo].[Result] (
    [ResultID] [int] IDENTITY(1, 1) PRIMARY KEY NOT NULL,
    [FixtureID] [int] NOT NULL,
    [GoalsFor] [int] NOT NULL DEFAULT 0,
    [GoalsAgainst] [int] NOT NULL DEFAULT 0,
    FOREIGN KEY (FixtureID) REFERENCES [dbo].Fixture(FixtureID),
    CONSTRAINT ChkPositiveGoalsFor CHECK ([GoalsFor] >= 0),
    CONSTRAINT ChkPositiveGoalsAgainst CHECK ([GoalsAgainst] >= 0),
    CONSTRAINT UniqueFixtureConstraint UNIQUE (FixtureID)
);

CREATE TABLE [dbo].[PlayerFixtureStats] (
    [PlayerFixtureStatsID] [int] IDENTITY(1, 1) PRIMARY KEY NOT NULL,
    [PlayerID] [int] NOT NULL,
    [FixtureID] [int] NOT NULL,
    [Saves] [int] NOT NULL DEFAULT 0,
    [Assists] [int] NOT NULL DEFAULT 0,
    [Goals] [int] NOT NULL DEFAULT 0,
    [Tackles] [int] NOT NULL DEFAULT 0,
    [YellowCards] [int] NOT NULL DEFAULT 0,
    [RedCards] [int] NOT NULL DEFAULT 0,
    [Fouls] [int] NOT NULL DEFAULT 0,
    [GameTimeInMinutes] [int] NOT NULL DEFAULT 0,
    FOREIGN KEY (PlayerID) REFERENCES [dbo].Player(PlayerID),
    FOREIGN KEY (FixtureID) REFERENCES [dbo].Fixture(FixtureID),
    
    CONSTRAINT UniqueFixturePlayerConstraint UNIQUE (PlayerID, FixtureID),
    CONSTRAINT ChkPositiveSaves CHECK ([Saves] >= 0),
    CONSTRAINT ChkPositiveAssists CHECK ([Assists] >= 0),
    CONSTRAINT ChkPositiveGoals CHECK ([Goals] >= 0),
    CONSTRAINT ChkPositiveTackles CHECK ([Tackles] >= 0),
    CONSTRAINT ChkPositiveYellowCards CHECK ([YellowCards] >= 0),
    CONSTRAINT ChkPositiveRedCards CHECK ([RedCards] >= 0),
    CONSTRAINT ChkPositiveFouls CHECK ([Fouls] >= 0),
    CONSTRAINT ChkPositiveGameTime CHECK ([GameTimeInMinutes] >= 0)
);

--changeset verushan:2
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
    I.FixtureID,
    I.GoalsFor,
    I.GoalsAgainst
FROM
    Inserted I
END
END;

--changeset verushan:3
CREATE TRIGGER TrgPlayerStatsInsert ON PlayerFixtureStats INSTEAD OF
INSERT
    AS BEGIN IF EXISTS (
        SELECT
            1
        FROM
            Inserted PlayerStat
            INNER JOIN Fixture ON PlayerStat.FixtureID = Fixture.FixtureID
        WHERE
            Fixture.Date >= GETDATE()
    ) BEGIN RAISERROR (
        'Cannot insert a stats for a player that belongs to a fixture in the future.',
        1,
        1
    );

END
ELSE BEGIN
INSERT INTO
    PlayerFixtureStats (
        PlayerID,
        FixtureID,
        Saves,
        Assists,
        Goals,
        Tackles,
        YellowCards,
        RedCards,
        Fouls,
        GameTimeInMinutes
    )
SELECT
    I.PlayerID,
    I.FixtureID,
    I.Saves,
    I.Assists,
    I.Goals,
    I.Tackles,
    I.YellowCards,
    I.RedCards,
    I.Fouls,
    I.GameTimeInMinutes
FROM
    Inserted I
END
END;