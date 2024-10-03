SELECT COUNT(*) AS ProductCount
FROM Production.Product;


SELECT COUNT(*) AS CountedProducts
FROM Production.Product
WHERE ProductSubcategoryID IS NOT NULL;


SELECT ProductSubcategoryID, COUNT(*) AS CountedProducts
FROM Production.Product
WHERE ProductSubcategoryID IS NOT NULL
GROUP BY ProductSubcategoryID
ORDER BY ProductSubcategoryID;

SELECT COUNT(*) AS ProductsWithoutSubcategory
FROM Production.Product
WHERE ProductSubcategoryID IS NULL;

SELECT ProductID, SUM(Quantity) AS TheSum
FROM Production.ProductInventory
GROUP BY ProductID
ORDER BY ProductID;

SELECT ProductID, SUM(Quantity) AS TheSum
FROM  Production.ProductInventory
WHERE LocationID = 40
GROUP BY  ProductID
HAVING SUM(Quantity) < 100
ORDER BY ProductID;

SELECT Shelf, ProductID, SUM(Quantity) AS TheSum
FROM Production.ProductInventory
WHERE LocationID = 40
GROUP BY Shelf, ProductID
HAVING SUM(Quantity) < 100
ORDER BY Shelf, ProductID;

SELECT ProductID, AVG(Quantity) AS TheAvg
FROM Production.ProductInventory
WHERE LocationID = 10
GROUP BY ProductID
ORDER BY ProductID;

SELECT ProductID, Shelf, AVG(Quantity) AS TheAvg
FROM Production.ProductInventory
GROUP BY ProductID, Shelf
ORDER BY ProductID, Shelf;

SELECT ProductID, Shelf, AVG(Quantity) AS TheAvg
FROM Production.ProductInventory
WHERE Shelf != 'N/A'
GROUP BY ProductID, Shelf
ORDER BY ProductID, Shelf;

SELECT Color, Class, COUNT(*) AS TheCount, AVG(ListPrice) AS AvgPrice
FROM Production.Product
WHERE Color IS NOT NULL AND Class IS NOT NULL
GROUP BY Color, Class
ORDER BY Color, Class;

SELECT cr.Name AS Country, sp.Name AS Province
FROM Person.CountryRegion cr
INNER JOIN Person.StateProvince sp 
ON cr.CountryRegionCode = sp.CountryRegionCode
ORDER BY cr.Name, sp.Name;


SELECT cr.Name AS Country, sp.Name AS Province
FROM Person.CountryRegion cr
INNER JOIN Person.StateProvince sp 
ON cr.CountryRegionCode = sp.CountryRegionCode
WHERE cr.Name IN ('Germany', 'Canada')
ORDER BY cr.Name, sp.Name;

-- NORTHWIND DATABASE

SELECT DISTINCT p.ProductName
FROM Products p
INNER JOIN [Order Details] od ON p.ProductID = od.ProductID
INNER JOIN Orders o ON od.OrderID = o.OrderID
WHERE DATEDIFF(YEAR, o.OrderDate, GETDATE()) <= 27
ORDER BY p.ProductName;

SELECT TOP 5 o.ShipPostalCode, COUNT(*) AS OrderCount
FROM Orders o
GROUP BY o.ShipPostalCode
ORDER BY COUNT(*) DESC;


SELECT TOP 5 o.ShipPostalCode, COUNT(*) AS OrderCount
FROM Orders o
WHERE DATEDIFF(YEAR, o.OrderDate, GETDATE()) <= 27
GROUP BY o.ShipPostalCode
ORDER BY COUNT(*) DESC;

SELECT c.City, COUNT(*) AS CustomerCount
FROM Customers c
GROUP BY c.City
ORDER BY CustomerCount DESC;


SELECT c.City, COUNT(*) AS CustomerCount
FROM Customers c
GROUP BY c.City
HAVING COUNT(*) > 2
ORDER BY CustomerCount DESC;

SELECT c.CompanyName, o.OrderDate
FROM Customers c
INNER JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE o.OrderDate > '1998-01-01'
ORDER BY o.OrderDate;

SELECT c.CompanyName, MAX(o.OrderDate) AS MostRecentOrderDate
FROM Customers c
INNER JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.CompanyName
ORDER BY MostRecentOrderDate DESC;

SELECT c.CompanyName, COUNT(od.ProductID) AS ProductCount
FROM Customers c
INNER JOIN Orders o ON c.CustomerID = o.CustomerID
INNER JOIN [Order Details] od ON o.OrderID = od.OrderID
GROUP BY c.CompanyName
ORDER BY ProductCount DESC;

SELECT o.CustomerID, COUNT(od.ProductID) AS ProductCount
FROM Orders o
INNER JOIN [Order Details] od ON o.OrderID = od.OrderID
GROUP BY o.CustomerID
HAVING COUNT(od.ProductID) > 100
ORDER BY ProductCount DESC;

SELECT s.CompanyName AS SupplierCompanyName, sh.CompanyName AS ShippingCompanyName
FROM Suppliers s
CROSS JOIN Shippers sh
ORDER BY s.CompanyName, sh.CompanyName;

SELECT o.OrderDate, p.ProductName
FROM Orders o
INNER JOIN [Order Details] od ON o.OrderID = od.OrderID
INNER JOIN Products p ON od.ProductID = p.ProductID
ORDER BY o.OrderDate;

SELECT e1.EmployeeID AS Employee1, e2.EmployeeID AS Employee2, e1.Title
FROM Employees e1
INNER JOIN Employees e2 ON e1.Title = e2.Title AND e1.EmployeeID < e2.EmployeeID
ORDER BY e1.Title;

SELECT e.EmployeeID AS ManagerID, COUNT(*) AS ReportCount
FROM Employees e
INNER JOIN Employees e2 ON e.EmployeeID = e2.ReportsTo
GROUP BY e.EmployeeID
HAVING COUNT(*) > 2
ORDER BY ReportCount DESC;

SELECT c.City, c.CompanyName AS Name, c.ContactName, 'Customer' AS Type
FROM Customers c
UNION
SELECT s.City, s.CompanyName AS Name, s.ContactName, 'Supplier' AS Type
FROM Suppliers s
ORDER BY City, Name;

