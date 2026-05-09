USE shl;
GO

INSERT INTO GoalieStats
    (
    PlayerId,
    Season,
    Competition,
    GamesPlayed,
    GoalsAgainstAverage,
    GoalsAgainst,
    SavePercentage,
    Shutouts,
    Saves
    )
SELECT
    p.PlayerId,
    '25/26',
    CASE 
        WHEN gs.Season = 'Regular' THEN 'Regular'
        ELSE 'Playoff'
    END,
    TRY_CAST(gs.GamesPlayed AS INT),
    TRY_CAST(gs.GoalsAgainstAverage AS DECIMAL(5,2)),
    TRY_CAST(gs.GoalsAgainst AS INT),
    TRY_CAST(gs.SavePercentage AS DECIMAL(5,2)),
    TRY_CAST(gs.Shutouts AS INT),
    TRY_CAST(gs.Saves AS INT)
FROM (
    VALUES

-- SKELLEFTEÅ
('Linus','Söderström','Skellefteå AIK',5,2.38,8,90.70,1,78,'Regular'),
('Linus','Söderström','Skellefteå AIK',5,1.20,6,94.00,2,94,'Playoff'),
('Jani','Lampinen','Skellefteå AIK',8,3.17,24,85.71,0,144,'Regular'),
('Strauss','Mann','Skellefteå AIK',42,1.93,80,91.35,10,845,'Regular'),
('Strauss','Mann','Skellefteå AIK',5,1.46,9,91.74,0,100,'Playoff'),
('Gustaf','Lindvall','Skellefteå AIK',0,0,0,0,0,0,'Regular'),
('Anton','Ringquist','Skellefteå AIK',0,0,0,0,0,0,'Regular'),

-- LULEÅ
('Joel','Lassinantti','Luleå HF',20,2.61,51,88.96,2,411,'Regular'),
('Joel','Lassinantti','Luleå HF',2,6.69,6,76.92,0,20,'Playoff'),
('Matteus','Ward','Luleå HF',33,2.36,76,89.28,2,633,'Regular'),
('Matteus','Ward','Luleå HF',14,2.10,32,92.06,1,371,'Playoff'),
('Isak','Sörqvist','Luleå HF',0,0,0,0,0,0,'Regular'),

-- FRÖLUNDA
('Tobias','Normann','Frölunda HC',24,1.68,40,92.34,3,482,'Regular'),
('Tobias','Normann','Frölunda HC',5,1.33,7,92.13,1,82,'Playoff'),
('Lars','Johansson','Frölunda HC',28,2.13,60,90.84,1,595,'Regular'),
('Lars','Johansson','Frölunda HC',1,2.04,4,90.24,0,37,'Playoff'),
('Hugo','Laring','Frölunda HC',0,0,0,0,0,0,'Regular'),

-- VÄXJÖ
('Ludvig','Persson','Växjö Lakers',22,2.71,56,88.06,2,413,'Regular'),
('Ludvig','Persson','Växjö Lakers',3,4.27,10,82.14,0,46,'Playoff'),
('Adam','Åhman','Växjö Lakers',32,2.18,69,90.71,3,674,'Regular'),
('Adam','Åhman','Växjö Lakers',9,2.75,21,89.45,0,178,'Playoff'),
('Oliver','Håkanson','Växjö Lakers',0,0,0,0,0,0,'Regular'),

-- RÖGLE
('Christoffer','Rifalk','Rögle BK',19,1.76,32,91.11,1,328,'Regular'),
('Christoffer','Rifalk','Rögle BK',2,3.88,8,82.61,0,38,'Playoff'),
('Arvid','Holm','Rögle BK',35,2.33,80,89.16,4,658,'Regular'),
('Arvid','Holm','Rögle BK',10,1.71,17,92.48,1,209,'Playoff'),

-- FÄRJESTAD
('Måns','Goos','Färjestad BK',1,12.24,NULL,0.50,0,1,'Regular'),
('Emil','Larmi','Färjestad BK',37,2.31,77,89.92,2,687,'Regular'),
('Emil','Larmi','Färjestad BK',6,2.56,22,90.84,1,119,'Playoff'),
('Melker','Thelin','Färjestad BK',21,2.36,44,89.91,2,392,'Regular'),
('Melker','Thelin','Färjestad BK',4,3.52,8,84.91,0,45,'Playoff'),

-- BRYNÄS
('Erik','Källgren','Brynäs IF',15,2.06,30,90.35,2,281,'Regular'),
('Erik','Källgren','Brynäs IF',3,4.41,13,73.47,0,36,'Playoff'),
('Damian','Clara','Brynäs IF',33,2.52,NULL,88.70,NULL,638,'Regular'),
('Damian','Clara','Brynäs IF',2,2.38,NULL,86.50,NULL,NULL,'Playoff'),
('Collin','Delia','Brynäs IF',6,3.87,NULL,79.10,NULL,83,'Regular'),

-- MALMÖ
('Oskar','Blomgren','Malmö Redhawks',21,2.50,52,91.14,2,535,'Regular'),
('Oskar','Blomgren','Malmö Redhawks',6,2.29,14,92.00,0,161,'Playoff'),
('Marek','Langhamer','Malmö Redhawks',28,2.75,74,90.33,2,691,'Regular'),
('Marek','Langhamer','Malmö Redhawks',2,1.89,4,95.18,0,79,'Playoff'),
('Daniel','Marmenlind','Malmö Redhawks',6,4.00,NULL,85.00,NULL,96,'Regular'),
('Axel','Göransson','Malmö Redhawks',0,0,0,0,0,0,'Regular'),

-- DJURGÅRDEN
('Hugo','Hävelid','Djurgårdens IF',5,5.98,5,78.26,0,90,'Regular'),
('Magnus','Hellberg','Djurgårdens IF',40,2.72,107,90.37,2,1004,'Regular'),
('Magnus','Hellberg','Djurgårdens IF',2,2.07,4,92.31,0,48,'Playoff'),
('Daniel','Marmenlind','Djurgårdens IF',6,4.00,17,84.96,0,96,'Regular'),
('Daniel','Marmenlind','Djurgårdens IF',1,1.74,2,93.75,0,30,'Playoff'),

-- ÖREBRO
('Jonas','Arntzen','Örebro HK',22,3.11,67,88.61,0,521,'Regular'),
('Jhonas','Enroth','Örebro HK',31,2.65,NULL,89.10,NULL,659,'Regular'),
('Jhonas','Enroth','Örebro HK',3,3.35,NULL,86.30,NULL,NULL,'Playoff'),
('Linus','Hägernäs','Örebro HK',0,0,0,0,0,0,'Regular'),

-- LINKÖPING
('Waltteri','Ignatjew','Linköping HC',39,2.66,94,89.37,2,790,'Regular'),
('Jesper','Myrenberg','Linköping HC',20,2.64,NULL,89.70,NULL,385,'Regular'),
('Noel','Massot','Linköping HC',0,0,0,0,0,0,'Regular'),

-- TIMRÅ
('Jacob','Johansson','Timrå IK',33,2.55,80,89.06,3,651,'Regular'),
('Tim','Juel','Timrå IK',22,2.65,NULL,88.80,NULL,426,'Regular'),
('Simon','Westling','Timrå IK',0,0,0,0,0,0,'Regular'),
('Carl','Lidö','Timrå IK',0,0,0,0,0,0,'Regular'),
('Max','Berglund','Timrå IK',0,0,0,0,0,0,'Regular'),

-- HV71
('Lassi','Lehtinen','HV71',22,3.29,63,86.76,2,413,'Regular'),
('Olof','Glifford','HV71',5,2.84,NULL,87.80,NULL,101,'Regular'),
('Felix','Sandström','HV71',19,3.07,58,88.78,0,459,'Regular'),
('Felix','Sandström','HV71',4,1.21,5,95.45,0,105,'Playoff'),
('Frederik','Dichow','HV71',10,2.40,NULL,91.20,NULL,227,'Regular'),

-- LEKSAND
('Marcus','Gidlöf','Leksands IF',26,2.96,73,89.20,3,603,'Regular'),
('Robin','Christoffersson','Leksands IF',6,2.81,17,89.24,0,141,'Regular'),
('Filip','Larsson','Leksands IF',7,2.06,NULL,91.70,NULL,143,'Regular'),
('Filip','Larsson','Leksands IF',4,2.20,NULL,90.30,NULL,NULL,'Playoff'),
('Jakob','Hellsten','Leksands IF',15,3.10,NULL,87.70,NULL,141,'Regular'),
('Viggo','Tamm','Leksands IF',0,0,0,0,0,0,'Regular')

) AS gs 
(
    FirstName, LastName, TeamName, GamesPlayed, GoalsAgainstAverage, GoalsAgainst,
    SavePercentage, Shutouts, Saves, Season
)
JOIN Team t ON t.Name = gs.TeamName
JOIN Players p 
    ON LOWER(TRIM(p.FirstName)) = LOWER(TRIM(gs.FirstName))
    AND LOWER(TRIM(p.LastName)) = LOWER(TRIM(gs.LastName))
    AND p.TeamId = t.TeamId
    AND p.Season = '25/26'
   WHERE NOT EXISTS (
    SELECT 1
    FROM GoalieStats gs2
    WHERE gs2.PlayerId = p.PlayerId
    AND gs2.Season = '25/26'
    AND gs2.Competition = 
        CASE 
            WHEN gs.Season = 'Regular' THEN 'Regular'
            ELSE 'Playoff'
        END );

UPDATE gs
SET Competition = 'Relegation'
FROM GoalieStats gs
JOIN Players p ON gs.PlayerId = p.PlayerId
JOIN Team t ON p.TeamId = t.TeamId
WHERE gs.Season = '25/26'
AND gs.Competition = 'Playoff'
AND t.Name IN ('HV71', 'Leksands IF');