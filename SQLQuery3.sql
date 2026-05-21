CREATE DATABASE Ecommerce_db
USE Ecommerce_db
CREATE TABLE Customer (
CustomerID INT PRIMARY KEY IDENTITY(100,1),
CustomerName VARCHAR(100) NOT NULL,
Email VARCHAR(100) UNIQUE,
City VARCHAR(100) DEFAULT 'Rohtak',
Age INT 
CHECK(Age > 18)
);
CREATE TABLE Orders (
OrderID INT PRIMARY KEY IDENTITY(100,1),
CustomerID INT,
ProductName VARCHAR(100),
Amount DECIMAL(7,2),
OrderDate DATE,
Status1 VARCHAR(30),

FOREIGN KEY(CustomerID)
REFERENCES Customer (CustomerID)
);

INSERT INTO Customer
(CustomerName, Email, City, Age)

VALUES

('Vishal Sharma','vishal@gmail.com','Rohtak',23),

('Rohit Kumar','rohit@gmail.com','Delhi',25),

('Aman Verma','aman@gmail.com','Mumbai',28),

('Sandeep Sharma','sandeep@gmail.com','Gurgaon',30),

('Sunny Kumar','sunny@gmail.com','Panipat',24);
-----------------------------------------------------------------------
INSERT INTO Orders
(CustomerID, ProductName, Amount, OrderDate, Status1)

VALUES

(100,'Laptop',55000,'2026-05-14','Delivered'),

(101,'Mobile',22000,'2026-05-10','Pending'),

(102,'Keyboard',2500,'2026-05-01','Delivered'),

(100,'Mouse',1200,'2026-05-11','Cancelled'),

(103,'Monitor',15000,'2026-05-07','Delivered'),

(104,'Headphones',3000,'2026-05-03','Pending'),

(101,'Tablet',27000,'2026-05-12','Delivered'),

(102,'Printer',8500,'2026-05-09','Cancelled');


SELECT * FROM Customer
SELECT * FROM Orders

----------------------------------------------------------------
SELECT CustomerName, City FROM Customer

SELECT * FROM Customer WHERE City='Delhi'

SELECT * FROM Orders ORDER BY(Amount) DESC

SELECT TOP 3 * FROM Orders ORDER BY(Amount) DESC

SELECT DISTINCT(City) FROM Customer

SELECT CustomerName FROM Customer Where CustomerName LIKE 'S%'

SELECT * FROM Orders WHERE Amount BETWEEN 2000 AND 20000

SELECT * FROM Customer WHERE City IN('Delhi','Mumbai')

SELECT SUM(Amount) FROM Orders 
SELECT AVG(Amount) FROM Orders 

SELECT Status1,Count(OrderID) FROM Orders GROUP BY Status1

SELECT Status1,Count(OrderID)as Count FROM Orders GROUP BY Status1 HAVING Count(OrderID)>2

SELECT  ProductName,Amount, 
CASE 
	WHEN Amount>30000 THEN 'Premium'
	WHEN Amount>10000 THEN 'Standard'
	ELSE 'Budget'
END AS Category
FROM Orders

---------String Functions 
--1. LEN()
SELECT CustomerName,LEN(CustomerName) FROM Customer
SELECT CustomerName,LEN(CustomerName) FROM Customer WHERE CustomerID=100

--2.Upper 
SELECT CustomerName,UPPER(CustomerName) FROM Customer
SELECT CustomerName,UPPER(CustomerName) FROM Customer WHERE CustomerID=100 


--3.Lower 
SELECT CustomerName,LOWER(CustomerName) FROM Customer
SELECT CustomerName,LOWER(CustomerName) FROM Customer WHERE CustomerID=100 

--4.Concate
SELECT CONCAT(CustomerID,'-',CustomerName) FROM Customer
SELECT CONCAT(CustomerID,'-',CustomerName) FROM Customer WHERE CustomerID=101

--5. Concate_ws
--One:Two:Three:Four
SELECT CONCAT_WS(':','One','Two','Three','Four')

--6. Substring
SELECT SUBSTRING('HELLO VISHAL',2,10)

--7.Left
SELECT LEFT('VISHAL',3)
SELECT CustomerName,LEFT(CustomerName,5) As Left5Char FROM Customer 

--8.Right
SELECT RIGHT('VISHAL',3)
SELECT CustomerName,RIGHT(CustomerName,5) As Right5Char FROM Customer 

-------REPLACE(text,old,new)
--9.Replace
SELECT REPLACE('HEY BUDDY', 'HEY','HELLO')
SELECT ProductName,REPLACE(ProductName,'top','y') FROM Orders

--10.Revrse
SELECT REVERSE('VISHAL')
SELECT ProductName,Reverse(ProductName)AS AfterReverse FROM Orders

--11.Charindex
SELECT CHARINDEX('@','Vishalsharma@gmail.com')

--12. Trim 
SELECT TRIM('   Alright..    ')

--13.LTrim
SELECT LTRIM('                                         VISHAL                                 ')
--14.RTrim
SELECT RTRIM('                                         VISHAL                                 ')

-------SUB QUERIES
-----------Single Row Subquery-------------

--SELECT MIN(Amount) FROM Orders
--SELECT * FROM Orders WHERE Amount=1200
  -----------OR---------
SELECT * FROM Orders WHERE Amount=(SELECT MIN(Amount) FROM Orders)


  -----------Multiple Row Subquery--------------------
--SELECT CustomerID FROM Orders WHERE Status1='Delivered'
--SELECT * FROM Customer WHERE CustomerID IN(100,101,102,103)
----------OR-------------------

SELECT * FROM Customer WHERE CustomerID IN(SELECT CustomerID FROM Orders WHERE Status1='Delivered')


------------CORELATED SUBQUERY-------------------------------------------------

SELECT * FROM Orders o WHERE Amount=(SELECT MAX(Amount) FROM Orders WHERE CustomerID=o.CustomerID );

SELECT * FROM Orders o WHERE Amount= (SELECT MIN(Amount) FROM Orders WHERE CustomerID= o.CustomerID);

SELECT * FROM Orders O WHERE OrderDate=(
SELECT MAX(OrderDate) FROM Orders WHERE CustomerID=o.CustomerID
);

------------------Date Functions------------------------------
--1. GETDATE()Kya karta h?Current:date timedeta h.
SELECT GETDATE();

--2. CURRENT_TIMESTAMP Almost same as GETDATE().
SELECT CURRENT_TIMESTAMP

--3. DATEADD(DAY YA MONTH )->Kya karta h?Date me:days ,months ,years add karta h.
SELECT DATEADD(DAY,10,GETDATE())
SELECT DATEADD(MONTH,2,GETDATE())
SELECT DATEADD(YEAR,4,GETDATE())

--4. DATEDIFF()-->Kya karta h?--2 dates ke beech difference.
SELECT DATEDIFF(DAY,'2026-05-01','2026-05-14')
SELECT ProductName,
DATEDIFF(DAY,OrderDate,GETDATE()) AS DaysDifference
FROM Orders

--5 DATENAME()-->Kya karta h?--Date ka:month name,weekday name  deta h.
SELECT DATENAME(MONTH,GETDATE())
SELECT DATENAME(WEEKDAY,GETDATE())

--6. DATEPART()-->Kya karta h?Date ka specific numeric part deta h.
SELECT DATEPART(YEAR,GETDATE())
SELECT DATEPART(MONTH,GETDATE())
SELECT DATEPART(DAY,GETDATE())

--7. FORMAT()-->Kya karta h?--Date formatting.
SELECT FORMAT(GETDATE(),'dd-MM-yyyy')

--isme month ka name aayega 
SELECT FORMAT(GETDATE(),'dd MMMM yyyy')

--8.EOMONTH()
--Month ka last date data h 
SELECT EOMONTH(GETDATE())

--9.ISDATE('')- CHECK KRTA H DATE VALID H YA NHI 
SELECT ISDATE('VISHAL') -- 0 AAYEGA 
SELECT ISDATE('2026-05-14')-- 1 


-------------ALTER 

--ADD COLUMN
ALTER TABLE Orders
ADD PaymentMode VARCHAR(100)
--DROP COLUMN
ALTER TABLE Orders
DROP COLUMN PaymentMode

SELECT * FROM Orders

--Change tha name of datatype
ALTER TABLE Customer
ALTER COLUMN CustomerName VARCHAR(200)

-------------------JOINS----------------------------------
----Cross Join-------
SELECT  c.CustomerName,o.ProductName
FROM Customer c
CROSS JOIN Orders o

------------INNER JOIN-----------------------
SELECT c.CustomerName,o.ProductName,o.Amount
FROM Customer c
INNER JOIN Orders o
ON c.CustomerID = o.CustomerID


--------------LEFT JOIN---------------------
SELECT c.CustomerName,o.ProductName FROM Customer c
LEFT JOIN Orders o
ON c.CustomerID = o.CustomerID

SELECT c.CustomerName,o.ProductName FROM Customer c
Right JOIN Orders o
ON c.CustomerID = o.CustomerID
CREATE VIEW inner_details AS
SELECT c.CustomerName,o.ProductName,o.Amount FROM Customer C
INNER JOIN Orders o
ON c.CustomerID= o.CustomerID;

SELECT TABLE_SCHEMA,TABLE_NAME
FROM INFORMATION_SCHEMA.VIEWS

USE Ecommerce_db
SELECT * FROM Customer
----------Single Column Update----------------
UPDATE Customer
SET Email='VishalSharma805966@gmail.com'
WHERE CustomerID=100




--agr code dekhna ho to 
sp_helptext 'inner_details'
SELECT * FROM inner_details

------------------------WINDOW FUNCTION----->OVER()------------------
SELECT SUM(Amount) FROM  Orders 
--SELECT ProductName,Amount ,SUM(Amount) OVER() FROM  Orders 

SELECT ProductName,Amount ,SUM(Amount) OVER() as total,CAST(Amount*100/SUM(Amount) OVER() AS DECIMAL(10,2)) FROM  Orders 
DELETE FROM Orders
WHERE OrderID = 107;

-- Removes all data
--TRUNCATE TABLE Orders;

--Union
SELECT City FROM Customer
UNION
SELECT ProductName FROM Orders;

--Union ALl
SELECT City FROM Customer
UNION ALL
SELECT ProductName FROM Orders;

SELECT CustomerID FROM Customer
INTERSECT
SELECT CustomerID FROM Orders;

	










