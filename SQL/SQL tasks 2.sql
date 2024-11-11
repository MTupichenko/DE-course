/* Task 1 
Напишите скрипт, который с помощью цикла и переменной выводит таблицу умножения для заданного числа.
DECLARE @Number1 INT
	  , @Number2 INT
SET @Number1 = 5
SET @Number2 = 1

WHILE @Number2 <= 10
BEGIN
SELECT @Number1 AS Number1, @Number2 AS Number2, @Number1*@Number2 AS Result
SET @Number2 = @Number2+1
END*/


/* Task 2
Таблицы: HumanResources.Employee
Описание задачи: С помощью переменной найдите всех сотрудников, которые работают в компании дольше заданного количества лет. 
1 ВАРИАНТ
DECLARE @Years INT
SET @Years = 15

SELECT YEAR(GETDATE()) - YEAR(hr.HireDate) AS AmountOFYear, *
FROM HumanResources.Employee hr
WHERE YEAR(GETDATE()) - YEAR(hr.HireDate) > @Years

2 ВАРИАНТ
DECLARE @Years INT
SET @Years = 15

SELECT DATEDIFF(YEAR, hr.HireDate, GETDATE()) AS AmountOFYear, *
FROM HumanResources.Employee hr
WHERE DATEDIFF(YEAR, hr.HireDate, GETDATE()) > @Years
*/


/* Task 3 Таблицы: Sales.Customer, Sales.SalesOrderHeader
Описание задачи: Напишите запрос с переменной и подзапросом, чтобы найти всех клиентов, 
которые потратили в сумме больше заданной суммы на все свои заказы.

DECLARE @Sum DECIMAL (10, 4)
SET @Sum = 20000

SELECT *
FROM Sales.Customer sc
WHERE sc.CustomerID IN (SELECT sso.CustomerID
						FROM Sales.SalesOrderHeader sso
						GROUP BY sso.CustomerID
						HAVING SUM(sso.TotalDue) > @Sum)*/


/* Task 4 Таблицы: Sales.SalesOrderDetail
Sales.SalesOrderHeader
Production.Product
Описание задачи: Напишите запрос, который с использованием переменной и подзапроса определяет 
самый продаваемый товар (по количеству проданных единиц) для каждого года.
*/
 
SELECT * FROM Sales.SalesOrderDetail sd
SELECT * FROM Sales.SalesOrderHeader so
SELECT * FROM Production.Product pp


SELECT pp.Name, pp.ProductID, COUNT(pp.ProductID) AS Numbers, YEAR (so.OrderDate) AS Year
FROM Production.Product pp
JOIN Sales.SalesOrderDetail sd ON sd.ProductID = pp.ProductID
JOIN Sales.SalesOrderHeader so ON so.SalesOrderID = sd.SalesOrderID
GROUP BY pp.ProductID, YEAR (so.OrderDate), pp.Name
ORDER BY YEAR (so.OrderDate), COUNT(pp.ProductID)

