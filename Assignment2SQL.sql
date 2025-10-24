USE AdventureWorks2019;
GO

--1 Answer: There are 504 products in the Production.Product table?
SELECT COUNT(ProductID) AS TotalProduct
FROM Production.Product

--2 Total Product in SubCategories is 295
SELECT COUNT(ProductID) AS ProductInSubCat
FROM Production.Product
WHERE ProductSubcategoryID IS NOT NULL

--3
SELECT ProductSubcategoryID, COUNT(ProductID) AS CountedProducts
FROM Production.Product
GROUP BY ProductSubcategoryID           --use GROUP BY for non-aggregated field

--4 209 of the products don't have 
SELECT COUNT(ProductID) AS ProdWithoutSubcategories
FROM Production.Product
WHERE ProductSubcategoryID IS NULL

--5
SELECT SUM(Quantity) AS TotalQuantity
FROM Production.ProductInventory

--6
SELECT ProductID, SUM(Quantity) AS TheSum
FROM Production.ProductInventory
WHERE LocationID = 40
GROUP BY ProductID                 
HAVING SUM(Quantity) < 100         --we only want total quantity less than 100 so <

--7
SELECT Shelf, ProductID, SUM(Quantity) AS TheSum
FROM Production.ProductInventory
WHERE LocationID = 40
GROUP BY Shelf, ProductID                 
HAVING SUM(Quantity) < 100

--8
SELECT AVG(Quantity) AS AvgQty
FROM Production.ProductInventory
WHERE LocationID = 10  

--9
SELECT ProductID, Shelf, AVG(Quantity) AS TheAvg
FROM Production.ProductInventory
GROUP BY ProductID, Shelf

--10
SELECT ProductID, Shelf, AVG(Quantity) AS TheAvg
FROM Production.ProductInventory
WHERE Shelf <> 'N/A'             --<> here is not equal to
GROUP BY ProductID, Shelf

--11
SELECT Color, Class, COUNT(Name) AS TheCount, AVG(ListPrice) AS AvgPrice
FROM Production.Product
WHERE Color IS NOT NULL 
    AND
     Class IS NOT NULL
GROUP BY Color, Class

--JOINS:
--12
SELECT cr.Name AS Country, sp.Name AS Province
FROM Person.CountryRegion cr JOIN Person.StateProvince sp 
        ON cr.CountryRegionCode = sp.CountryRegionCode

--13
SELECT cr.Name AS Country, sp.Name AS Province
FROM Person.CountryRegion cr JOIN Person.StateProvince sp 
        ON cr.CountryRegionCode = sp.CountryRegionCode
WHERE cr.Name IN ('Germany', 'Canada')

--Use Northwind Database
USE Northwind;
GO

--14
SELECT p.ProductName
FROM Products p JOIN [Order Details] od ON p.ProductID = od.ProductID 
                JOIN Orders o ON od.OrderID = o.OrderID
WHERE o.OrderDate >= DATEADD(YEAR, -27, GETDATE())      --wont return anything since all orders are older than 27

--15
SELECT TOP 5 o.ShipPostalCode, COUNT(o.OrderID) AS TotalOrders
FROM Customers c JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY o.ShipPostalCode
ORDER BY TotalOrders DESC

--16
SELECT TOP 5 o.ShipPostalCode, COUNT(o.OrderID) AS TotalOrders
FROM Customers c JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE o.OrderDate >= DATEADD(YEAR, -27, GETDATE()) 
GROUP BY o.ShipPostalCode
ORDER BY TotalOrders DESC

--17
SELECT City, COUNT(CustomerID) AS NumOfCustomer
FROM Customers
GROUP BY City

--18
SELECT City, COUNT(CustomerID) AS NumOfCustomer
FROM Customers
GROUP BY City
HAVING COUNT(CustomerID) > 2        --HAVING is used to filter the aggregated field 

--19
SELECT c.ContactName, o.OrderDate
FROM Customers c JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE o.OrderDate >= '1998-01-01'    --Filter order placed after 1998/01/01
ORDER BY o.OrderDate                 --Sort the order date for better readibility

--20
SELECT c.CustomerID, c.ContactName, MAX(o.OrderDate) AS RecentOrderDate
FROM Customers c JOIN Orders o ON c.CustomerID = o.CustomerID
Group BY c.CustomerID, c.ContactName
ORDER BY RecentOrderDate DESC

--21
SELECT c.CustomerID, c.ContactName, COUNT(od.ProductID) AS TotalProductPurchased
FROM Customers c JOIN Orders o ON c.CustomerID = o.CustomerID
                 JOIN [Order Details] od ON o.OrderID = od.OrderID
GROUP BY c.CustomerID, c.ContactName
ORDER BY TotalProductPurchased DESC        --Sort from who purchased the most product to least

--22
SELECT c.CustomerID, COUNT(od.ProductID) AS TotalProductPurchased
FROM Customers c JOIN Orders o ON c.CustomerID = o.CustomerID
                 JOIN [Order Details] od ON o.OrderID = od.OrderID
GROUP BY c.CustomerID
HAVING COUNT(od.ProductID) > 100           --Filter the customer who purchased more than 100

--23
SELECT s.CompanyName AS SupplierCompanyName, sh.CompanyName AS ShippingCompanyName
FROM Suppliers s
CROSS JOIN Shippers sh          --CROSS JOIN shows all the possible combinations Supplier X Shipper
ORDER BY s.CompanyName, sh.CompanyName;

--24
SELECT o.OrderDate, p.ProductName
FROM Products p JOIN [Order Details] od ON p.ProductID = od.ProductID
                JOIN Orders o ON od.OrderID = o.OrderID
ORDER BY o.OrderDate

--25
SELECT e1.FirstName + ' ' + e1.LastName AS Employee1,
       e2.FirstName + ' ' + e2.LastName AS Employee2,
       e1.Title
FROM Employees e1               --Self Join
JOIN Employees e2 ON e1.Title = e2.Title AND e1.EmployeeID < e2.EmployeeID      --Do this to avoid duplicate pairs or self-pairs
ORDER BY e1.Title;

--26
SELECT m.EmployeeID AS ManagerID,
       m.FirstName + ' ' + m.LastName AS ManagerName,
       COUNT(e.ReportsTo) AS NumReports
FROM Employees m JOIN Employees e ON m.EmployeeID = e.ReportsTo             --Self Join
GROUP BY m.EmployeeID, m.FirstName, m.LastName
HAVING COUNT(e.ReportsTo) > 2

--27
SELECT City, CompanyName AS Name, ContactName, 'Customer' AS Type
FROM Customers
UNION ALL                           --UNION ALL to append rows from both SELECT Statements
SELECT City, CompanyName AS Name, ContactName, 'Supplier' AS Type
FROM Suppliers
ORDER BY City, Type








