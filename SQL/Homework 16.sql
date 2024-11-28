/*������� 1
SELECT * 
FROM [Sales].[Customer]
WHERE TerritoryID > 5
ORDER BY TerritoryID DESC*/

/*������� 2
SELECT TOP 10 [ProductID],[Name], [ListPrice]
FROM [Production].[Product]
ORDER BY [ListPrice] DESC*/

/* ������� 3
SELECT [BusinessEntityID], [FirstName], [LastName] 
FROM Person.Person
WHERE [LastName] LIKE 'M%'*/

/*������� 3=4
CREATE TABLE TopCustomers (
	CustomerID INT PRIMARY KEY, 
	FirstName NVARCHAR(30), 
	LastName NVARCHAR(30)
)

INSERT INTO TopCustomers (CustomerID, FirstName, LastName)
VALUES 
	(1, 'Masha', 'Tupichenko'),
	(2, 'Denis', 'Ivaniv'),
	(3, 'Anna', 'Petrova')
SELECT * FROM TopCustomers
ORDER BY LastName ASC*/

/* ������� 5
SELECT [TerritoryID], AVG(TotalDue) AS [AverageOrderAmount] FROM [Sales].[SalesOrderHeader]
WHERE [ShipDate] > [OrderDate]
GROUP BY [TerritoryID]*/

