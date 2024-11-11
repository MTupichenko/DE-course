/* Task 1 
Íàïèøèòå ñêðèïò, êîòîðûé ñ ïîìîùüþ öèêëà è ïåðåìåííîé âûâîäèò òàáëèöó óìíîæåíèÿ äëÿ çàäàííîãî ÷èñëà.
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
Òàáëèöû: HumanResources.Employee
Îïèñàíèå çàäà÷è: Ñ ïîìîùüþ ïåðåìåííîé íàéäèòå âñåõ ñîòðóäíèêîâ, êîòîðûå ðàáîòàþò â êîìïàíèè äîëüøå çàäàííîãî êîëè÷åñòâà ëåò. 
1 ÂÀÐÈÀÍÒ
DECLARE @Years INT
SET @Years = 15

SELECT YEAR(GETDATE()) - YEAR(hr.HireDate) AS AmountOFYear, *
FROM HumanResources.Employee hr
WHERE YEAR(GETDATE()) - YEAR(hr.HireDate) > @Years

2 ÂÀÐÈÀÍÒ
DECLARE @Years INT
SET @Years = 15

SELECT DATEDIFF(YEAR, hr.HireDate, GETDATE()) AS AmountOFYear, *
FROM HumanResources.Employee hr
WHERE DATEDIFF(YEAR, hr.HireDate, GETDATE()) > @Years
*/


/* Task 3 Òàáëèöû: Sales.Customer, Sales.SalesOrderHeader
Îïèñàíèå çàäà÷è: Íàïèøèòå çàïðîñ ñ ïåðåìåííîé è ïîäçàïðîñîì, ÷òîáû íàéòè âñåõ êëèåíòîâ, 
êîòîðûå ïîòðàòèëè â ñóììå áîëüøå çàäàííîé ñóììû íà âñå ñâîè çàêàçû.

DECLARE @Sum DECIMAL (10, 4)
SET @Sum = 20000

SELECT *
FROM Sales.Customer sc
WHERE sc.CustomerID IN (SELECT sso.CustomerID
						FROM Sales.SalesOrderHeader sso
						GROUP BY sso.CustomerID
						HAVING SUM(sso.TotalDue) > @Sum)*/


/* Task 4 Òàáëèöû: Sales.SalesOrderDetail
Sales.SalesOrderHeader
Production.Product
Îïèñàíèå çàäà÷è: Íàïèøèòå çàïðîñ, êîòîðûé ñ èñïîëüçîâàíèåì ïåðåìåííîé è ïîäçàïðîñà îïðåäåëÿåò 
ñàìûé ïðîäàâàåìûé òîâàð (ïî êîëè÷åñòâó ïðîäàííûõ åäèíèö) äëÿ êàæäîãî ãîäà.
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

