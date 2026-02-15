-- Create a database named ECommerceDB and perform the following tasks
-- Create Database
create database ECommerceDB;
use ECommerceDB;

-- Create Tables
create table Categories (
CategoryID INT PRIMARY KEY,
CategoryName VARCHAR(50) NOT NULL UNIQUE
);

Create table Products (
ProductID INT PRIMARY KEY ,
ProductName VARCHAR(100) NOT NULL UNIQUE,
CategoryID INT ,
Price Decimal(10,2) not null,
StockQuantity Int,
foreign key (CategoryID) references Categories(CategoryID)
);

create table Customers(
CustomerID int Primary key,
CustomerName Varchar(100) not null,
Email varchar(100) unique,
JoinDate date
);

Create table Orders(
OrderID int primary key,
CustomerID int,
OrderDate Date not null,
TotalAmount Decimal(10,2),
foreign key (CustomerID) references Customers(CustomerID)
);


-- Insert Data
INSERT INTO Categories VALUES
(1, 'Electronics'),
(2, 'Books'),
(3, 'Home Goods'),
(4, 'Apparel');

INSERT INTO Products VALUES
(101,'Laptop Pro',1,1200.00,50),
(102,'SQL Handbook',2,45.50,200),
(103,'Smart Speaker',1,99.99,150),
(104,'Coffee Maker',3,75.00,80),
(105,'Novel: The Great SQL',2,25.00,120),
(106,'Wireless Earbuds',1,150.00,100),
(107,'Blender X',3,120.00,60),
(108,'T-Shirt Casual',4,20.00,300);

INSERT INTO Customers VALUES
(1,'Alice Wonderland','alice@example.com','2023-01-10'),
(2,'Bob the Builder','bob@example.com','2022-11-25'),
(3,'Charlie Chaplin','charlie@example.com','2023-03-01'),
(4,'Diana Prince','diana@example.com','2021-04-26');

INSERT INTO Orders VALUES
(1001,1,'2023-04-26',1245.50),
(1002,2,'2023-10-12',99.99),
(1003,1,'2023-07-01',145.00),
(1004,3,'2023-01-14',150.00),
(1005,2,'2023-09-24',120.00),
(1006,1,'2023-06-19',20.00);

Select * from Categories;

-- 7.Generate a report showing CustomerName, Email, and the 
-- TotalNumberofOrders for each customer. Include customers who have not placed 
-- any orders, in which case their TotalNumberofOrders should be 0. Order the results 
-- by CustomerName.
SELECT 
    c.CustomerName,
    c.Email,
    COUNT(o.OrderID) AS TotalNumberofOrders
FROM Customers c
LEFT JOIN Orders o 
    ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.CustomerName, c.Email
ORDER BY c.CustomerName; 

-- Question 8 :  Retrieve Product Information with Category: Write a SQL query to 
-- display the ProductName, Price, StockQuantity, and CategoryName for all 
-- products. Order the results by CategoryName and then ProductName alphabetically. 
SELECT 
    p.ProductName,
    p.Price,
    p.StockQuantity,
    c.CategoryName
FROM Products p
JOIN Categories c 
    ON p.CategoryID = c.CategoryID
ORDER BY c.CategoryName, p.ProductName;


-- Question 9 : Write a SQL query that uses a Common Table Expression (CTE) and a 
-- Window Function (specifically ROW_NUMBER() or RANK()) to display the 
-- CategoryName, ProductName, and Price for the top 2 most expensive products in 
-- each CategoryName. 
WITH RankedProducts AS (
    SELECT 
        c.CategoryName,
        p.ProductName,
        p.Price,
        ROW_NUMBER() OVER (
            PARTITION BY c.CategoryName 
            ORDER BY p.Price DESC
        ) AS rn
    FROM Products p
    JOIN Categories c 
        ON p.CategoryID = c.CategoryID
)
SELECT CategoryName, ProductName, Price
FROM RankedProducts
WHERE rn <= 2;