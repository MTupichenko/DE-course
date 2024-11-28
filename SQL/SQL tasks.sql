/*TASK 1
Подсчитайте общее количество заказов и среднюю сумму заказа по каждому году. Включите только те годы, где средняя сумма заказа превышает 2000. 
Добавьте категорию: "High Demand" для лет с более чем 500 заказами, "Medium Demand" для лет с 300-500 заказами и "Low Demand" для остальных. 
Укажите дату, количество заказов, среднюю сумму заказа и категорию.
Используйте таблицу Sales.SalesOrderHeader

SELECT YEAR(sso.OrderDate) AS Year
	  , COUNT(sso.SalesOrderID) AS OderAmount
	  , AVG(sso.TotalDue) AS AverageSum
	  , CASE 
	    WHEN COUNT(sso.SalesOrderID) > 500
		THEN 'High Demand'
		WHEN COUNT(sso.SalesOrderID) BETWEEN 300 AND 500 
		THEN 'Medium Demand'
		ELSE 'Low Demand'
		END AS Category
FROM Sales.SalesOrderHeader sso
GROUP BY YEAR(sso.OrderDate)
HAVING AVG(sso.TotalDue) > 2000
*/

/*Task 2 
Найдите общую сумму продаж и средний процент скидки по каждой категории продукта. Выберите только категории, где общая сумма продаж превышает 50,000. 
Добавьте категорию: "Top Category" для категорий с суммой продаж более 200,000, "Mid Category" для категорий с суммой от 100,000 до 200,000 
и "Low Category" для всех остальных. Укажите категорию, общую сумму продаж, средний процент скидки и категорию уровня продаж.
Используйте таблицы Sales.SalesOrderDetail, Production.Product, Production.ProductSubcategory, и Production.ProductCategory.
SELECT ppc.Name
	  , SUM (sso.LineTotal) AS TotalSales
	  , AVG (sso.UnitPriceDiscount) AS AverageDiscount
	  , CASE
	   WHEN SUM (sso.LineTotal) > 200000 THEN 'Top Category'
	   WHEN SUM (sso.LineTotal) BETWEEN 100000 AND 200000 THEN 'Mid Category'
	   ELSE 'Low category'
	   END AS Category
FROM Sales.SalesOrderDetail sso
JOIN Production.Product pp ON pp.ProductID = sso.ProductID
JOIN Production.ProductSubcategory pps ON pps.ProductSubcategoryID = pp.ProductSubcategoryID
JOIN Production.ProductCategory ppc ON ppc.ProductCategoryID = pps.ProductCategoryID
GROUP BY ppc.Name
HAVING SUM (sso.LineTotal) > 50000
*/


/*Task 3
Подсчитайте среднюю стоимость заказа и общее количество заказов по каждому региону (StateProvince). 
Включите только регионы, где средняя стоимость заказа превышает 1500. Добавьте категорию: 
"Expensive" для регионов со средней стоимостью заказа выше 3000, "Moderate" для стоимости от 2000 до 3000 
и "Affordable" для остальных. Укажите регион, среднюю стоимость заказа, количество заказов и категорию.
Используйте таблицы Sales.SalesOrderHeader, Person.Address, и Person.StateProvince.
SELECT psp.Name
	  , AVG (sso.TotalDue) AS AverageCost
	  , COUNT (sso.SalesOrderID) AS AmountOFOrder
	  , CASE
	  WHEN AVG (sso.TotalDue) > 3000 THEN 'Expensive'
	  WHEN AVG (sso.TotalDue) BETWEEN 2000 AND 3000 THEN 'Moderate'
	  ELSE 'Affordable'
	  END AS Category
FROM Sales.SalesOrderHeader sso
JOIN Person.Address pa ON pa.AddressID = sso.ShipToAddressID
JOIN Person.StateProvince psp ON psp.StateProvinceID = pa.StateProvinceID
GROUP BY psp.Name
HAVING AVG(sso.TotalDue) > 1500*/


/*Task 4
Найдите средний процент скидки и количество заказов для каждого дня недели. 
Включите только те дни, где количество заказов превышает 100. Добавьте категорию: 
"Peak Day" для дней с более чем 300 заказами, "High Traffic" для 200-300 заказов и "Regular" для остальных. 
Укажите день недели, средний процент скидки, количество заказов и категорию.
Используйте таблицы Sales.SalesOrderHeader и Sales.SalesOrderDetail.

SELECT DATENAME (WEEKDAY, sh.OrderDate) AS WeekDay
	  , AVG (sd.UnitPriceDiscount) AS AverageDiscount
	  , COUNT (sh.SalesOrderID) AS AmountOFOrders
	  , CASE
	  WHEN COUNT (sh.SalesOrderID) > 300 THEN 'Peak Day'
	  WHEN COUNT (sh.SalesOrderID) BETWEEN 200 AND 300 THEN 'High Traffic'
	  ELSE 'Regular'
	  END AS Category
FROM Sales.SalesOrderHeader sh
JOIN Sales.SalesOrderDetail sd ON sd.SalesOrderID = sh.SalesOrderID
GROUP BY DATENAME (WEEKDAY, sh.OrderDate)
HAVING COUNT (sh.SalesOrderID) > 100*/


