SELECT name FROM sys.databases
CREATE DATABASE Railway_db
CREATE DATABASE Hospital_db
USE Hospital_db
SELECT DB_NAME()
--DROP DATABASE Railyway_db;

--SELECT name FROM sys.databases
USE Railway_db
CREATE TABLE Trains(
    TrainID INT,
    TrainName VARCHAR(100),
    SourceStation VARCHAR(100),
    DestinationStation VARCHAR(100),
    TicketPrice DECIMAL(10,2),
    IsAvailable BIT
);
SELECT * FROM Trains
CREATE TABLE Passenger(
    PassengerID INT PRIMARY KEY,
    PassengerName VARCHAR(30),
    Age INT NOT NULL,
    Gender VARCHAR(30),
    City VARCHAR(40)
    );
INSERT INTO Trains
VALUES
(101,'Rajdhani Express','Delhi','Mumbai',2500,1),
(102,'Shatabdi Express','Delhi','Chandigarh',1200,1),
(103,'Haryana Express','Rohtak','Delhi',300,0);

INSERT INTO Passenger
VALUES
(1,'Vishal',23,'Male','Rohtak'),
(2,'Rohit',19,'Male','Delhi'),
(3,'Montu',24,'Male','Rohtak'),
(4,'Sunny',24,'Male','Gohana');


SELECT * FROM Trains
SELECT * FROM Passenger
SELECT TrainName, TicketPrice
FROM Trains;     

UPDATE Trains
SET TicketPrice=2000
WHERE TrainName='Rajdhani Express';
SELECT * FROM Trains;
UPDATE Passenger
SET City='Panipat'
WHERE PassengerID=2;

DELETE FROM Trains 
WHERE TrainID=103 
--Task1

SELECT * FROM Trains
WHERE isAvailable=1

--Task2
SELECT PassengerName FROM Passenger

--Task3
SELECT * FROM Passenger
WHERE City='Rohtak'

--Task4
SELECT * FROM Trains
WHERE TicketPrice>1000

--Task5
SELECT TrainName,TicketPrice FROM Trains

--Task6
SELECT * FROM Trains
ORDER BY (TicketPrice)DESC

--Task7
SELECT DISTINCT SourceStation FROM Trains
EXEC sp_help 'Passenger'


--Distinct
SELECT DISTINCT City FROM Passenger

--Top
SELECT  Top 2 *  FROM Passenger
SELECT TOP 1* FROM Trains 
ORDER BY (TicketPrice)DESC

--Like
SELECT * FROM Passenger
WHERE City LIKE 'P%'

--Between
SELECT * FROM Trains
WHERE TicketPrice BETWEEN 1400 AND 2200;

--IN
SELECT * FROM Passenger
WHERE City IN('Rohtak','Gohana')

--AND
SELECT * FROM Passenger 
WHERE Age>23 AND City='Rohtak'

--OR
SELECT * FROM Passenger
WHERE City='Rohtak'OR City='Gohana'

SELECT * FROM Trains
WHERE DestinationStation='Delhi' OR DestinationStation='Mumbai'

--NOT

SELECT * FROM Passenger 
WHERE NOT City='Rohtak'

--NULL
INSERT INTO Passenger
VALUES
(5,'Amit',22,'Male',NULL);

SELECT * FROM Passenger
WHERE City Is NULL

--Truncate
--TRUNCATE TABLE Passenger

------Identity
CREATE TABLE Trains2(
    TrainID INT PRIMARY KEY IDENTITY(200,1),
    TrainName VARCHAR(100),
    SourceStation VARCHAR(100),
    DestinationStation VARCHAR(100),
    TicketPrice DECIMAL(10,2),
    IsAvailable BIT
);

INSERT INTO Trains2
VALUES
('Rajdhani Express','Delhi','Mumbai',2500,1),
('Shatabdi Express','Delhi','Chandigarh',1200,1),
('Haryana Express','Rohtak','Delhi',300,0);
--TRUNCATE TABLE Trains2
SELECT * FROM Trains2


--UNIQUE CONSTRAINT----->DUPLICATE VALUE ALLOW NHI KRTA

--DEFAULT
 CREATE TABLE Demo(
        Id INT PRIMARY KEY IDENTITY(100,1),
        Name VARCHAR(30),
        email VARCHAR(30) UNIQUE,
        Department VARCHAR(30) DEFAULT 'IT'
 );
 --TRUNCATE TABLE Demo
 INSERT INTO Demo
 (Name,Email)
 VALUES
 ('Vishal','Vishalsharma12@gmail.com'),
 ('Vishal Sharma','Vishalsharma1234@gmail.com');
 SELECT * FROM Demo

 --Check constraint
 
 CREATE TABLE Employees2(

    Id INT PRIMARY KEY,

    Name VARCHAR(50),

    Salary DECIMAL(10,2)

    CHECK(Salary > 10000)
);
INSERT INTO Employees2
VALUES
(1,'Vishal',15000);
--INSERT INTO Employees2
--VALUES
--(1,'Vishal',-7000);


--Fore
CREATE TABLE Customers(

    CustomerID INT PRIMARY KEY,

    CustomerName VARCHAR(100)
);
INSERT INTO Customers
VALUES
(1,'Vishal'),
(2,'Rohit');

CREATE TABLE Orders(

    OrderID INT PRIMARY KEY,

    CustomerID INT,
    ProductName VARCHAR(20),
    FOREIGN KEY(CustomerID)
    REFERENCES Customers(CustomerID)
);
INSERT INTO Orders
VALUES
(101,1,'Laptop');

--ALTER
--ADD COLUMN

ALTER TABLE Passenger
ADD PhoneNumber VARCHAR(50);

--UPDATE COLUMN
--SET PhoneNumber='8059665473'
--WHERE PassengerID=1;

--Drop any column
ALTER TABLE Passenger
DROP COLUMN PhoneNumber
SELECT * FROM Passenger

--COUNT()
SELECT COUNT(*)
FROM Passenger

----COUNT + Distinct
SELECT COUNT(DISTINCT City) FROM Passenger

--SUM
SELECT SUM(TicketPrice)
FROM Trains

--AVG
SELECT AVG(TicketPrice)
FROM Trains

---MIN ,MAX

--Group by
SELECT City,Count(*) 
FROM Passenger
GROUP BY City

SELECT * FROM Passenger

SELECT Age,COUNT(PassengerID) FROM Passenger 
GROUP BY Age


--HAVING
SELECT * FROM Passenger
SELECT City,COUNT(PassengerID) as Count FROM Passenger GROUP BY City Having Count(PassengerID)>=2


--CASE
SELECT PassengerName,Age ,
CASE
    WHEN Age>19 THEN 'ADULT'
    ELSE 'YOUNG'
END AS Status
FROM Passenger

--STRING FUNCTIONS
--1.Len()

SELECT PassengerName,
       LEN(PassengerName) AS NameLength

FROM Passenger;

--2.Upper()
SELECT UPPER(PassengerName)
FROM Passenger;

--3.Concat()
SELECT CONCAT(PassengerName,' - ',City)

FROM Passenger;
