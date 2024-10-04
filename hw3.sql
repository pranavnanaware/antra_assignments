SELECT DISTINCT City
FROM Employees
WHERE City IN (SELECT City FROM Customers);

SELECT DISTINCT City
FROM Customers
WHERE City NOT IN (SELECT DISTINCT City FROM Employees);

SELECT DISTINCT c.City
FROM Customers c
LEFT JOIN Employees e ON c.City = e.City
WHERE e.City IS NULL;

SELECT p.ProductName, SUM(od.Quantity) AS TotalOrderedQuantity
FROM Products p
JOIN [Order Details] od ON p.ProductID = od.ProductID
GROUP BY p.ProductName;


SELECT c.City, SUM(od.Quantity) AS TotalProductsOrdered
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN [Order Details] od ON o.OrderID = od.OrderID
GROUP BY c.City;

SELECT City
FROM Customers
GROUP BY City
HAVING COUNT(CustomerID) >= 2;

SELECT c.City
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN [Order Details] od ON o.OrderID = od.OrderID
GROUP BY c.City
HAVING COUNT(DISTINCT od.ProductID) >= 2;

SELECT DISTINCT c.CustomerID, c.CompanyName
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE o.ShipCity <> c.City;

WITH ProductPopularity AS (
    SELECT TOP 5
        p.ProductID, 
        p.ProductName, 
        AVG(od.UnitPrice) AS AveragePrice,
        SUM(od.Quantity) AS TotalOrderedQuantity
    FROM 
        Products p
    JOIN 
        [Order Details] od ON p.ProductID = od.ProductID
    GROUP BY 
        p.ProductID, 
        p.ProductName
    ORDER BY 
        TotalOrderedQuantity DESC
),
CityPopularity AS (
    SELECT 
        od.ProductID, 
        c.City, 
        SUM(od.Quantity) AS CityTotal
    FROM 
        [Order Details] od
    JOIN 
        Orders o ON od.OrderID = o.OrderID
    JOIN 
        Customers c ON o.CustomerID = c.CustomerID
    GROUP BY 
        od.ProductID, 
        c.City
)

SELECT 
    pp.ProductName, 
    pp.AveragePrice, 
    cp.City
FROM 
    ProductPopularity pp
JOIN 
    CityPopularity cp ON pp.ProductID = cp.ProductID
WHERE 
    cp.CityTotal = (SELECT MAX(CityTotal) FROM CityPopularity WHERE ProductID = pp.ProductID);

SELECT DISTINCT e.City
FROM Employees e
WHERE e.City NOT IN (SELECT DISTINCT o.ShipCity FROM Orders o);

SELECT DISTINCT e.City
FROM Employees e
LEFT JOIN Orders o ON e.City = o.ShipCity
WHERE o.ShipCity IS NULL;

WITH EmployeeOrders AS (
    SELECT e.City, COUNT(o.OrderID) AS OrderCount
    FROM Employees e
    JOIN Orders o ON e.EmployeeID = o.EmployeeID
    GROUP BY e.City
),
ProductQuantity AS (
    SELECT c.City, SUM(od.Quantity) AS TotalQuantity
    FROM Customers c
    JOIN Orders o ON c.CustomerID = o.CustomerID
    JOIN [Order Details] od ON o.OrderID = od.OrderID
    GROUP BY c.City
)
SELECT e.City
FROM EmployeeOrders e
JOIN ProductQuantity p ON e.City = p.City
ORDER BY e.OrderCount DESC, p.TotalQuantity DESC

-- TO REMOVE DUPLICATES -- 

WITH CTE AS (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY ColumnName1, ColumnName2, ... ORDER BY (SELECT NULL)) AS RowNum
    FROM YourTableName
)
DELETE FROM CTE WHERE RowNum > 1;

