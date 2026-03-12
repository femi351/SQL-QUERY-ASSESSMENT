-- question 1
-- Top Selling Product by Revenue.

SELECT * FROM Production_Product;
SELECT * FROM Sales_SalesOrderDetail ;

SELECT p.Name AS ProductName, SUM(sod.LineTotal) AS TotalRevenue
FROM Sales_SalesOrderDetail AS sod
INNER JOIN Production_Product AS p
ON sod.ProductID = p.ProductID
GROUP BY p.Name
ORDER BY TotalRevenue DESC;

-- QUESTION 2
-- Top 5 Products by Quantity Sold

SELECT p.Name, SUM(sod.OrderQty) AS TotalQuantity
FROM Sales_SalesOrderDetail AS sod
JOIN Production_Product AS p
ON sod.ProductID = p.ProductID
GROUP BY p.Name
ORDER BY TotalQuantity DESC;

-- QUESTION 3
-- Orders with Customer Names

SELECT * FROM Sales_SalesOrderHeader;
SELECT * FROM sales_customer;
SELECT * FROM Person_Person;

SELECT soh.SalesOrderID, p.FirstName,' ', p.LastName AS CustomerName, soh.OrderDate, soh.TotalDue
FROM Sales_SalesOrderHeader AS soh
JOIN Sales_Customer AS C
ON soh.CustomerID = C.CustomerID
JOIN Person_Person AS p
ON c.PersonID = p.BusinessEntityID;

-- QUESTION 4
-- Total Sales by Territory

SELECT * FROM Sales_SalesOrderHeader;
SELECT * FROM Sales_SalesTerritory;

SELECT st.Name AS Territory, SUM(soh.TotalDue) AS TotalSales
FROM Sales_SalesOrderHeader AS soh
JOIN Sales_SalesTerritory AS st
ON soh.TerritoryID = st.TerritoryID
GROUP BY st.Name
ORDER BY TotalSales DESC;

-- QUESTION 5
-- Products Never Sold
SELECT * FROM Production_Product;
SELECT * FROM Sales_SalesOrderDetail;

SELECT p.Name
FROM Production_Product AS p
LEFT JOIN Sales_SalesOrderDetail AS sod
ON p.ProductID = sod.ProductID
WHERE sod.ProductID IS NULL;

-- QUESTION 6
-- Customers Without Orders
SELECT * FROM Sales_Customer;
SELECT * FROM Person_Person;
SELECT * FROM Sales_SalesOrderHeader;

SELECT p.FirstName, ' ', p.LastName AS CustomerName
FROM Sales_Customer AS c
JOIN Person_Person AS p
ON c.PersonID = p.BusinessEntityID
LEFT JOIN Sales_SalesOrderHeader AS soh
ON c.CustomerID = soh.CustomerID
WHERE soh.SalesOrderID IS NULL;

-- QUESTION 7
-- Orders with More Than 5 Different Items

SELECT * FROM Sales_SalesOrderDetail;

SELECT SalesOrderID, COUNT(ProductID) AS ItemCount
FROM Sales_SalesOrderDetail
GROUP BY SalesOrderID
HAVING COUNT(ProductID) > 5;

-- QUESTION 8
-- Vendor with Most Purchase Orders

SELECT * FROM Purchasing_PurchaseOrderHeader;
SELECT * FROM Purchasing_Vendor;

SELECT v.Name, COUNT(poh.PurchaseOrderID) AS TotalOrders
FROM Purchasing_PurchaseOrderHeader AS poh
JOIN Purchasing_Vendor AS v
ON poh.VendorID = v.BusinessEntityID
GROUP BY v.Name
ORDER BY TotalOrders DESC;

-- QUESTION 9
-- Employees with Most Sales Orders

SELECT * FROM Sales_SalesOrderHeader;
SELECT * FROM HumanResources_Employee;

SELECT e.BusinessEntityID, COUNT(soh.SalesOrderID) AS OrdersHandled
FROM Sales_SalesOrderHeader AS soh
JOIN HumanResources_Employee AS e
ON soh.SalesPersonID = e.BusinessEntityID
GROUP BY e.BusinessEntityID
ORDER BY OrdersHandled DESC;

-- QUESTION 10
-- Average Order Value per Customer

SELECT * FROM Sales_SalesOrderHeader;
SELECT * FROM Sales_Customer;
SELECT * FROM Person_Person;

SELECT p.Firstname, ' ', p.LastName AS CustomerName, AVG(soh.TotalDue) AS AvgOrderValue
FROM Sales_SalesOrderHeader AS soh
JOIN Sales_Customer AS c
ON soh.CustomerID = c.CustomerID
JOIN Person_Person AS p
ON c.PersonID = p.BusinessEntityID
GROUP BY p.Firstname, p.LastName
ORDER BY AvgOrderValue DESC;

-- QUESTION 11
-- Most Recent Order per Customer
SELECT * FROM Sales_SalesOrderHeader;
SELECT * FROM Sales_Customer;
SELECT * FROM Person_Person;

SELECT p.FirstName, ' ', p.LastName AS CustomerName, MAX(soh.OrderDate) AS LastOrderDate
FROM Sales_SalesOrderHeader AS soh
JOIN Sales_Customer AS c
ON soh.CustomerID = c.CustomerID
JOIN Person_Person AS p
ON c.PersonID = p.BusinessEntityID
GROUP BY p.FirstName, p.LastName; 

-- QUESTION 12
-- Territory with Highest Sales
SELECT * FROM Sales_SalesOrderHeader;
SELECT * FROM Sales_SalesTerritory;

SELECT st.Name, SUM(soh.TotalDue) AS TotalSales
FROM Sales_SalesOrderHeader AS soh
JOIN Sales_SalesTerritory AS st
ON soh.TerritoryID = st.TerritoryID
GROUP BY st.Name
ORDER BY TotalSales DESC;

-- QUESTION 13
-- Products with Their Category and Subcategory
SELECT * FROM Production_Product;
SELECT * FROM Production_ProductSubcategory;
SELECT * FROM Production_ProductCategory;

SELECT p.Name AS ProductName, psc.Name AS SubCategory, pc.Name AS Category
FROM Production_Product AS p
JOIN Production_ProductSubcategory AS psc
ON p.ProductSubcategoryID = psc.ProductSubcategoryID
JOIN Production_ProductCategory AS pc
ON psc.ProductCategoryID = pc.ProductCategoryID;
