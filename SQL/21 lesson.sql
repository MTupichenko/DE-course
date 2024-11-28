-- 1. ������� ������� (Window Functions) � �������� �� AdventureWorks2017
-- ���������� ������� "HumanResources.Employee" ��� ��������.

-- ������ 1: ���������� ������� � �������� ������� �������
-- ������������ ����� ����� � ������� �������� ������� �� �������, ��������� ������� "HumanResources.Employee"

SELECT 
    e.BusinessEntityID,
    e.JobTitle,
    VacationHours,
    e.JobTitle,
    SUM(e.VacationHours) OVER (PARTITION BY e.JobTitle) AS TotalSalaryInDepartment, -- ����� ������� �� �������
    AVG(VacationHours) OVER (PARTITION BY e.JobTitle) AS AvgSalaryInDepartment,   -- ������� �������� �� �������
    MAX(VacationHours) OVER (PARTITION BY e.JobTitle) AS MaxSalaryInDepartment    -- ������������ �������� �� �������
FROM HumanResources.Employee AS e;

-- ������ 2: ������������� ������� ������� ��� ������� ������������� ����
-- ������������ ������������� ����� ������� �� ����������� (���������� �� EmployeeID) � ������ ������� ������
SELECT 
    e.BusinessEntityID,
    e.JobTitle,
    VacationHours,
    SUM(VacationHours) OVER (PARTITION BY e.JobTitle ORDER BY e.BusinessEntityID ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS RunningTotal -- ������������� �����
FROM HumanResources.Employee AS e;

-- 2. LAG � LEAD
-- ���������� ������������� ������� LAG � LEAD ��� ������ � ����������� � ���������� ���������� � ������� "HumanResources.Employee"

-- ������ 1: LAG (�������� �������� �� ���������� ������)
SELECT 
    e.BusinessEntityID,
    e.JobTitle,
    VacationHours,
    LAG(VacationHours, 1) OVER (PARTITION BY e.JobTitle ORDER BY e.BusinessEntityID) AS PrevSalary -- �������� �� ���������� ������
FROM HumanResources.Employee AS e;

-- ������ 2: LEAD (�������� �������� �� ��������� ������)
SELECT 
    e.BusinessEntityID,
    e.JobTitle,
    VacationHours,
    LEAD(VacationHours, 1) OVER (PARTITION BY e.JobTitle ORDER BY e.BusinessEntityID) AS NextSalary -- �������� �� ��������� ������
FROM HumanResources.Employee AS e;

-- 3. ROW_NUMBER, RANK � DENSE_RANK
-- �������� ������� ROW_NUMBER, RANK � DENSE_RANK ��� ������������ ����������� �� �������� � ������ ������.

-- ������ 1: ROW_NUMBER (���������� ����� ��� ������ ������ � �������� ������, ��������� �� ��������)
SELECT 
    e.BusinessEntityID,
    e.JobTitle,
    VacationHours,
    ROW_NUMBER() OVER (PARTITION BY e.JobTitle ORDER BY VacationHours DESC) AS RowNumberInDepartment -- ���������� ����� �� ��������
FROM HumanResources.Employee AS e;

-- ������ 2: RANK (����������� ����� � ���������� ��� ���������� �������� ��������)
SELECT 
    e.BusinessEntityID,
    e.JobTitle,
    VacationHours,
    RANK() OVER (PARTITION BY e.JobTitle ORDER BY VacationHours DESC) AS RankInDepartment -- ���� �� �������� � ����������
FROM HumanResources.Employee AS e;

-- ������ 3: DENSE_RANK (����������� ����� ��� ��������� ��� ���������� ���������)
SELECT 
    e.BusinessEntityID,
    e.JobTitle,
    VacationHours,
    DENSE_RANK() OVER (PARTITION BY e.JobTitle ORDER BY VacationHours DESC) AS DenseRankInDepartment -- ���� �� �������� ��� ���������
FROM HumanResources.Employee AS e;

---------------------------------------------------

-- 4. User Defined Functions (UDF) � �������� �� AdventureWorks2017
-- ������ �������� � ������������� ���������������� ������� ��� ����������� ����� � ������� ����������.

-- �������� ������� ��� ��������� ������� ����� ����������
CREATE FUNCTION dbo.GetFullName(@LoginID NVARCHAR(50), @JobTitle NVARCHAR(50))
RETURNS NVARCHAR(100)
AS
BEGIN
    RETURN @LoginID + ' ' + @JobTitle;
END;

-- ������������� ������� � ������� ��� ��������� ������� ����� �����������
SELECT 
    e.BusinessEntityID,
    dbo.GetFullName(e.FirstName, e.LastName) AS FullName
FROM HumanResources.Employee AS e;

-- ���������������� ������� (UDF) ������� ��� ������������ ������, ��������, ��� ���������� 
-- ������� ����� ��� ���������� ������ ��������, ������� ����� ���� ������������ � ��������.

---------------------------------------------------

-- 5. Common Table Expressions (CTE) � �������� �� AdventureWorks2017
-- CTE (Common Table Expressions) ��������� ��������� ��������� �������������� �������.

-- ������: ������� ����������� � ��������� ���� ������� �� ��������

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

-- CTE ��������� ������� ������������� ��������� (��������, ������� �������� �� ���� �����������) 
-- � ������������ ��� � �������� �������, ������� ���������� � ���������.

---------------------------------------------------

-- 6. ��������� User Defined Functions (Table-Valued Functions) � �������� �� AdventureWorks2017
-- ��������� ������� (TVF) ���������� ������� ��� ���������, ������� ����� ���� ������������ � ��������.


-- ��������� UDF ��������� ��������� �������, ������� ���������� ������� � ����� ���� ������������ 
-- � ����� �����, ��� ������ ������������ ������� � ������� (��������, � JOIN, WHERE � �.�.).

---------------------------------------------------

-- 7. Stored Procedures � �������� �� AdventureWorks2017
-- �������� ��������� ��������� ��������� � ��������� ����� SQL ����������, ������� ����� ���� ��������� � ���� ������.

-- ������ �������� �������� ��������� ��� ��������� ������� ���������� �� ID

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

-- ����� �������� ��������� ��� ��������� ���������� � ���������� � EmployeeID = 1
EXEC dbo.GetEmployeeDetails @EmployeeID = 1;

-- �������� ��������� ��������� ��������������� ������� ������, ��������� ������������� �������� � 
-- �������������� ������ ��� ���������� ��������.

