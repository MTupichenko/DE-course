/*1.Напишите запрос, чтобы получить имена поставщиков и названия продуктов, которые они поставляют (Purchasing.ProductVendor, Purchasing.Vendor, Production.Product)
SELECT * FROM Purchasing.ProductVendor
SELECT * FROM Purchasing.Vendor
SELECT * FROM Production.Product

SELECT pv.Name, pp.Name 
FROM Production.Product pp
INNER JOIN Purchasing.ProductVendor ppv ON pp.ProductID = ppv.ProductID  
INNER JOIN Purchasing.Vendor pv ON pv.BusinessEntityID = ppv.BusinessEntityID
*/

/*2.Напишите запрос, который выведет имена менеджеров по продажам, их фамилии и территорию, 
которую они отвечают (Sales.SalesPerson, Person.Person, Sales.SalesTerritory)
SELECT * FROM Sales.SalesPerson
SELECT * FROM Person.Person
SELECT * FROM Sales.SalesTerritory

SELECT pp.FirstName, pp.LastName, [sst].[Name] as [Territory], sst.CountryRegionCode, [sst].[Group]
FROM Sales.SalesPerson ssp
INNER JOIN Person.Person pp ON pp.BusinessEntityID = ssp.BusinessEntityID
INNER JOIN Sales.SalesTerritory sst ON sst.TerritoryID = ssp.TerritoryID
*/

/*3.Напишите запрос, который выведет ID заказа, дату заказа, а также адрес доставки, включая город и почтовый индекс. 
(Sales.SalesOrderHeader, Person.BusinessEntityAddress, Person.Address) - НЕ НАШЛА, по какому критерию связать 
таблицу Sales.SalesOrderHeader и Person.BusinessEntityAddress*/

/*4.Напишите запрос, чтобы получить ID продукта, его название и название категории, к которой он относится. (Production.Product, Production.ProductSubcategory, Production.ProductCategory)
SELECT * FROM [Production].[Product]
SELECT * FROM [Production].[ProductSubcategory]
SELECT * FROM [Production].[ProductCategory]

SELECT pp.ProductID, pp.Name, ppc.Name as [Category]
FROM [Production].[Product] pp
INNER JOIN [Production].[ProductSubcategory] pps ON pps.ProductSubcategoryID = pp.ProductSubcategoryID
INNER JOIN [Production].[ProductCategory] ppc ON ppc.ProductCategoryID = pps.ProductCategoryID */


/*5.Напишите запрос, который выведет список сотрудников с указанием их имени, фамилии и названия отдела, в котором они работают. 
(HumanResources.Employee, Person.Person, HumanResources.EmployeeDepartmentHistory, HumanResources.Department)
SELECT * FROM HumanResources.Employee --Не совсем поняла, зачем эта таблица
SELECT * FROM Person.Person
SELECT * FROM HumanResources.EmployeeDepartmentHistory
SELECT * FROM HumanResources.Department

SELECT pp.FirstName, pp.LastName, hrd.Name as [Department]
FROM Person.Person pp
INNER JOIN HumanResources.EmployeeDepartmentHistory hr ON hr.BusinessEntityID = pp.BusinessEntityID
INNER JOIN HumanResources.Department hrd ON hrd.DepartmentID = hr.DepartmentID*/

/*6.Напишите запрос, чтобы вывести список сотрудников, занимающихся продажами, которые участвовали в оформлении заказов. 
Отобразите имя и фамилию сотрудника, ID заказа, имя клиента (я вывела ID), территорию и адрес доставки (включая город и почтовый индекс). 
Включите в результаты всех сотрудников, независимо от того, есть ли у них заказы или нет (используйте LEFT JOIN) 
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
LEFT JOIN Sales.Customer sc ON sc.CustomerID = ssoh.CustomerID --не нашла таблицу с именами клиентов, поэтому вывожу их Person ID из таблицы Sales.Customer
LEFT JOIN Sales.SalesTerritory sst ON sst.TerritoryID = ssoh.TerritoryID
LEFT JOIN Person.BusinessEntityAddress pbea ON pbea.BusinessEntityID = ssp.BusinessEntityID
LEFT JOIN Person.Address pa ON pa.AddressID = pbea.AddressID
*/

/*7.Напишите запрос, чтобы найти все продукты, включая те, у которых нет зарегистрированных поставщиков. 
Выведите ID продукта, название продукта, название категории и имя поставщика (если он есть). 
Используйте LEFT JOIN для обеспечения включения всех продуктов в результат. 
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

