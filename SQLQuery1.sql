CREATE DATABASE store_db
USE store_db
CREATE TABLE Customers(
	customer_id INT IDENTITY(100,1) PRIMARY KEY,
	customer_name VARCHAR(100) NOT NULL,
	email VARCHAR(100) UNIQUE
	);
CREATE TABLE Orders(
order_id INT IDENTITY(500,1) PRIMARY KEY,
order_date DATE NOT NULL,
total_amount DECIMAL(10,2),
customer_id INT,
FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);
EXEC sp_help 'Orders'

INSERT INTO Customers (customer_name, email) 

VALUES 

('Raju', 'raju@example.com'), 

('Sham', 'sham@example.com'), 

('Baburao', 'baburao@example.com');
INSERT INTO Orders (order_date, total_amount, customer_id) 

VALUES 

('2025-09-15', 1500.00, 100), -- This links to Raju (customer_id 100) 

('2025-09-28', 800.00, 101), -- This links to Sham (customer_id 101) 

('2025-10-05', 2200.00, 100), -- This links to Raju (customer_id 100) 

('2025-10-12', 500.00, 102), -- This links to Baburao (customer_id 102) 

('2025-10-17', 1200.00, 101); -- New order for Sham (customer_id 101)

SELECT * FROM Customers
SELECT * FROM Orders
INSERT INTO Customers VALUES ('Paul','Paul@example.com')
INSERT INTO Orders VALUES ('2025-10-18',3500,103)
DELETE FROM Customers	
WHERE customer_id=101

------------Joins---------------
---Cross join--------
SELECT * FROM 
customers CROSS JOIN Orders 

----Inner join ----
SELECT * FROM
customers INNER JOIN Orders
ON 
	customers.customer_id=Orders.customer_id
SELECT c.customer_name,COUNT(o.order_id) FROM
customers c INNER JOIN orders o
ON
c.customer_id=o.customer_id
GROUP BY c.customer_name	
--LEFT JOIN --RIGHT JOIN -UNION - EXCEPT

CREATE TABLE CompanyHierarchy (

    EmployeeID INT PRIMARY KEY,

    Name VARCHAR(100),

    ManagerID INT

);
INSERT INTO CompanyHierarchy (EmployeeID, Name, ManagerID)

VALUES

(1, 'Sonia Verma', NULL),  -- The CEO

(2, 'Rohan Gupta', 1),     -- Reports to Sonia

(3, 'Amit Sharma', 2),     -- Reports to Rohan

(4, 'Priya Singh', 1),     -- Reports to Sonia

(5, 'Kabir Shah', 2);      -- Reports to Rohan

SELECT * FROM CompanyHierarchy


