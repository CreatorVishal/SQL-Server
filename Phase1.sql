CREATE DATABASE CompanyDB
USE CompanyDB

CREATE TABLE Employee(
EmployeeID INT PRIMARY KEY IDENTITY(1,1),
EmployeeName VARCHAR(100) NOT NULL ,
Email VARCHAR(100) UNIQUE,
Salary DECIMAL(10,2)
CHECK(Salary>10000),
City VARCHAR(50) DEFAULT 'DELHI',
Department VARCHAR(100) NOT NULL,
);

INSERT INTO Employee
(EmployeeName,Email,Salary,City,Department)

VALUES

('Vishal','vishal@gmail.com',45000,'Rohtak','IT'),

('Rohit','rohit@gmail.com',35000,'Delhi','HR'),

('Aman','aman@gmail.com',60000,'Mumbai','IT'),

('Sandeep','sandeep@gmail.com',55000,'Pune','Finance'),

('Sunny','sunny@gmail.com',25000,'Delhi','Support')


SELECT * FROM Employee 

SELECT EmployeeName, Salary FROM Employee

SELECT * FROM Employee WHERE City='Delhi'

SELECT * FROM Employee ORDER BY(Salary)DESC 
SELECT Salary FROM Employee ORDER BY(Salary)DESC

SELECT TOP 3* FROM Employee ORDER BY(Salary)DESC

--FILTERING PRACTICE
SELECT * FROM Employee WHERE Salary>30000
SELECT * FROM Employee WHERE Salary BETWEEN 30000 AND 60000 
SELECT * FROM Employee WHERE Department='IT' 
SELECT * FROM Employee WHERE EmployeeName LIKE 'S%'

SELECT * FROM Employee WHERE City IN('Delhi','Mumbai')

UPDATE Employee
SET Salary=70000
WHERE EmployeeName='Vishal' 

DELETE Employee
WHERE Department='Support'

SELECT SUM(Salary) FROM Employee;
SELECT AVG(Salary) FROM Employee;
SELECT MAX(Salary) FROM Employee;
SELECT MIN(Salary) FROM Employee;
SELECT COUNT(EmployeeID) FROM Employee;

SELECT Department,COUNT(Department) FROM Employee GROUP BY(Department)
SELECT Department,SUM(Salary) FROM Employee GROUP BY(Department)

SELECT Department,COUNT(Department) FROM Employee GROUP BY(Department) HAVING COUNT(Department)>1
SELECT EmployeeName, Salary , 
CASE 
WHEN Salary > 60000 THEN 'High'
WHEN Salary > 40000 THEN 'Medium'
ELSE 'Low'
END AS SalaryCategory
FROM Employee

SELECT DISTINCT Department  FROM Employee
SELECT DISTINCT Salary FROM Employee

SELECT EmployeeName AS Employee_Name FROM Employee 
SELECT EmployeeName AS StaffName FROM Employee
SELECT DISTINCT(City),Salary , EmployeeName AS WorkerName FROM  Employee WHERE Salary>30000

SELECT * FROM Employee WHERE LEN(EmployeeName)>5
SELECT UPPER(Email) FROM Employee
SELECT LOWER(Email) FROM Employee

SELECT EmployeeName, LEFT(EmployeeName,2) FROM Employee
SELECT EmployeeName, RIGHT(EmployeeName,2) FROM Employee

CREATE TABLE Orders
(
OrderID INT PRIMARY KEY IDENTITY(1,1),

CustomerName VARCHAR(100),

ProductName VARCHAR(100),

Amount DECIMAL(10,2),

OrderDate DATE
)
INSERT INTO Orders
(CustomerName,ProductName,Amount,OrderDate)

VALUES

('Vishal','Laptop',55000,'2026-05-01'),

('Rohit','Mobile',25000,'2026-05-10'),

('Aman','Keyboard',3000,'2026-05-12'),

('Sandeep','Monitor',15000,'2026-04-28'),

('Sunny','Mouse',1200,'2026-05-14')
SELECT * FROM Orders

SELECT GETDATE();
SELECT CURRENT_TIMESTAMP;

SELECT DATEADD(DAY,10,GETDATE());
SELECT DATEADD(MONTH,2,GETDATE());
SELECT DATEADD(YEAR,1,GETDATE());

SELECT ProductName,OrderDate,
DATEADD(DAY,7,OrderDate) AS DeliveryDate 
FROM Orders

SELECT ProductName,OrderDate,
DATEDIFF(DAY,'2026-05-01',GETDATE())
FROM Orders

SELECT DATENAME(MONTH, GETDATE())
SELECT DATENAME(DAY, GETDATE())
SELECT DATENAME(YEAR, GETDATE())
SELECT DATENAME(WEEKDAY, GETDATE())

SELECT ProductName,OrderDate ,
DATENAME(WEEKDAY,OrderDate) 
FROM Orders

SELECT DATEPART(MONTH,GETDATE())
SELECT DATEPART(DAY,GETDATE())
SELECT DATEPART(YEAR,GETDATE())

SELECT ProductName,OrderDate,
DATEPART(MONTH,OrderDate) FROM Orders

SELECT FORMAT(
GETDATE(),
'dd-MM-yyyy'
)
SELECT EOMONTH(GETDATE()) --Current month ka last date
SELECT EOMONTH(GETDATE(),1)--Next month last date
SELECT ISDATE('2026-05-15') 

---------------- STRING FUNCTIONS PRACTICE ----------------

--1. LEN() ------------------------------------------
SELECT EmployeeName,
LEN(EmployeeName) AS TotalCharacters
FROM Employee

SELECT EmployeeName,
LEN(EmployeeName) AS TotalCharacters
FROM Employee
WHERE EmployeeID = 1


--2. UPPER() ----------------------------------------
SELECT EmployeeName,
UPPER(EmployeeName) AS UpperName
FROM Employee

SELECT Email,
UPPER(Email) AS UpperEmail
FROM Employee
WHERE EmployeeID = 1


--3. LOWER() ----------------------------------------
SELECT EmployeeName,
LOWER(EmployeeName) AS LowerName
FROM Employee

SELECT Email,
LOWER(Email) AS LowerEmail
FROM Employee
WHERE EmployeeID = 1


--4. CONCAT() ---------------------------------------
SELECT CONCAT(
EmployeeName,
' - ',
Department
) AS EmployeeDetails

FROM Employee

SELECT CONCAT(
EmployeeName,
' lives in ',
City
) AS EmployeeCity

FROM Employee


--5. CONCAT_WS() ------------------------------------
SELECT CONCAT_WS(
' | ',
EmployeeName,
Department,
City
) AS EmployeeInfo

FROM Employee

SELECT CONCAT_WS(
'-',
'SQL',
'SERVER',
'PRACTICE'
)


--6. SUBSTRING() ------------------------------------
SELECT SUBSTRING(
'HELLO VISHAL',
2,
10
)

SELECT EmployeeName,
SUBSTRING(EmployeeName,1,3)
AS First3Characters

FROM Employee


--7. LEFT() -----------------------------------------
SELECT LEFT('VISHAL',3)

SELECT EmployeeName,
LEFT(EmployeeName,4)
AS Left4Char

FROM Employee


--8. RIGHT() ----------------------------------------
SELECT RIGHT('VISHAL',3)

SELECT EmployeeName,
RIGHT(EmployeeName,3)
AS Right3Char

FROM Employee


--9. REPLACE() --------------------------------------
SELECT REPLACE(
'HELLO VISHAL',
'HELLO',
'HI'
)

SELECT Department,
REPLACE(
Department,
'IT',
'Developer'
) AS UpdatedDepartment

FROM Employee


--10. REVERSE() -------------------------------------
SELECT REVERSE('VISHAL')

SELECT EmployeeName,
REVERSE(EmployeeName)
AS ReverseName

FROM Employee


--11. CHARINDEX() -----------------------------------
SELECT CHARINDEX(
'@',
'vishal@gmail.com'
)

SELECT Email,
CHARINDEX('@',Email)
AS AtPosition

FROM Employee


--12. TRIM() ----------------------------------------
SELECT TRIM(
'     SQL SERVER     '
)

SELECT TRIM(
'     Vishal Sharma     '
)


--13. LTRIM() ---------------------------------------
SELECT LTRIM(
'          VISHAL'
)

SELECT LTRIM(
'          SQL SERVER          '
)


--14. RTRIM() ---------------------------------------
SELECT RTRIM(
'VISHAL            '
)

SELECT RTRIM(
'          SQL SERVER          '
)
ALTER TABLE Employee
ADD PhoneNumber VARCHAR(20)

ALTER TABLE Employee
ADD JoiningDate DATE;

ALTER TABLE Employee
ADD ExperienceYears INT
ALTER TABLE Employee

ADD EmergencyContact VARCHAR(20)

---Drop column
ALTER TABLE Employee
DROP COLUMN JoiningDate

ALTER TABLE Employee
DROP COLUMN EmergencyContact
SELECT * FROM Employee

--ALTER COLUMN
ALTER TABLE Employee
ALTER COLUMN PhoneNumber VARCHAR(100)

-----Foreign key
CREATE TABLE Customers
(
 CustomerID INT
 PRIMARY KEY IDENTITY(1,1),

 CustomerName VARCHAR(100),

 City VARCHAR(100)
)
INSERT INTO Customers
(CustomerName,City)

VALUES

('Vishal','Rohtak'),

('Rohit','Delhi'),

('Aman','Mumbai')

CREATE TABLE Order1(
OrderId INT PRIMARY KEY IDENTITY(100,1),
CustomerID INT,
OrderDate DATE,
FOREIGN KEY (CustomerID) 
REFERENCES Customers(CustomerID)
);
DROP TABLE Order1

INSERT INTO Order1
(CustomerID,OrderDate)

VALUES

(1,'2026-05-10'),

(2,'2026-05-11'),

(3,'2026-05-12'),

(1,'2026-05-13'),

(2,'2026-05-14')
------------------------------------------
ALTER TABLE Order1
DROP COLUMN CustomerID;
--------------------------------------------------

ALTER TABLE Order1
DROP CONSTRAINT FK__Order1__Customer__5812160E
------------------------------------------------------------
--ISKE BAAD AGR DOBARA LGANA HO TO 
ALTER TABLE Order1

ADD CONSTRAINT FK_Customer_Order

FOREIGN KEY(CustomerID)

REFERENCES Customers(CustomerID)
------------------------------------------------------------------
SELECT * FROM Customers
SELECT * FROM Order1
----------------------------
------------------JOINS--------------------
CREATE TABLE Clients
(
 ClientID INT
 PRIMARY KEY IDENTITY(1,1),

 ClientName VARCHAR(100)
 NOT NULL,

 ClientCity VARCHAR(100),

 ClientEmail VARCHAR(100)
 UNIQUE
)
INSERT INTO Clients
(ClientName,ClientCity,ClientEmail)

VALUES

('Vishal','Rohtak','vishal@gmail.com'),

('Rohit','Delhi','rohit@gmail.com'),

('Aman','Mumbai','aman@gmail.com'),

('Sandeep','Pune','sandeep@gmail.com'),

('Sunny','Delhi','sunny@gmail.com')
CREATE TABLE ItemGroups
(
 GroupID INT
 PRIMARY KEY IDENTITY(1,1),

 GroupName VARCHAR(100)
 NOT NULL
)
INSERT INTO ItemGroups
(GroupName)

VALUES

('Electronics'),

('Accessories'),

('Gaming'),

('Clothing')

CREATE TABLE Inventory
(
 ItemID INT
 PRIMARY KEY IDENTITY(100,1),

 ItemName VARCHAR(100),

 Price DECIMAL(10,2),

 GroupID INT,

 FOREIGN KEY(GroupID)

 REFERENCES ItemGroups(GroupID)
)
INSERT INTO Inventory
(ItemName,Price,GroupID)

VALUES

('Laptop',55000,1),

('Mouse',1200,2),

('Keyboard',3000,2),

('PlayStation',45000,3),

('T-Shirt',1500,4)


CREATE TABLE Purchases
(
 PurchaseID INT
 PRIMARY KEY IDENTITY(1000,1),

 ClientID INT,

 ItemID INT,

 Quantity INT,

 PurchaseDate DATE,

 FOREIGN KEY(ClientID)

 REFERENCES Clients(ClientID),

 FOREIGN KEY(ItemID)

 REFERENCES Inventory(ItemID)
)
INSERT INTO Purchases
(ClientID,ItemID,Quantity,PurchaseDate)

VALUES

(1,100,1,'2026-05-01'),

(2,101,2,'2026-05-02'),

(3,104,3,'2026-05-03'),

(1,102,1,'2026-05-04'),

(4,103,1,'2026-05-05')

SELECT * FROM Clients
SELECT * FROM Inventory
SELECT * FROM Purchases
SELECT * FROM ItemGroups

--------INNER JOIN---------------------
-------------------VIEW---------------------------------
CREATE VIEW ClientPurchaseView AS
SELECT C.ClientName,P.Quantity,P.PurchaseDate
FROM Clients C
INNER JOIN Purchases P
ON C.ClientID
=
P.ClientID

-------------LEFT JOIN---------------
INSERT INTO Clients
(ClientName,ClientCity,ClientEmail)

VALUES

('Karan','Jaipur','karan@gmail.com')
------------------------
SELECT *
FROM Purchases
SELECT C.ClientName,P.Quantity,P.PurchaseDate
FROM Clients C
LEFT JOIN Purchases P
ON C.ClientID
=
P.ClientID


-----------RIGHT JOIN------------------
SELECT C.ClientName,P.Quantity,P.PurchaseDate
FROM Clients C
Right JOIN Purchases P
ON C.ClientID
=
P.ClientID

------------------FULL JOIN--------------------
SELECT C.ClientName,P.Quantity,P.PurchaseDate 
FROM Clients C
FULL JOIN Purchases P
ON C.ClientID = P.ClientID

------CROSS JOIN------------
SELECT C.ClientName,I.ItemName
FROM Clients C
CROSS JOIN Inventory I

--------------VIEW--------------------
SELECT * FROM ClientPurchaseView
------------------------- SINGLEROW SUBQUERY------------------
SELECT * FROM Employee WHERE Salary=(SELECT MAX(Salary) FROM Employee)
SELECT * FROM Employee WHERE Salary=(SELECT MIN(Salary) FROM Employee) 
SELECT * FROM Employee WHERE Salary>(SELECT AVG(Salary) FROM Employee)
SELECT * FROM Employee WHERE Salary<(SELECT AVG(Salary) FROM Employee)

-----------MULTIROW SUBQUERY------------------------

SELECT * FROM Employee WHERE City IN(SELECT City FROM  Employee WHERE Salary>40000)

--------CORELATED SUBQUERY-----------
