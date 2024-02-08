USE master;
GO

ALTER DATABASE [SoccerDB] SET SINGLE_USER WITH ROLLBACK IMMEDIATE

DROP DATABASE IF EXISTS [SoccerDB];

CREATE DATABASE SoccerDB;
GO

USE SoccerDB;
GO

CREATE TABLE [dbo].[StaffCode] (
    [StaffCodeID] [int] IDENTITY(1,1) PRIMARY KEY NOT NULL,
    [StaffCodeType] [varchar](120) NOT NULL
);
GO

CREATE TABLE [dbo].[Staff] (
    [StaffID] [int] IDENTITY(1,1) PRIMARY KEY NOT NULL,
    [StaffCode] [int] NOT NULL,
    [Name] [varchar](120) NOT NULL,
    [Surname] [varchar](120) NOT NULL,

    FOREIGN KEY (StaffCode) REFERENCES [dbo].StaffCode(StaffCodeID)
);
GO

CREATE TABLE [dbo].[Team] (
    [TeamID] [int] IDENTITY(1,1) PRIMARY KEY NOT NULL,
    [StaffID] [int] NOT NULL,
    [Name] [varchar](120) NOT NULL,

    FOREIGN KEY (StaffID) REFERENCES [dbo].Staff(StaffID)
);
GO

CREATE TABLE [dbo].[PositionCode] (
    [PositionID] [int] IDENTITY(1,1) PRIMARY KEY NOT NULL,
    [PositionName] [varchar](120) NOT NULL
);
GO

CREATE TABLE [dbo].[Player] (
    [PlayerID] [int] IDENTITY(1,1) PRIMARY KEY NOT NULL,
    [PositionID] [int] NOT NULL, 
    [Name] [varchar](120) NOT NULL,
    [Surname] [varchar](120) NOT NULL,
    [DateOfBirth] [date] NULL,

    FOREIGN KEY (PositionID) REFERENCES [dbo].PositionCode(PositionID)
);
GO

CREATE TABLE [dbo].[Fixture] (
    [FixtureID] [int] IDENTITY(1,1) PRIMARY KEY NOT NULL,
    [TeamID] [int] NOT NULL, 
    [Opponent] [varchar](120) NOT NULL,
    [Away] [bit] NOT NULL,
    [Date] [datetime2] NULL,

    FOREIGN KEY (TeamID) REFERENCES [dbo].Team(TeamID)
);
GO

CREATE TABLE [dbo].[Result] (
    [ResultID] [int] PRIMARY KEY NOT NULL,
    [GoalsFor] [int] NOT NULL, 
    [GoalsAgainst] [int] NOT NULL,

    FOREIGN KEY (ResultID) REFERENCES [dbo].Fixture(FixtureID)
);
GO

CREATE TABLE [dbo].[PlayerFixtureStats] (
    [PlayerFixtureStatsID] [int] IDENTITY(1, 1) PRIMARY KEY NOT NULL,
    [PlayerID] [int] NOT NULL, 
    [FixtureID] [int] NOT NULL, 
    [Saves] [int] NOT NULL,
    [Assists] [int] NOT NULL,
    [Goals] [int] NOT NULL,
    [Tackles] [int] NOT NULL,
    [YellowCards] [int] NOT NULL,
    [RedCards] [int] NOT NULL,
    [Fouls] [int] NOT NULL,

    FOREIGN KEY (PlayerID) REFERENCES [dbo].Player(PlayerID),
    FOREIGN KEY (FixtureID) REFERENCES [dbo].Fixture(FixtureID)
);
GO