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

--6
SELECT c.City, COUNT(od.ProductID) AS TotalProdOrdered
FROM Customers c JOIN Orders o ON c.CustomerID = o.CustomerID
                 JOIN [Order Details] od ON o.OrderID = od.OrderID
GROUP BY c.City
HAVING COUNT(od.ProductID) >= 2
ORDER BY TotalProdOrdered DESC

--7
SELECT DISTINCT c.CompanyName, c.ContactName, c.City AS CustomerCity, o.ShipCity
FROM Customers c JOIN Orders o ON c.CustomerID = o.CustomerID 
WHERE o.ShipCity <> c.City
ORDER BY c.ContactName

--8
WITH ProductOrderedCTE 
    AS (
        SELECT p.ProductID, p.ProductName, AVG(od.UnitPrice) AS AvgPrice, SUM(od.Quantity) TotalQtyOrdered
        FROM Products p JOIN [Order Details] od ON p.ProductID = od.ProductID
        GROUP BY p.ProductID, p.ProductName
        ),

     Top5CTE
    AS (
        SELECT TOP 5 ProductID, ProductName, TotalQtyOrdered
        FROM ProductOrderedCTE 
        ORDER BY TotalQtyOrdered DESC
    ),

     CityOrdered
    AS (
        SELECT od.ProductID, c.city, SUM(od.Quantity) AS CityQty
        FROM Customers c JOIN Orders o ON c.CustomerID = o.CustomerID
                        JOIN [Order Details] od ON o.OrderID = od.OrderID
        GROUP BY od.ProductID, c.City
    )

SELECT t.ProductName, AVG(od.UnitPrice) AS AvgPrice,
       co.City AS TopCity, co.CityQty
FROM Top5CTE t JOIN [Order Details] od ON t.ProductID = od.ProductID
               JOIN CityOrdered co ON od.ProductID = co.ProductID
WHERE co.CityQty = (SELECT MAX(CityQty)
                        FROM CityOrdered c2
                        WHERE c2.ProductID = t.ProductID)
GROUP BY  t.ProductName, co.City, co.CityQty  
ORDER BY t.ProductName

--9
