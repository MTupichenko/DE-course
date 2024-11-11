/*TASK 1
����������� ����� ���������� ������� � ������� ����� ������ �� ������� ����. �������� ������ �� ����, ��� ������� ����� ������ ��������� 2000. 
�������� ���������: "High Demand" ��� ��� � ����� ��� 500 ��������, "Medium Demand" ��� ��� � 300-500 �������� � "Low Demand" ��� ���������. 
������� ����, ���������� �������, ������� ����� ������ � ���������.
����������� ������� Sales.SalesOrderHeader

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
������� ����� ����� ������ � ������� ������� ������ �� ������ ��������� ��������. �������� ������ ���������, ��� ����� ����� ������ ��������� 50,000. 
�������� ���������: "Top Category" ��� ��������� � ������ ������ ����� 200,000, "Mid Category" ��� ��������� � ������ �� 100,000 �� 200,000 
� "Low Category" ��� ���� ���������. ������� ���������, ����� ����� ������, ������� ������� ������ � ��������� ������ ������.
����������� ������� Sales.SalesOrderDetail, Production.Product, Production.ProductSubcategory, � Production.ProductCategory.
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
����������� ������� ��������� ������ � ����� ���������� ������� �� ������� ������� (StateProvince). 
�������� ������ �������, ��� ������� ��������� ������ ��������� 1500. �������� ���������: 
"Expensive" ��� �������� �� ������� ���������� ������ ���� 3000, "Moderate" ��� ��������� �� 2000 �� 3000 
� "Affordable" ��� ���������. ������� ������, ������� ��������� ������, ���������� ������� � ���������.
����������� ������� Sales.SalesOrderHeader, Person.Address, � Person.StateProvince.
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
������� ������� ������� ������ � ���������� ������� ��� ������� ��� ������. 
�������� ������ �� ���, ��� ���������� ������� ��������� 100. �������� ���������: 
"Peak Day" ��� ���� � ����� ��� 300 ��������, "High Traffic" ��� 200-300 ������� � "Regular" ��� ���������. 
������� ���� ������, ������� ������� ������, ���������� ������� � ���������.
����������� ������� Sales.SalesOrderHeader � Sales.SalesOrderDetail.

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


