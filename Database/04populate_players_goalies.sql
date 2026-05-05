
USE shl;
GO

DECLARE @Skelleftea UNIQUEIDENTIFIER = (SELECT TeamId FROM Team WHERE Name = 'Skellefteå AIK');
DECLARE @Vaxjo UNIQUEIDENTIFIER = (SELECT TeamId FROM Team WHERE Name = 'Växjö Lakers');
DECLARE @Rogle UNIQUEIDENTIFIER = (SELECT TeamId FROM Team WHERE Name = 'Rögle BK');
DECLARE @Brynas UNIQUEIDENTIFIER = (SELECT TeamId FROM Team WHERE Name = 'Brynäs IF');
DECLARE @Frolunda UNIQUEIDENTIFIER = (SELECT TeamId FROM Team WHERE Name = 'Frölunda HC');
DECLARE @Linkoping UNIQUEIDENTIFIER = (SELECT TeamId FROM Team WHERE Name = 'Linköping HC');
DECLARE @Leksand UNIQUEIDENTIFIER = (SELECT TeamId FROM Team WHERE Name = 'Leksands IF');
DECLARE @Malmo UNIQUEIDENTIFIER = (SELECT TeamId FROM Team WHERE Name = 'Malmö Redhawks');
DECLARE @Lulea UNIQUEIDENTIFIER = (SELECT TeamId FROM Team WHERE Name = 'Luleå HF');
DECLARE @HV71 UNIQUEIDENTIFIER = (SELECT TeamId FROM Team WHERE Name = 'HV71');
DECLARE @Timra UNIQUEIDENTIFIER = (SELECT TeamId FROM Team WHERE Name = 'Timrå IK');
DECLARE @Orebro UNIQUEIDENTIFIER = (SELECT TeamId FROM Team WHERE Name = 'Örebro HK');
DECLARE @Djurgarden UNIQUEIDENTIFIER = (SELECT TeamId FROM Team WHERE Name = 'Djurgårdens IF');
DECLARE @Farjestad UNIQUEIDENTIFIER = (SELECT TeamId FROM Team WHERE Name = 'Färjestad BK');

INSERT INTO players (FirstName, LastName, TeamId, Position, Nationality, Season, GamesPlayed)
VALUES
('Jani', 'Lampinen', @Skelleftea, 'Målvakt', 'Finland', '25/26', 8),
('Strauss', 'Mann', @Skelleftea, 'Målvakt', 'USA', '25/26', 42),
('Linus', 'Söderström', @Skelleftea, 'Målvakt', 'Sverige', '25/26', 5),
('Gustaf', 'Lindvall', @Skelleftea, 'Målvakt', 'Sverige', '25/26', 0),
('Anton', 'Ringquist', @Skelleftea, 'Målvakt', 'Sverige', '25/26', 0),
('Tobias', 'Normann', @Frolunda, 'Målvakt', 'Norge', '25/26', 24),
('Lars', 'Johansson', @Frolunda, 'Målvakt', 'Sverige', '25/26', 28),
('Hugo', 'Laring', @Frolunda, 'Målvakt', 'Sverige', '25/26', 0),
('Adam', 'Åhman', @Vaxjo, 'Målvakt', 'Sverige', '25/26', 32),
('Ludvig', 'Persson', @Vaxjo, 'Målvakt', 'Sverige', '25/26', 22),
('Oliver', 'Håkanson', @Vaxjo, 'Målvakt', 'Sverige', '25/26', 0),
('Christoffer', 'Rifalk', @Rogle, 'Målvakt', 'Sverige', '25/26', 19),
('Arvid', 'Holm', @Rogle, 'Målvakt', 'Sverige', '25/26', 35),
('Melker', 'Thelin', @Farjestad, 'Målvakt', 'Sverige', '25/26', 21),
('Emil', 'Larmi', @Farjestad, 'Målvakt', 'Finland', '25/26', 37),
('Måns', 'Goos', @Farjestad, 'Målvakt', 'Sverige', '25/26', 1),
('Erik', 'Källgren', @Brynas, 'Målvakt', 'Sverige', '25/26', 15),
('Damian', 'Clara', @Brynas, 'Målvakt', 'Italien', '25/26', 33),
('Collin', 'Delia', @Brynas, 'Målvakt', 'USA', '25/26', 6),
('Matteus', 'Ward', @Lulea, 'Målvakt', 'Sverige', '25/26', 33),
('Joel', 'Lassinantti', @Lulea, 'Målvakt', 'Sverige', '25/26', 20),
('Isak', 'Sörqvist', @Lulea, 'Målvakt', 'Sverige', '25/26', 0),
('Oskar', 'Blomgren', @Malmo, 'Målvakt', 'Sverige', '25/26', 21),
('Marek', 'Langhamer', @Malmo, 'Målvakt', 'Tjeckien', '25/26', 28),
('Daniel', 'Marmenlind', @Malmo, 'Målvakt', 'Sverige', '25/26', 6),
('Axel', 'Göransson', @Malmo, 'Målvakt', 'Sverige', '25/26', 0),
('Magnus', 'Hellberg', @Djurgarden, 'Målvakt', 'Sverige', '25/26', 40),
('Daniel', 'Marmenlind', @Djurgarden, 'Målvakt', 'Sverige', '25/26', 9),
('Hugo', 'Hävelid', @Djurgarden, 'Målvakt', 'Sverige', '25/26', 5),
('Marcus', 'Brännman', @Djurgarden, 'Målvakt', 'Sverige', '25/26', 0),
('Hugo', 'Severgårdh', @Djurgarden, 'Målvakt', 'Sverige', '25/26', 0),
('Jhonas', 'Enroth', @Orebro, 'Målvakt', 'Sverige', '25/26', 31),
('Jonas', 'Arntzen', @Orebro, 'Målvakt', 'Norge', '25/26', 22),
('Linus', 'Hägernäs', @Orebro, 'Målvakt', 'Sverige', '25/26', 0),
('Jesper', 'Myrenberg', @Linkoping, 'Målvakt', 'Sverige', '25/26', 20),
('Waltteri', 'Ignatjew', @Linkoping, 'Målvakt', 'Finland', '25/26', 39),
('Noel', 'Massot', @Linkoping, 'Målvakt', 'Sverige', '25/26', 0),
('Jacob', 'Johansson', @Timra, 'Målvakt', 'Sverige', '25/26', 33),
('Tim', 'Juel', @Timra, 'Målvakt', 'Sverige', '25/26', 22),
('Simon', 'Westling', @Timra, 'Målvakt', 'Sverige', '25/26', 0),
('Carl', 'Lidö', @Timra, 'Målvakt', 'Sverige', '25/26', 0),
('Max', 'Berglund', @Timra, 'Målvakt', 'Sverige', '25/26', 0),
('Frederik', 'Dichow', @HV71, 'Målvakt', 'Danmark', '25/26', 10),
('Felix', 'Sandström', @HV71, 'Målvakt', 'Sverige', '25/26', 19),
('Olof', 'Glifford', @HV71, 'Målvakt', 'Sverige', '25/26', 5),
('Lassi', 'Lehtinen', @HV71, 'Målvakt', 'Finland', '25/26', 22),
('Filip', 'Larsson', @Leksand, 'Målvakt', 'Sverige', '25/26', 7),
('Marcus', 'Gidlöf', @Leksand, 'Målvakt', 'Sverige', '25/26', 26),
('Robin', 'Christoffersson', @Leksand, 'Målvakt', 'Sverige', '25/26', 6),
('Jakob', 'Hellsten', @Leksand, 'Målvakt', 'Sverige', '25/26', 15),
('Viggo', 'Tamm', @Leksand, 'Målvakt', 'Sverige', '25/26', 0);
GO