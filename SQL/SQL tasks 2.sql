/* Task 1 
Напишите скрипт, который с помощью цикла и переменной выводит таблицу умножения для заданного числа.
1 ВАРИАНТ
DECLARE @Number1 INT
	  , @Number2 INT
SET @Number1 = 5
SET @Number2 = 1

WHILE @Number2 < 11
BEGIN
SELECT @Number1 AS Number1, @Number2 AS Number2, @Number1*@Number2 AS Result
SET @Number2 = @Number2+1
END

2 ВАРИАНТ
CREATE TABLE MultI (Result INT)
DECLARE @Number INT
SELECT @Number = 6
DECLARE @Counter INT
SELECT @Counter = 1
DELETE MultI
WHILE @Counter < 11
BEGIN
INSERT INTO Multi (Result) 
SELECT @Number * @Counter
SELECT @Counter =  @Counter+1
END
SELECT * FROM MultI
*/

/* Task 2
Таблицы: HumanResources.Employee
Описание задачи: С помощью переменной найдите всех сотрудников, которые работают в компании дольше заданного количества лет. 

DECLARE @Years INT
SET @Years = 15

SELECT DATEDIFF(YEAR, hr.HireDate, GETDATE()) AS AmountOFYear, *
FROM HumanResources.Employee hr
WHERE DATEDIFF(YEAR, hr.HireDate, GETDATE()) > @Years
*/


/* Task 3 Таблицы: Sales.Customer, Sales.SalesOrderHeader
Описание задачи: Напишите запрос с переменной и подзапросом, чтобы найти всех клиентов, 
которые потратили в сумме больше заданной суммы на все свои заказы.
1 ВАРИАНТ
DECLARE @Sum INT
SET @Sum = 20000

SELECT *
FROM Sales.Customer sc
WHERE sc.CustomerID IN (SELECT sso.CustomerID
						FROM Sales.SalesOrderHeader sso
						GROUP BY sso.CustomerID
						HAVING SUM(sso.TotalDue) > @Sum)

2 ВАРИАНТ
DECLARE @Exp INT
SELECT @Exp = 3000

SELECT sc.CustomerID
	 , (SELECT SUM (TotalDue)
	   FROM Sales.SalesOrderHeader sso
	   WHERE sc.CustomerID = sso.CustomerID) AS Total
FROM  Sales.Customer sc
WHERE (SELECT SUM (TotalDue)
	   FROM Sales.SalesOrderHeader sso
	   WHERE sc.CustomerID = sso.CustomerID) > @Exp*/

/* Task 4 Таблицы: Sales.SalesOrderDetail
Sales.SalesOrderHeader
Production.Product
Описание задачи: Напишите запрос, который с использованием переменной и подзапроса определяет 
самый продаваемый товар (по количеству проданных единиц) для каждого года.

1 ВАРИАНТ (по 1 году)
DECLARE @Year INT
SELECT @Year = 2013

SELECT TOP 1  R.*
FROM (SELECT SUM(sod.OrderQty) AS TotalAmount
  , pp.Name
FROM Sales.SalesOrderDetail sod 
JOIN Sales.SalesOrderHeader soh ON soh.SalesOrderID = sod.SalesOrderID
JOIN Production.Product pp ON pp.ProductID = sod.ProductID
WHERE YEAR(soh.OrderDate) = @Year
GROUP BY pp.Name ) R
ORDER BY R.TotalAmount DESC

2 ВАРИАНТ (ВСЕ ГОДА СРАЗУ)
CREATE TABLE Result (ProductName NVARCHAR(MAX)
       , TotalAmount INT
       , OrderYear INT)

--DECLARE @Year INT
--SELECT @Year = 2012
DECLARE @Counter INT
SELECT @Counter = YEAR(MIN(OrderDate))
FROM Sales.SalesOrderHeader

WHILE @Counter <= (SELECT YEAR(MAX(OrderDate)) FROM Sales.SalesOrderHeader)
BEGIN
INSERT INTO Result 
SELECT TOP 1  R.Name
   , R. TotalAmount
   , @Counter
FROM (
SELECT SUM(sod.OrderQty) AS TotalAmount
  , pp.Name
FROM Sales.SalesOrderDetail sod 
JOIN Sales.SalesOrderHeader soh ON soh.SalesOrderID = sod.SalesOrderID
JOIN Production.Product pp ON pp.ProductID = sod.ProductID
WHERE YEAR(soh.OrderDate) = @Counter
GROUP BY pp.Name ) R
ORDER BY R.TotalAmount DESC

SELECT @Counter = @Counter + 1
END
--DELETE Result
SELECT * FROM Result*/