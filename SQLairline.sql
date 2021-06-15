/**** Airline SQL Database ****/

CREATE DATABASE airline; 

USE airline;

DROP TABLE IF EXISTS Airport 
CREATE TABLE Airport( 
    Code CHAR(5) NOT NULL PRIMARY KEY,
    City VARCHAR(20), 
    State CHAR(5))

CREATE TABLE Flight(
    FLNO INT NOT NULL DEFAULT 0000,
    Meal VARCHAR(50) DEFAULT NULL,
    Smoking CHAR DEFAULT 'N',
    PRIMARY KEY (FLNO)
);

CREATE TABLE FlightInstance(
   FLNO INT NOT NULL,
   FDate VARCHAR(10) DEFAULT NULL)

CREATE TABLE PlaneType (
    Maker VARCHAR(50) NOT NULL DEFAULT '',
    Model VARCHAR(50) NOT NULL DEFAULT '',
    FlyingSpeed INT NOT NULL DEFAULT 0,
    GroundSpeed INT NOT NULL DEFAULT 0,
    PRIMARY KEY (Maker, Model)
);

CREATE TABLE PlaneSeats (
    Maker VARCHAR(50) NOT NULL DEFAULT '',
    Model VARCHAR(50) NOT NULL DEFAULT '',
    SeatType CHAR NOT NULL DEFAULT 'E',
    NoOfSeats INT NOT NULL DEFAULT 0,
    PRIMARY KEY (Maker, Model, SeatType),
    FOREIGN KEY (Maker, Model) REFERENCES PlaneType (Maker, Model)
);

CREATE TABLE Plane (
    ID INT NOT NULL DEFAULT 0,
    Maker VARCHAR(50) NOT NULL DEFAULT '',
    Model VARCHAR(50) NOT NULL DEFAULT '',
    LastMaint CHAR(3) NOT NULL DEFAULT '',
    LastMaintA CHAR(3) NOT NULL DEFAULT '',
    PRIMARY KEY (ID),
    FOREIGN KEY (Maker, Model) REFERENCES PlaneType (Maker, Model)
);

CREATE TABLE FlightLeg (
    FLNO INT NOT NULL DEFAULT 0000,
    Seq INT NOT NULL DEFAULT 0,
    FromA CHAR(3) NOT NULL DEFAULT '',
    ToA CHAR(3) NOT NULL DEFAULT '',
    DeptTime VARCHAR(16) DEFAULT NULL,
    ArrTime VARCHAR(16) DEFAULT NULL,
    Plane INT NOT NULL DEFAULT 0,
    PRIMARY KEY (FLNO, Seq)
);

CREATE TABLE Pilot (
    ID INT NOT NULL DEFAULT 0,
    Name VARCHAR(50) DEFAULT NULL,
    DateHired VARCHAR(10) DEFAULT NULL,
    PRIMARY KEY (ID)
);

CREATE TABLE FlightLegInstance (
    Seq INT NOT NULL DEFAULT 0,
    FLNO INT NOT NULL DEFAULT 0000,
    FDate VARCHAR(10) DEFAULT NULL,
    ActDept VARCHAR(16) DEFAULT NULL,
    ActArr VARCHAR(16) DEFAULT NULL,
    Pilot INT NOT NULL DEFAULT 0,
    PRIMARY KEY (Seq, FLNO, FDate)
);

CREATE TABLE Passenger (
    ID INT NOT NULL DEFAULT 0,
    Name VARCHAR(50) DEFAULT NULL,
    Phone CHAR(13) DEFAULT NULL,
    PRIMARY KEY (ID)
);

CREATE TABLE Reservation (
    PassID INT NOT NULL DEFAULT 0,
    FLNO INT NOT NULL DEFAULT 0000,
    FDate VARCHAR(10) DEFAULT NULL,
    FromA CHAR(3) NOT NULL DEFAULT '',
    ToA CHAR(3) NOT NULL DEFAULT '',
    SeatClass CHAR NOT NULL DEFAULT 'E',
    DateBooked VARCHAR(10) DEFAULT NULL,
    DateCanceled VARCHAR(10) DEFAULT NULL,
    PRIMARY KEY (PassID, FLNO, FDate)
);


INSERT INTO Airport  VALUES ('DFW', 'Dallas', 'TX'),
 ('LOG', 'Boston', 'MA'), ('ORD', 'Chicago', 'IL'), 
 ('MDW', 'Chicago', 'IL'),('JFK', 'New York', 'NY'), 
 ('LGA', 'New York', 'NY'),  ('INT', 'Houston', 'TX'), ('LAX', 'Los Angeles', 'CA');

INSERT INTO Flight
VALUES (1000, 'Bistro', 'Y'),
(1010, 'Meal', 'N'),
(1020, 'Meal', 'Y'),
(1040, 'Meal', 'N');

INSERT INTO FlightInstance VALUES (1000, '10/5/2002'),
(1000, '10/6/2002'),
(1000, '10/7/2002'),
(1010, '10/5/2002'),
(1010, '10/6/2002'),
(1020, '10/5/2002'),
(1030, '10/5/2002'),
(1040, '10/7/2002');

INSERT INTO PlaneType VALUES ('MD', 'MD11', 600, 180), 
('MD', 'SUPER80', 600, 180),
('BOEING', '727', 600, 180),
('BOEING', '757', 600, 180),
('AIRBUS', 'A300', 600, 180),
('AIRBUS', 'A320', 600, 180);

INSERT INTO PlaneSeats VALUES ('MD', 'MD11', 'F', 20),
('MD', 'MD11', 'E', 150),
('MD', 'SUPER80', 'F', 10),
('MD', 'SUPER80', 'E', 90),
('BOEING', '727', 'F', 10),
('BOEING', '727', 'E', 110);



INSERT INTO FlightLeg VALUES (1000, 1, 'DFW', 'LOG', '1/1/2001 10:20', '1/1/2001 13:40', 7),
(1010, 1, 'LAX', 'ORD', '1/1/2001 13:10', '1/1/2001 16:20', 3),
(1010, 2, 'ORD', 'JFK', '1/1/2001 17:10', '1/1/2001 20:20', 3),
(1020, 1, 'LOG', 'JFK', '1/1/2001 5:40', '1/1/2001 6:20', 9),
(1020, 2, 'JFK', 'DFW', '1/1/2001 7:20', '1/1/2001 10:20', 9),
(1020, 3, 'DFW', 'INT', '1/1/2001 11:10', '1/1/2001 11:40', 7),
(1020, 4, 'INT', 'LAX', '1/1/2001 12:20', '1/1/2001 15:10', 7),
(1030, 1, 'LAX', 'INT', '1/1/2001 11:20', '1/1/2001 16:10', 6),
(1030, 2, 'INT', 'DFW', '1/1/2001 17:20', '1/1/2001 18:00', 6),
(1040, 1, 'LAX', 'LGA', '1/1/2001 15:30', '1/1/2001 21:00', 1);

INSERT INTO  Pilot VALUES (1, 'Jones', '5/10/1990'),
(2, 'Adams', '6/1/1990'),
(3, 'Walker', '7/2/1991'),
(4, 'Flores', '4/1/1992'),
(5, 'Thompson', '4/10/1992'),
(6, 'Dean', '9/2/1993'),
(7, 'Carter', '8/1/1994'),
(8, 'Mango', '5/2/1995');

INSERT INTO FlightLegInstance VALUES (1, 1000, '10/5/2002', '1/1/2002 10:10', '1/1/2002 13:10', 3),
 (1, 1000, '10/6/2002', '1/1/2002 10:30', '1/1/2002 14:20', 8),
(1, 1010, '10/5/2002', '1/1/2002 13:20', '1/1/2002 17:10', 1),
(2, 1010, '10/5/2002', '1/1/2002 18:00', '1/1/2002 21:00', 1),
(1, 1010, '10/6/2002', '1/1/2002 13:10', '1/1/2002 16:10', 3),
(2, 1010, '10/6/2002', '1/1/2002 17:00', '1/1/2002 20:30', 6),
(1, 1020, '10/5/2002', '1/1/2002 5:40', '1/1/2002 6:30', 5),
(2, 1020, '10/5/2002', '1/1/2002 7:30', '1/1/2002 10:40', 5),
(3, 1020, '10/5/2002', '1/1/2002 11:30', '1/1/2002 12:20', 5),
(4, 1020, '10/5/2002', '1/1/2002 13:00', '1/1/2002 16:00', 2),
(1, 1030, '10/5/2002', '1/1/2002 11:20', '1/1/2002 16:10', 8),
(2, 1030, '10/5/2002', '1/1/2002 17:20', '1/1/2002 18:40', 8);


INSERT INTO Passenger VALUES (1, 'Jones', '(972)999-1111'),
 (2, 'James', '(214)111-9999'),
(3, 'Henry', '(972)222-1111'),
(4, 'Luis', '(972)111-3333'),
(5, 'Howard', '(972)333-1111'),
(6, 'Frank', '(214)111-5555'),
(7, 'Frankel', '(972)111-2222'),
(8, 'Bushnell', '(214)111-4444'),
(9, 'Camden', '(214)222-5555'),
(10, 'Max', '(972)444-1111'),
(11, 'Flores', '(214)333-6666'),
(12, 'Clinton', '(214)222-5555');

INSERT INTO Reservation (PassID, FLNO, FDate, FromA, ToA, SeatClass, DateBooked)
VALUES (1, 1000, '10/5/2002', 'DFW', 'LOG', 'E', '9/5/2002'),
(1, 1020, '10/5/2002', 'LOG', 'JFK', 'E', '9/14/2002'),
(2, 1020, '10/5/2002', 'LOG', 'INT', 'E', '9/4/2002'),
(3, 1020, '10/5/2002', 'JFK', 'LAX', 'E', '9/19/2002'),
(4, 1020, '10/5/2002', 'LOG', 'LAX', 'E', '9/10/2002'),
(5, 1020, '10/5/2002', 'LOG', 'DFW', 'F', '9/29/2002'),
(6, 1010, '10/5/2002', 'LAX', 'JFK', 'E', '9/19/2002'),
(7, 1010, '10/5/2002', 'LAX', 'ORD', 'E', '9/27/2002'),
(8, 1030, '10/5/2002', 'LAX', 'DFW', 'F', '10/5/2002'),
(3, 1010, '10/6/2002', 'LAX', 'JFK', 'E', '9/14/2002'),
(9, 1010, '10/6/2002', 'LAX', 'JFK', 'E', '9/9/2002'),
(10, 1010, '10/6/2002', 'ORD', 'JFK', 'E', '9/7/2002'),
(11, 1000, '10/6/2002', 'DFW', 'LOG', 'E', '9/9/2002'),
(12, 1000, '10/6/2002', 'DFW', 'LOG', 'E', '9/19/2002'),
(1, 1010, '10/6/2002', 'ORD', 'JFK', 'E', '9/15/2002'),
(1, 1040, '10/7/2002', 'LAX', 'LGA', 'E', '10/1/2002');

INSERT INTO Plane (ID, Maker, Model, LastMaint, LastMaintA)
VALUES (1, 'MD', 'MD11', '09/03/2002', 'DFW'),
(2, 'MD', 'MD11', '09/04/2002', 'MDW'),
(3, 'MD', 'SUPER80', '09/01/2002', 'LAX'),
(4, 'MD', 'SUPER80', '09/03/2002', 'ORD'),
(5, 'MD', 'SUPER80', '09/06/2002', 'LGA'),
(6, 'BOEING', '727', '09/01/2002', 'DFW'),
(7, 'BOEING', '757', '09/02/2002', 'LAX'),
(8, 'AIRBUS', 'A300', '09/01/2002', 'INT'),
(9, 'AIRBUS', 'A320', '09/04/2002', 'LOG');


-- 1. Retrieve the ID, the model, and the last maintenance date for each plane that was made by 'AIRBUS'--
SELECT ID, Model, LastMaint FROM [dbo].[Plane] WHERE Maker = 'AIRBUS'

--2. Retrieve the names of passengers who had reservations on flights with meals ---
SELECT * FROM [dbo].[Reservation];
SELECT * FROM [dbo].[Flight];
SELECT * FROM [dbo].[Passenger];
SELECT P.Name, R.FLNO, F.Meal
FROM Passenger AS P, Reservation AS R, FLIGHT AS F 
WHERE P.ID = R.PassID
AND R.FLNO = F.FLNO AND F.Meal = 'Meal';

-- 3. Retrieve the names of pilots who flew FROM any airport in 'TX'.
SELECT * FROM [dbo].[Airport]
SELECT * FROM [dbo].[FlightLeg]
SELECT * FROM [dbo].[FlightLegInstance]
SELECT * FROM [dbo].[Pilot]

SELECT DISTINCT P.Name FROM Pilot AS P, [dbo].[FlightLegInstance] AS FLI, FlightLeg AS F, Airport AS A 
WHERE P.ID = FLI.Pilot AND FLI.seq = F.Seq AND F.FromA = A.Code AND State = 'TX';

-- 4. Retrieve the total number of flights for the passenger 'Jones'---
SELECT * FROM [dbo].[Passenger]
SELECT * FROM [dbo].[Reservation]
SELECT 'Jones' AS 'Name of the passenger' , COUNT(*) AS 'Number of the Flight' FROM Passenger AS P , Reservation AS R 
WHERE P.ID = R.PassID AND P.Name = 'Jones'; 

-- 5. Retrieve every plane maker, model plane type that lands in CA. ---
SELECT * FROM [dbo].[PlaneType]
SELECT * FROM [dbo].[Plane]
SELECT * FROM [dbo].[FlightLeg]
SELECT * FROM [dbo].[Airport]

SELECT P.Maker, P.Model FROM PlaneType AS P, Plane AS PL, FlightLeg AS F, Airport AS A 
WHERE P.Maker = PL.Maker AND PL.ID = F.Plane AND F.ToA = A.Code AND State = 'CA'


-- 6. Retrieve the Maker and the total number of planes made by this Maker, for Makers who make any plane with total number of seats more than 100.
SELECT * FROM [dbo].[PlaneSeats]
SELECT * FROM [dbo].[Plane]
SELECT *FROM [dbo].[PlaneType]
SELECT P.Maker, COUNT(*) AS 'Total number of Planes'  FROM [dbo].[PlaneSeats] AS P,[dbo].[Plane] AS PL,  [dbo].[PlaneType]  AS PLN
WHERE P.Maker = PL.Maker AND PLN.MAKER =PL.Maker AND P.Model = PL.Model AND PL.Model = PLN.Model AND P.NoOfSeats >100
GROUP BY P.Maker 

-- 7. Retrieve all flight numbers that depart from or arrive at airport DFW ---
SELECT * FROM [dbo].[FlightLeg]

SELECT * FROM [dbo].[FlightLeg] WHERE FromA = 'DFW' OR ToA = 'DFW';


 -- 8. Retrieve the Maker, Model, and total number of seats of planes that has more than 100 seats in total.---
SELECT * FROM [dbo].[PlaneSeats]

SELECT Maker, Model, [NoOfSeats] FROM [dbo].[PlaneSeats] WHERE NoOfSeats > 100