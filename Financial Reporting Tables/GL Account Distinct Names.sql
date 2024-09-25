/*
SELECT TOP (1000) [AccountNbr]
      ,[AccountName]
      ,[DeptNbr]
      ,[DepartmentName]
      ,[AcctDept]
  FROM [ERPDB].[etl].[vwSolarAcctDept]
  */

------------------------------------------------

With DistinctAccountNameCompany AS
(SELECT 
Coa.Company,
CASE WHEN coa.Company = 'SOLAR' THEN 'aSOLAR'
ELSE coa.Company END as OrderedCompany,
Coa.SegmentCode as COAAccountNbr
,coa.SegmentName as COAAccountName
,ROW_NUMBER() OVER (Partition BY SegmentCode Order by Coa.Company) as Rank
FROM Erp.COASegValues as coa
WHERE SegmentNbr = 1
AND Company IN ('Solar','TERRA','Solarbos','japan','RSA')
),

RankedAccountName AS(
SELECT
Company,
COAAccountNbr,
COAAccountName,
ROW_NUMBER() OVER (Partition BY COAAccountNbr Order by OrderedCompany) as Rank
From DistinctAccountNameCompany
),

DistinctAccounts AS 
(Select * From RankedAccountName
WHERE RANK = 1),


DistinctDepartmentNameCompany AS
(SELECT 
Coa.Company,
CASE WHEN coa.Company = 'SOLAR' THEN 'aSOLAR'
ELSE coa.Company END as OrderedCompany,
Coa.SegmentCode as COADepartmentNbr
,coa.SegmentName as COADepartmentName
,coa.SegmentDesc as COADepartmentDescription
,ROW_NUMBER() OVER (Partition BY SegmentCode Order by Coa.Company) as Rank
FROM Erp.COASegValues as coa
WHERE SegmentNbr = 2
AND Company IN ('Solar','TERRA','Solarbos','japan','RSA')
),

RankedDepartmentName AS(
SELECT
Company,
COADepartmentNbr,
COADepartmentName,
COADepartmentDescription,
ROW_NUMBER() OVER (Partition BY COADepartmentNbr Order by OrderedCompany) as Rank
From DistinctDepartmentNameCompany
),

DistinctDepartments AS 
(Select * From RankedDepartmentName
WHERE RANK = 1)

---------------------------------------------------



SELECT Distinct 
      gla.SegValue1 as AccountNbr
      ,da.COAAccountName as AccountName
      ,gla.SegValue2 as DeptNbr
      ,dd.COADepartmentName as DepartmentName
      ,CONCAT(gla.SegValue1,gla.SegValue2) as AcctDept     
 FROM [ERPDB].[Erp].[GLAccount] gla
 Left Join DistinctAccounts as da
    on gla.SegValue1 = da.COAAccountNbr 
    Left Join DistinctDepartments dd
    on gla.SegValue2 = dd.COADepartmentNbr
    Where (gla.Company = 'Solar' or gla.Company = 'TERRA' or gla.Company = 'Solarbos' or gla.company = 'japan' or gla.company = 'RSA')
    AND gla.Segvalue2 <> 99


--Select Top (2) * FROM Erp.COASegValues

/*
SELECT *
  FROM [ERPDB].[etl].[vwSolarAcctDept]
  */