/*1.�������� ������, ����� �������� ����� ����������� � �������� ���������, ������� ��� ���������� (Purchasing.ProductVendor, Purchasing.Vendor, Production.Product)
SELECT * FROM Purchasing.ProductVendor
SELECT * FROM Purchasing.Vendor
SELECT * FROM Production.Product

SELECT pv.Name, pp.Name 
FROM Production.Product pp
INNER JOIN Purchasing.ProductVendor ppv ON pp.ProductID = ppv.ProductID  
INNER JOIN Purchasing.Vendor pv ON pv.BusinessEntityID = ppv.BusinessEntityID
*/

/*2.�������� ������, ������� ������� ����� ���������� �� ��������, �� ������� � ����������, 
������� ��� �������� (Sales.SalesPerson, Person.Person, Sales.SalesTerritory)
SELECT * FROM Sales.SalesPerson
SELECT * FROM Person.Person
SELECT * FROM Sales.SalesTerritory

SELECT pp.FirstName, pp.LastName, [sst].[Name] as [Territory], sst.CountryRegionCode, [sst].[Group]
FROM Sales.SalesPerson ssp
INNER JOIN Person.Person pp ON pp.BusinessEntityID = ssp.BusinessEntityID
INNER JOIN Sales.SalesTerritory sst ON sst.TerritoryID = ssp.TerritoryID
*/

/*3.�������� ������, ������� ������� ID ������, ���� ������, � ����� ����� ��������, ������� ����� � �������� ������. 
(Sales.SalesOrderHeader, Person.BusinessEntityAddress, Person.Address) - �� �����, �� ������ �������� ������� 
������� Sales.SalesOrderHeader � Person.BusinessEntityAddress*/

/*4.�������� ������, ����� �������� ID ��������, ��� �������� � �������� ���������, � ������� �� ���������. (Production.Product, Production.ProductSubcategory, Production.ProductCategory)
SELECT * FROM [Production].[Product]
SELECT * FROM [Production].[ProductSubcategory]
SELECT * FROM [Production].[ProductCategory]

SELECT pp.ProductID, pp.Name, ppc.Name as [Category]
FROM [Production].[Product] pp
INNER JOIN [Production].[ProductSubcategory] pps ON pps.ProductSubcategoryID = pp.ProductSubcategoryID
INNER JOIN [Production].[ProductCategory] ppc ON ppc.ProductCategoryID = pps.ProductCategoryID */


/*5.�������� ������, ������� ������� ������ ����������� � ��������� �� �����, ������� � �������� ������, � ������� ��� ��������. 
(HumanResources.Employee, Person.Person, HumanResources.EmployeeDepartmentHistory, HumanResources.Department)
SELECT * FROM HumanResources.Employee --�� ������ ������, ����� ��� �������
SELECT * FROM Person.Person
SELECT * FROM HumanResources.EmployeeDepartmentHistory
SELECT * FROM HumanResources.Department

SELECT pp.FirstName, pp.LastName, hrd.Name as [Department]
FROM Person.Person pp
INNER JOIN HumanResources.EmployeeDepartmentHistory hr ON hr.BusinessEntityID = pp.BusinessEntityID
INNER JOIN HumanResources.Department hrd ON hrd.DepartmentID = hr.DepartmentID*/

/*6.�������� ������, ����� ������� ������ �����������, ������������ ���������, ������� ����������� � ���������� �������. 
���������� ��� � ������� ����������, ID ������, ��� ������� (� ������ ID), ���������� � ����� �������� (������� ����� � �������� ������). 
�������� � ���������� ���� �����������, ���������� �� ����, ���� �� � ��� ������ ��� ��� (����������� LEFT JOIN) 
(Sales.SalesPerson, Person.Person, Sales.SalesOrderHeader,Sales.Customer, Sales.SalesTerritory,Person.BusinessEntityAddress, Person.Address)
SELECT * FROM Sales.SalesPerson
SELECT * FROM Person.Person
SELECT * FROM Sales.SalesOrderHeader
SELECT * FROM Sales.Customer
SELECT * FROM Sales.SalesTerritory
SELECT * FROM Person.BusinessEntityAddress
SELECT * FROM Person.Address


SELECT pp.FirstName, PP.LastName, ssoh.SalesOrderID, sc.PersonID, sst.Name as [territory], pa.AddressLine1, pa.City, pa.PostalCode
FROM Person.Person pp
LEFT JOIN Sales.SalesPerson ssp ON ssp.BusinessEntityID = pp.BusinessEntityID
LEFT JOIN Sales.SalesOrderHeader ssoh ON ssoh.TerritoryID = ssp.TerritoryID
LEFT JOIN Sales.Customer sc ON sc.CustomerID = ssoh.CustomerID --�� ����� ������� � ������� ��������, ������� ������ �� Person ID �� ������� Sales.Customer
LEFT JOIN Sales.SalesTerritory sst ON sst.TerritoryID = ssoh.TerritoryID
LEFT JOIN Person.BusinessEntityAddress pbea ON pbea.BusinessEntityID = ssp.BusinessEntityID
LEFT JOIN Person.Address pa ON pa.AddressID = pbea.AddressID
*/

/*7.�������� ������, ����� ����� ��� ��������, ������� ��, � ������� ��� ������������������ �����������. 
�������� ID ��������, �������� ��������, �������� ��������� � ��� ���������� (���� �� ����). 
����������� LEFT JOIN ��� ����������� ��������� ���� ��������� � ���������. 
(Production.Product, Production.ProductSubcategory, Production.ProductCategory, Purchasing.ProductVendor, Purchasing.Vendor)
SELECT * FROM [Production].[Product]
SELECT * FROM Production.ProductSubcategory
SELECT * FROM Production.ProductCategory
SELECT * FROM Purchasing.ProductVendor
SELECT * FROM Purchasing.Vendor

SELECT pp.ProductID, pp.Name, pps.Name as [Subcategory], ppc.Name as [Category], pv.Name as [Vendor]
FROM [Production].[Product] pp
LEFT JOIN Production.ProductSubcategory pps ON pps.ProductSubcategoryID = pp.ProductSubcategoryID
LEFT JOIN Production.ProductCategory ppc ON ppc.ProductCategoryID = pps.ProductCategoryID
LEFT JOIN Purchasing.ProductVendor ppv ON ppv.ProductID = pp.ProductID
LEFT JOIN Purchasing.Vendor pv ON pv.BusinessEntityID = ppv.BusinessEntityID
*/

