CREATE DATABASE EcommerceDB;
GO

USE EcommerceDB;
GO
CREATE TABLE Customers
(
    CustomerID INT PRIMARY KEY IDENTITY(1,1),

    FullName VARCHAR(100) NOT NULL,

    Email VARCHAR(100) UNIQUE,

    Phone VARCHAR(15),

    City VARCHAR(50),

    RegistrationDate DATE DEFAULT GETDATE()
);
CREATE TABLE Categories
(
    CategoryID INT PRIMARY KEY IDENTITY(1,1),

    CategoryName VARCHAR(100) NOT NULL
);
CREATE TABLE Products
(
    ProductID INT PRIMARY KEY IDENTITY(1,1),

    ProductName VARCHAR(150) NOT NULL,

    Price DECIMAL(10,2) NOT NULL,

    StockQuantity INT,

    CategoryID INT,

    FOREIGN KEY (CategoryID)
    REFERENCES Categories(CategoryID)
);

CREATE TABLE Orders
(
    OrderID INT PRIMARY KEY IDENTITY(1,1),

    CustomerID INT,

    OrderDate DATE DEFAULT GETDATE(),

    TotalAmount DECIMAL(10,2),

    OrderStatus VARCHAR(50),

    FOREIGN KEY (CustomerID)
    REFERENCES Customers(CustomerID)
);
CREATE TABLE OrderItems
(
    OrderItemID INT PRIMARY KEY IDENTITY(1,1),

    OrderID INT,

    ProductID INT,

    Quantity INT,

    Price DECIMAL(10,2),

    FOREIGN KEY (OrderID)
    REFERENCES Orders(OrderID),

    FOREIGN KEY (ProductID)
    REFERENCES Products(ProductID)
);
CREATE TABLE Payments
(
    PaymentID INT PRIMARY KEY IDENTITY(1,1),

    OrderID INT,

    PaymentDate DATE DEFAULT GETDATE(),

    PaymentMethod VARCHAR(50),

    PaymentStatus VARCHAR(50),

    FOREIGN KEY (OrderID)
    REFERENCES Orders(OrderID)
);
--------------------------------------------------------
INSERT INTO Categories(CategoryName)
VALUES
('Electronics'),
('Clothing'),
('Books'),
('Home Appliances'),
('Sports');
---------------------------------------
INSERT INTO Customers
(FullName, Email, Phone, City)
VALUES
('Rahul Sharma', 'rahul@gmail.com', '9991110001', 'Delhi'),

('Priya Verma', 'priya@gmail.com', '9991110002', 'Mumbai'),

('Amit Kumar', 'amit@gmail.com', '9991110003', 'Chandigarh'),

('Sneha Gupta', 'sneha@gmail.com', '9991110004', 'Jaipur'),

('Vikas Singh', 'vikas@gmail.com', '9991110005', 'Pune');
-----------------------------------------------------

INSERT INTO Products
(ProductName, Price, StockQuantity, CategoryID)
VALUES
('iPhone 15', 79999, 10, 1),

('Samsung TV', 55000, 5, 1),

('Nike Shoes', 4500, 20, 5),

('T-Shirt', 1200, 50, 2),

('Harry Potter Book', 700, 40, 3),

('Washing Machine', 25000, 8, 4),

('Laptop', 65000, 12, 1),

('Cricket Bat', 3000, 15, 5);
-----------------------------------------------------------------
INSERT INTO Orders
(CustomerID, TotalAmount, OrderStatus)
VALUES
(1, 84500, 'Completed'),

(2, 1200, 'Pending'),

(3, 65000, 'Completed'),

(1, 3000, 'Shipped'),

(4, 700, 'Completed');

-------------------------------------
INSERT INTO OrderItems
(OrderID, ProductID, Quantity, Price)
VALUES
(1, 1, 1, 79999),

(1, 3, 1, 4500),

(2, 4, 1, 1200),

(3, 7, 1, 65000),

(4, 8, 1, 3000),

(5, 5, 1, 700);
--------------------------------------------
INSERT INTO Payments
(OrderID, PaymentMethod, PaymentStatus)
VALUES
(1, 'UPI', 'Paid'),

(2, 'COD', 'Pending'),

(3, 'Credit Card', 'Paid'),

(4, 'Debit Card', 'Paid'),

(5, 'UPI', 'Paid');
--DELETE FROM Payments
--WHERE PaymentID = 10;

SELECT * FROM Customers;
TRUNCATE TABLE Payments;
SELECT * FROM Products;

SELECT * FROM Orders;
SELECT * FROM Payments;

--SELECT SPECIFIC COLUMN 
SELECT FullName , Email FROM Customers;

-------WHERE-----------
SELECT * FROM Customers WHERE City='Delhi'

SELECT * FROM Products WHERE Price>5000;

--ORDER BY 
SELECT * FROM Products ORDER BY(Price)
SELECT * FROM Products ORDER BY(Price) DESC;

SELECT * FROM Customers ORDER BY(FullName)DESC;  

--TOP
SELECT TOP(2)* FROM Orders

--DISTINCT
SELECT DISTINCT(OrderDate) FROM Orders;
SELECT DISTINCT City FROM Customers;

SELECT DISTINCT OrderStatus FROM Orders;

--UPDATE
UPDATE Customers
SET FullName='Rahul Verma'
WHERE CustomerID=1
SELECT * FROM Customers;

UPDATE Products
SET Price=1500
WHERE ProductID=4
SELECT * FROM Products;

----DELETE
DELETE FROM Customers
WHERE CustomerID=5
-----------------INSERT DATA AGAIN------------ 
INSERT INTO Customers
(FullName, Email, Phone, City)
VALUES
('Vikas Singh', 'vikas@gmail.com', '9991110005', 'Pune');
---------------------------------------------------------------------
-------ALTER TABLE NEW COLUMN ADDED----------------
ALTER TABLE Customers
ADD State VARCHAR(50) 
SELECT * FROM Customers;
-------DELETE COLUMN------------
ALTER TABLE Customers
DROP COLUMN State;

--------------SQL OPERATORS---------
----AND
SELECT * FROM Customers WHERE City='Delhi' AND CustomerID='1'

SELECT * FROM Products WHERE Price>1000 AND CategoryID=1

----OR
SELECT * FROM Customers WHERE City='Delhi' OR City= 'Mumbai';
SELECT * FROM Products WHERE Price<1000 OR StockQuantity>15;

---NOT
SELECT * FROM Customers WHERE NOT City='Delhi'

---------IN--------
SELECT * FROM Customers WHERE City IN('Delhi','Jaipur')

--------BETWEEN------------
SELECT * FROM Orders WHERE TotalAmount BETWEEN 1000 AND 70000;

---LIKE-----
SELECT * FROM Customers WHERE FullName LIKE ('S%'); 
SELECT * FROM Customers WHERE FullName LIKE ('%a'); 
SELECT * FROM Customers WHERE FullName LIKE ('%am%'); 
----wildcard
SELECT * FROM Customers WHERE FullName LIKE ('_a%'); 
---------------------------------------------------
INSERT INTO Customers
(FullName, Email, City)
VALUES
('Karan Mehta', 'karan@gmail.com', 'Delhi');
-----------------------------------------------

------IS NULL

SELECT *
FROM Customers
WHERE Phone IS NULL;
-------------IS NOT NULL---------------
SELECT * FROM Customers WHERE Phone IS NOT NULL;

------------------------------------------------------------------------------------------
ALTER TABLE Customers
ADD Age INT;

UPDATE Customers
SET Age=22;

ALTER TABLE Customers
ADD CONSTRAINT Chk_Age
CHECK (Age>=18);

UPDATE Customers
SET Age=34
WHERE CustomerID=1;

SELECT * FROM Customers;

--------------------------------------
SELECT * FROM OrderItems;

-----DROP--
--DROP TABLE Payments

--DROP TABLE IF EXISTS Payments;

--DROP DATABASE EcommerceDB


-------ALIAS
----COLUMN 
SELECT FullName AS CustomerName FROM Customers;

-------TABLE ALIAS
SELECT C.FullName
FROM Customers C

--------------------------------------------------------------------
SELECT * FROM OrderItems;

--INSERT INTO OrderItems
--(OrderID, ProductID, Quantity, Price)
--VALUES
--(1,1,2,79999);
--DELETE FROM OrderItems WHERE OrderItemID=8
 
ALTER TABLE OrderItems
ADD CONSTRAINT UQ_Order_Product
UNIQUE(OrderID,ProductID);


----------------AGGREGATE FUNCTIONS----------
SELECT SUM(Price) FROM Products;
SELECT AVG(Price) FROM Products;
SELECT MAX(Price) FROM Products;
SELECT MIN(Price) FROM Products;
SELECT COUNT(ProductID) FROM Products;

--GROUP BY
SELECT CategoryID,COUNT(*) AS TotalProduct FROM Products GROUP BY CategoryID;

--------HAVING CLAUSE--------
SELECT CategoryID,COUNT(*) AS TotalProduct FROM Products GROUP BY CategoryID HAVING COUNT(*)>1;

-----------------------------------
---------------- STRING FUNCTIONS ----------------
---------------- LEN ----------------
SELECT FullName,
LEN(FullName) AS NameLength
FROM Customers;
---------------- LOWER ----------------
SELECT FullName,
LOWER(FullName) AS LowerName
FROM Customers;
---------------- UPPER ----------------
SELECT FullName,
UPPER(FullName) AS UpperName
FROM Customers;
---------------- LEFT ----------------
SELECT FullName,
LEFT(FullName,5) AS FirstFiveLetters
FROM Customers;
---------------- RIGHT ----------------
SELECT FullName,
RIGHT(FullName,4) AS LastFourLetters
FROM Customers;
---------------- SUBSTRING ----------------
SELECT FullName,
SUBSTRING(FullName,1,5) AS SubName
FROM Customers;
---------------- REPLACE ----------------
SELECT FullName,
REPLACE(FullName,'a','@') AS ReplacedName
FROM Customers;
---------------- REVERSE ----------------
SELECT FullName,
REVERSE(FullName) AS ReverseName
FROM Customers;
---------------- CONCAT ----------------
SELECT CONCAT(FullName,' - ',City) AS CustomerDetails
FROM Customers;
---------------- CONCAT_WS ----------------
SELECT CONCAT_WS(' | ',FullName,City,Phone) AS CustomerInfo
FROM Customers;
---------------- CHARINDEX ----------------
SELECT FullName,
CHARINDEX('a',FullName) AS PositionOfA
FROM Customers;
---------------- TRIM ----------------
SELECT TRIM('     SQL SERVER     ') AS TrimmedText;

---------------- LTRIM ----------------
SELECT LTRIM('     SQL SERVER') AS LeftTrimmed;

---------------- RTRIM ----------------
SELECT RTRIM('SQL SERVER     ') AS RightTrimmed;

--------------------------------------------------
---------------- SPACE ----------------
SELECT 'Hello'
+ SPACE(5)
+ 'World' AS SpaceExample;
---------------- REPLICATE ----------------
SELECT REPLICATE('*',10) AS Stars;
---------------- STUFF ----------------
SELECT STUFF('HelloWorld',6,5,'SQL') AS StuffExample;
---------------- PATINDEX ----------------
SELECT FullName,
PATINDEX('%a%',FullName) AS PositionPattern
FROM Customers;
---------------- FORMAT ----------------
SELECT FORMAT(GETDATE(),'dd-MM-yyyy') AS FormattedDate;

--------------------------------------------------

---------------- DATE FUNCTIONS ----------------
---------------- GETDATE ----------------
SELECT GETDATE() AS CurrentDateTime;
---------------- CURRENT_TIMESTAMP ----------------
SELECT CURRENT_TIMESTAMP AS CurrentTimeStamp;
---------------- SYSDATETIME ----------------
SELECT SYSDATETIME() AS SystemDateTime;
---------------- DAY ----------------
SELECT
OrderDate,
DAY(OrderDate) AS OrderDay
FROM Orders;
---------------- MONTH ----------------
SELECT
OrderDate,
MONTH(OrderDate) AS OrderMonth
FROM Orders;
---------------- YEAR ----------------
SELECT
OrderDate,
YEAR(OrderDate) AS OrderYear
FROM Orders;
---------------- DATEPART ----------------
SELECT
OrderDate,
DATEPART(YEAR,OrderDate) AS YearPart,
DATEPART(MONTH,OrderDate) AS MonthPart,
DATEPART(DAY,OrderDate) AS DayPart
FROM Orders;
---------------- DATENAME ----------------
SELECT
OrderDate,
DATENAME(MONTH,OrderDate) AS MonthName,
DATENAME(WEEKDAY,OrderDate) AS DayName
FROM Orders;
---------------- DATEADD ----------------
SELECT
OrderDate,
DATEADD(DAY,7,OrderDate) AS After7Days
FROM Orders;
--------------------------------------------
SELECT
OrderDate,
DATEADD(MONTH,1,OrderDate) AS After1Month
FROM Orders;
---------------- DATEDIFF ----------------
SELECT
OrderDate,
DATEDIFF(DAY,OrderDate,GETDATE()) AS DaysDifference
FROM Orders;
-----------------------------------------------
SELECT
OrderDate,
DATEDIFF(MONTH,OrderDate,GETDATE()) AS MonthDifference
FROM Orders;
---------------- EOMONTH ----------------
SELECT
OrderDate,
EOMONTH(OrderDate) AS EndOfMonth
FROM Orders;
---------------- ISDATE ----------------
SELECT ISDATE('2025-05-10') AS ValidDate;

SELECT ISDATE('Hello') AS InvalidDate;

---------------- FORMAT ----------------
SELECT
FORMAT(GETDATE(),'dd-MM-yyyy') AS DateFormat1,

FORMAT(GETDATE(),'dd/MM/yyyy') AS DateFormat2,

FORMAT(GETDATE(),'MMMM') AS MonthName,

FORMAT(GETDATE(),'dddd') AS DayName;

---------------- CAST ----------------
SELECT
CAST(GETDATE() AS DATE) AS OnlyDate;
------------------------------------------------
SELECT
CAST(123.456 AS INT) AS IntegerValue;
--------------------------------CONVERT -----------------------------
SELECT
CONVERT(VARCHAR,GETDATE(),103) AS BritishFormat;
------------------------------------------------

SELECT
CONVERT(VARCHAR,GETDATE(),108) AS OnlyTime;
SELECT
CONVERT(VARCHAR,GETDATE(),107) AS DateStyle107;
--------NUMERIC FUNCTION--------------
SELECT ABS(-25) AS Result;
SELECT ABS(-5000) AS RefundAmount;

----CEILING-------(upr ki value dega )-----
SELECT CEILING(12.3) AS Result;
-----FLOOR (LOWER ROUND)-----
SELECT FLOOR(23.9) AS Res;
-------ROUND()------------
SELECT ROUND(23.34567,2)AS Res; 

---------POWER-----------
SELECT POWER(2,3) AS Pow;
--------SQRT-----------
SELECT SQRT(25) AS SquareRoot;

--------RAND-----------
SELECT RAND() AS RandomNumber;

--------PI-------------
SELECT PI() AS PIValue;

--------SIGN-----------
SELECT SIGN(25) AS PositiveNumber;
SELECT SIGN(-25) AS NegativeNumber;
SELECT SIGN(0) AS ZeroNumber;

----------------------------------------

------------------------------------------
SELECT * FROM Customers
------------Stored Procedure---------------
---------Types od Stored Procedure 
--1.SP without parameters
CREATE PROCEDURE get_Details
AS
BEGIN
SELECT FullName , Email,Phone , City ,Age FROM Customers
END

EXEC get_Details;
--2.SP with Input parameters
CREATE PROCEDURE getDetailsbyCity3
@p_city VARCHAR(100)
AS
BEGIN
SELECT FullName,Email,Phone,Age,City FROM Customers WHERE City=@p_city  
END;
GO
EXEC getDetailsbyCity3 'Mumbai'
EXEC getDetailsbyCity3 'Delhi'

----------HOW TO CHECK EXISTING SP------------
SELECT ROUTINE_NAME
FROM INFORMATION_SCHEMA.ROUTINES
WHERE ROUTINE_TYPE='PROCEDURE' 



-----------------------------
sp_helptext 'getDetailsbyCity3'

--OUTPUT-CREATE PROCEDURE getDetailsbyCity3 @p_city VARCHAR(100) AS BEGIN SELECT FullName,Email,Phone,Age,City FROM Customers WHERE City=@p_city   END; 

--------


-----------HOW TO MODIFY OR DELETE A PROCEDURE ---------
ALTER PROCEDURE getDetailsbyCity3
AS
BEGIN
SELECT FullName,Email,Phone,Age,City,RegistrationDate FROM Customers  
END
GO

EXEC getDetailsbyCity3
------------------
CREATE PROCEDURE UpdateEmail
@UpdatedEmail VARCHAR(100),
@UpdatedID INT 
AS
BEGIN 
UPDATE Customers
SET Email= @UpdatedEmail
WHERE CustomerID= @UpdatedID  ;
END;

SELECT * FROM Customers
EXEC UpdateEmail 'RahulVerma009@gmail.com',1;

--3.SP with Input & Output parameters
SELECT * FROM Products

CREATE PROCEDURE Avg_Price
@NameOfProducts VARCHAR(100),
@ProductAvg NUMERIC(10,2) OUTPUT

AS
BEGIN
SELECT
@ProductAvg= AVG(Price) FROM Products
WHERE ProductName=@NameOfProducts

END
------
DECLARE @AvgResult NUMERIC(10,2)
EXEC Avg_Price 'Laptop',@AvgResult OUTPUT
SELECT @AvgResult








