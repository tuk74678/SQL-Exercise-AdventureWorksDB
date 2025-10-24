--Use Northwind Database
USE Northwind
GO

--1
SELECT DISTINCT e.City
FROM Employees e JOIN Customers c ON e.City = c.City

--2
--a Subquery
SELECT DISTINCT c.City
FROM Customers c
WHERE c.City NOT IN (               --NOT IN will filter out the city that doesnt have employee
    SELECT DISTINCT e.City 
    FROM Employees e
)

--b Non-subquery
SELECT DISTINCT c.City
FROM Customers c LEFT JOIN Employees e ON c.City = e.City 
WHERE e.City IS NULL                --filter to get only the non-matching cities

--3
SELECT p.ProductName, (SELECT SUM(od.Quantity) FROM [Order Details] od WHERE od.ProductID = p.ProductID) AS TotalQtyOrdered
FROM Products p
ORDER BY TotalQtyOrdered DESC

--4
SELECT c.City, SUM(od.Quantity) AS TotalProdOrdered
FROM Customers c JOIN Orders o ON c.CustomerID = o.CustomerID JOIN [Order Details] od ON od.OrderID = o.OrderID
GROUP BY c.City
ORDER BY TotalProdOrdered DESC

--5
SELECT City, COUNT(CustomerID) AS CustCount             --Count the total of customers in that city
FROM Customers
GROUP BY City
HAVING COUNT(CustomerID) >= 2                           --filter only get the city with at least 2 or more customers
ORDER BY CustCount DESC

