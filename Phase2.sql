---------------- CREATE DATABASE ------------------
CREATE DATABASE Phase2_SQL_Practice;
GO

USE Phase2_SQL_Practice;
GO

---------------- CUSTOMERS TABLE ------------------

CREATE TABLE Customers
(
CustomerID INT PRIMARY KEY IDENTITY(1,1),

CustomerName VARCHAR(100),

City VARCHAR(100),

Email VARCHAR(100),

JoinDate DATE
);

---------------- ORDERS TABLE ---------------------

CREATE TABLE Orders
(
OrderID INT PRIMARY KEY IDENTITY(1,1),

CustomerID INT,

ProductName VARCHAR(100),

Category VARCHAR(100),

Amount DECIMAL(10,2),

OrderDate DATE,

Status1 VARCHAR(50),

FOREIGN KEY(CustomerID)
REFERENCES Customers(CustomerID)
);

---------------- INSERT CUSTOMERS -----------------
INSERT INTO Customers
(CustomerName,City,Email,JoinDate)

VALUES

('Vishal Sharma','Rohtak','vishal@gmail.com','2026-01-10'),

('Rohit Kumar','Delhi','rohit@gmail.com','2026-02-15'),

('Aman Verma','Mumbai','aman@gmail.com','2026-01-25'),

('Sunny Kumar','Panipat','sunny@gmail.com','2026-03-05'),

('Sandeep Sharma','Gurgaon','sandeep@gmail.com','2026-02-01');

---------------- INSERT ORDERS --------------------

INSERT INTO Orders
(CustomerID,ProductName,Category,Amount,OrderDate,Status1)

VALUES

(1,'Laptop','Electronics',55000,'2026-05-01','Delivered'),

(1,'Mouse','Electronics',1200,'2026-05-03','Delivered'),

(2,'Mobile','Electronics',25000,'2026-05-05','Pending'),

(2,'Keyboard','Electronics',3000,'2026-05-06','Cancelled'),

(3,'Shoes','Fashion',4500,'2026-05-07','Delivered'),

(3,'T-Shirt','Fashion',1500,'2026-05-08','Delivered'),

(4,'Watch','Accessories',7000,'2026-05-09','Pending'),

(4,'Bag','Accessories',2500,'2026-05-10','Delivered'),

(5,'Tablet','Electronics',28000,'2026-05-11','Delivered'),

(5,'Printer','Electronics',8500,'2026-05-12','Cancelled'),

(1,'Monitor','Electronics',18000,'2026-05-13','Delivered'),

(2,'Headphones','Electronics',3500,'2026-05-14','Pending');

---------------- CHECK DATA -----------------------

 
------------CTE---------------
;WITH MyCTE1 AS
(
SELECT *
FROM Orders
)
--SELECT * FROM MyCTE;
SELECT*FROM MyCTE1;

;WITH DeliveredOrders AS
(
    SELECT *
    FROM Orders
    WHERE Status1='Delivered'
)
SELECT *
FROM DeliveredOrders;

;WITH Numbers AS
(
SELECT 1 AS Num
UNION ALL
SELECT Num+1
FROM Numbers
WHERE Num<10   
)
SELECT * FROM Numbers;

SELECT ProductName,Amount ,SUM(Amount) OVER(PARTITION BY CustomerID) AS TotalSum FROM Orders ;

SELECT ProductName,Amount ,MAX(Amount) OVER() AS TotalSum FROM Orders ;
SELECT ProductName,Amount ,MIN(Amount) OVER() AS TotalSum FROM Orders ;
SELECT ProductName,Amount ,AVG(Amount) OVER() AS TotalSum FROM Orders ;

SELECT * FROM Customers
SELECT * FROM Orders

SELECT ROW_NUMBER () OVER( ORDER BY Amount DESC),ProductName,Category,Amount FROM Orders 
SELECT RANK() OVER( ORDER BY Category DESC),ProductName,Category,Amount FROM Orders --same value pr no.increase nhi krta same hi deta 

--THAT'S WHY We use DENSE_RANK
SELECT DENSE_RANK() OVER (ORDER BY Category DESC),ProductName,Category,Amount FROM Orders 

--LAG & LEAD
SELECT ProductName, Category, Amount,
LAG(Amount)OVER(ORDER BY Amount DESC) AS PreviousValue FROM Orders

SELECT ProductName,Category , Amount,
LEAD(Amount) OVER(ORDER BY Amount DESC) FROM Orders
------------------Running Total------------------
--SELECT OrderID,ProductName,Amount,SUM(Amount)OVER(ORDER BY Amount DESC) FROM Orders(isme first same amount ko add krke de deta h)
--Solution
--ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW

SELECT OrderID,ProductName,Amount,SUM(Amount)OVER(ORDER BY Amount DESC
ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
) FROM Orders

SELECT * FROM Orders

UPDATE Orders
SET Amount=55000
WHERE OrderID=9
------------FIRST_VALUE------------------

SELECT ProductName, Amount,OrderID, FIRST_VALUE(ProductName) OVER(PARTITION BY (Category) ORDER BY Amount DESC) FROM Orders
--------LAST_VALUE--------------------
SELECT ProductName, Amount,OrderID, LAST_VALUE(ProductName) OVER(PARTITION BY (Category) ORDER BY Amount DESC) FROM Orders
----------------NTILE-------------------
SELECT ProductName,Amount, NTILE(5) OVER(ORDER BY Amount DESC) FROM Orders

-----------STORED PROCEDURES-----------------
CREATE PROCEDURE GetOrderDetail
AS 
BEGIN
    SELECT OrderID,ProductName,Amount
    FROM Orders
END    

EXEC GetOrderDetail;


-----------------With parameter--------------------
CREATE PROCEDURE GetOrdersByStatus
@Status VARCHAR(50)
AS
BEGIN
    SELECT OrderID,ProductName,Category,Amount,Status1 FROM Orders
WHERE Status1 = @Status
END


