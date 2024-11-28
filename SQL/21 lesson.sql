-- 1. Оконные функции (Window Functions) с примером из AdventureWorks2017
-- Используем таблицу "HumanResources.Employee" для примеров.

-- Пример 1: Агрегатные функции в качестве оконных функций
-- Рассчитываем общую сумму и среднее значение зарплат по отделам, используя таблицу "HumanResources.Employee"

SELECT 
    e.BusinessEntityID,
    e.JobTitle,
    VacationHours,
    e.JobTitle,
    SUM(e.VacationHours) OVER (PARTITION BY e.JobTitle) AS TotalSalaryInDepartment, -- Сумма зарплат по отделам
    AVG(VacationHours) OVER (PARTITION BY e.JobTitle) AS AvgSalaryInDepartment,   -- Средняя зарплата по отделам
    MAX(VacationHours) OVER (PARTITION BY e.JobTitle) AS MaxSalaryInDepartment    -- Максимальная зарплата по отделам
FROM HumanResources.Employee AS e;

-- Пример 2: Использование оконной функции для расчета накопительных сумм
-- Рассчитываем накопительную сумму зарплат по сотрудникам (сортировка по EmployeeID) в рамках каждого отдела
SELECT 
    e.BusinessEntityID,
    e.JobTitle,
    VacationHours,
    SUM(VacationHours) OVER (PARTITION BY e.JobTitle ORDER BY e.BusinessEntityID ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS RunningTotal -- Накопительная сумма
FROM HumanResources.Employee AS e;

-- 2. LAG и LEAD
-- Рассмотрим использование функций LAG и LEAD для работы с предыдущими и следующими значениями в таблице "HumanResources.Employee"

-- Пример 1: LAG (Получить зарплату из предыдущей строки)
SELECT 
    e.BusinessEntityID,
    e.JobTitle,
    VacationHours,
    LAG(VacationHours, 1) OVER (PARTITION BY e.JobTitle ORDER BY e.BusinessEntityID) AS PrevSalary -- Зарплата на предыдущей строке
FROM HumanResources.Employee AS e;

-- Пример 2: LEAD (Получить зарплату из следующей строки)
SELECT 
    e.BusinessEntityID,
    e.JobTitle,
    VacationHours,
    LEAD(VacationHours, 1) OVER (PARTITION BY e.JobTitle ORDER BY e.BusinessEntityID) AS NextSalary -- Зарплата на следующей строке
FROM HumanResources.Employee AS e;

-- 3. ROW_NUMBER, RANK и DENSE_RANK
-- Применим функции ROW_NUMBER, RANK и DENSE_RANK для ранжирования сотрудников по зарплате в каждом отделе.

-- Пример 1: ROW_NUMBER (Уникальный номер для каждой строки в пределах отдела, сортируем по зарплате)
SELECT 
    e.BusinessEntityID,
    e.JobTitle,
    VacationHours,
    ROW_NUMBER() OVER (PARTITION BY e.JobTitle ORDER BY VacationHours DESC) AS RowNumberInDepartment -- Уникальный номер по зарплате
FROM HumanResources.Employee AS e;

-- Пример 2: RANK (Присваиваем ранги с пропусками для одинаковых значений зарплаты)
SELECT 
    e.BusinessEntityID,
    e.JobTitle,
    VacationHours,
    RANK() OVER (PARTITION BY e.JobTitle ORDER BY VacationHours DESC) AS RankInDepartment -- Ранг по зарплате с пропусками
FROM HumanResources.Employee AS e;

-- Пример 3: DENSE_RANK (Присваиваем ранги без пропусков при одинаковых зарплатах)
SELECT 
    e.BusinessEntityID,
    e.JobTitle,
    VacationHours,
    DENSE_RANK() OVER (PARTITION BY e.JobTitle ORDER BY VacationHours DESC) AS DenseRankInDepartment -- Ранг по зарплате без пропусков
FROM HumanResources.Employee AS e;

---------------------------------------------------

-- 4. User Defined Functions (UDF) с примером из AdventureWorks2017
-- Пример создания и использования пользовательской функции для объединения имени и фамилии сотрудника.

-- Создание функции для получения полного имени сотрудника
CREATE FUNCTION dbo.GetFullName(@LoginID NVARCHAR(50), @JobTitle NVARCHAR(50))
RETURNS NVARCHAR(100)
AS
BEGIN
    RETURN @LoginID + ' ' + @JobTitle;
END;

-- Использование функции в запросе для получения полного имени сотрудников
SELECT 
    e.BusinessEntityID,
    dbo.GetFullName(e.FirstName, e.LastName) AS FullName
FROM HumanResources.Employee AS e;

-- Пользовательские функции (UDF) полезны для инкапсуляции логики, например, для вычисления 
-- полного имени или выполнения других операций, которые могут быть использованы в запросах.

---------------------------------------------------

-- 5. Common Table Expressions (CTE) с примером из AdventureWorks2017
-- CTE (Common Table Expressions) позволяют создавать временные результирующие таблицы.

-- Пример: Получим сотрудников с зарплатой выше средней по компании

WITH AvgSalaryCTE AS (
    SELECT 
        AVG(VacationHours) AS AvgSalary
    FROM HumanResources.Employee
)
SELECT 
    e.BusinessEntityID,
    e.LoginID,
    VacationHours,
    a.AvgSalary
FROM HumanResources.Employee AS e
CROSS JOIN AvgSalaryCTE AS a
WHERE VacationHours > a.AvgSalary;

-- CTE позволяет создать промежуточный результат (например, среднюю зарплату по всем сотрудникам) 
-- и использовать его в основном запросе, улучшая читаемость и структуру.

---------------------------------------------------

-- 6. Табличные User Defined Functions (Table-Valued Functions) с примером из AdventureWorks2017
-- Табличные функции (TVF) возвращают таблицу как результат, которая может быть использована в запросах.


-- Табличные UDF позволяют создавать функции, которые возвращают таблицы и могут быть использованы 
-- в любом месте, где обычно используется таблица в запросе (например, в JOIN, WHERE и т.д.).

---------------------------------------------------

-- 7. Stored Procedures с примером из AdventureWorks2017
-- Хранимые процедуры позволяют создавать и выполнять набор SQL инструкций, которые могут быть сохранены в базе данных.

-- Пример создания хранимой процедуры для получения деталей сотрудника по ID

CREATE PROCEDURE dbo.GetEmployeeDetails
    @EmployeeID INT
AS
BEGIN
    SELECT 
        BusinessEntityID,
        LoginID
        JobTitle,
        VacationHours
    FROM HumanResources.Employee
    WHERE BusinessEntityID = @EmployeeID;
END;

-- Вызов хранимой процедуры для получения информации о сотруднике с EmployeeID = 1
EXEC dbo.GetEmployeeDetails @EmployeeID = 1;

-- Хранимые процедуры позволяют инкапсулировать сложную логику, выполнять повторяющиеся операции и 
-- минимизировать ошибки при выполнении запросов.

