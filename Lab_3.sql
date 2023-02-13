-- a)
Create PROCEDURE V1
AS
ALTER TABLE Abilities
ALTER COLUMN AbType char(1);
GO

Create PROCEDURE REV1
AS
ALTER TABLE Abilities
ALTER COLUMN AbType Varchar(10);
GO

--b)
CREATE PROCEDURE V2
AS
ALTER TABLE Partners
ADD Website VARCHAR(50);
GO

CREATE PROCEDURE REV2
AS
ALTER TABLE Partners
DROP COLUMN Website;
GO

--c)
CREATE PROCEDURE V3
AS
ALTER TABLE Players
ADD CONSTRAINT df_Role
DEFAULT 'Mid' FOR pRole;
GO

CREATE PROCEDURE REV3
AS
ALTER TABLE Players
DROP CONSTRAINT df_Role;
GO

--d)

CREATE PROCEDURE REV4
AS
ALTER TABLE Is_Partner
ADD CONSTRAINT PK__Is_Partn__3605A4F99EDB830E PRIMARY KEY (tid,Paid);
GO

CREATE PROCEDURE V4
AS
ALTER TABLE Is_Partner
DROP CONSTRAINT PK__Is_Partn__3605A4F99EDB830E;
GO

--e)
CREATE PROCEDURE V5
AS
--ALTER TABLE Players
--ALTER COLUMN pNickname varchar(40) NOT NULL;
ALTER TABLE Players
ADD CONSTRAINT UQ_Nickname UNIQUE (pNickname);

GO

CREATE PROCEDURE REV5
AS
--ALTER TABLE Players
--ALTER COLUMN pNickname varchar(40) NULL;
ALTER TABLE Players
DROP CONSTRAINT UQ_Nickname;
GO

--f)
CREATE PROCEDURE V6
AS
ALTER TABLE Teams
DROP CONSTRAINT FK_Owner;
GO


CREATE  PROCEDURE REV6
AS
ALTER TABLE Teams
ADD CONSTRAINT FK_Owner
FOREIGN KEY (oid) REFERENCES Owners(oid);
GO

--g)

CREATE PROCEDURE V7
AS
DROP TABLE Owners;
GO

CREATE PROCEDURE REV7
AS
CREATE TABLE Owners(
oid int primary key,
oName varchar(30) UNIQUE NOT NULL,
oDob Date,
oEmail varchar(20));
INSERT INTO Owners(oid,oName,oEmail,oDob)
values (1,'Carlos Rodriguez','carlos.r@gmail.com','1993-04-12')
INSERT INTO Owners(oid,oName,oEmail,oDob)
values (2,'Miguel Kostache','miguel.k@gmail.com','1991-03-02')
GO

INSERT INTO Players(pid,pNickname,pTeam,pRole,pRealName,pNationality,pDob)
values(214,'Clap & nap',7,Default,'Dunca Raul','Romania','2003-05-26')


EXEC V5
EXEC REV5
EXEC AddWebsitePartners
EXEC RemWebsitePartners
EXEC AddDefaultConst
EXEC RemoveDefaultConst
EXEC RemovePKIsPartner
EXEC AddPKIsPartner
EXEC AddCandidateKeyPlayers
EXEC RemCandidateKeyPlayers
EXEC DeleteOwnersFK
EXEC AddOwnersFK
EXEC CreateTableOwners
EXEC DeleteTableOwners

CREATE TABLE VersionDB
(
current_version int PRIMARY KEY,
)

--CREATE TABLE ALLVersions
--(
	
--)


ALTER PROCEDURE goToVersion(@version INT)
AS

IF @version <0 OR @version>7
BEGIN
 RAISERROR ('Invalid version number',11,1)

END
ELSE
	BEGIN
	DECLARE @crtVersion INT;
	SET @crtVersion =(SELECT current_version           
	FROM VersionDB
	)

	

	WHILE @version<@crtVersion
		BEGIN
			EXEC ('REV'+@crtVersion)
			SET @crtVersion=@crtVersion-1;
		END

		WHILE @version>@crtVersion
		BEGIN
			SET @crtVersion=@crtVersion+1;
			EXEC ('V'+@crtVersion)
	
		END
	UPDATE VersionDB
	SET current_version = @version 
END
GO

INSERT INTO VersionDB(current_version)
VALUES (0)


EXEC goToVersion 0

SELECT * FROM VersionDB
SELECT * FROM Teams
SELECT * FROM Owners
SELECT * FROM Partners
SELECT * FROM Is_Partner
SELECT * FROM Players
SELECT * FROM Coaches
SELECT * FROM Leagues
SELECT * FROM Champions
SELECT * FROM Match_Details
SELECT * FROM Matches
SELECT * FROM Abilities
SELECT * FROM Champions