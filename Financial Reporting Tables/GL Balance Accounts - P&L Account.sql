  Create View [etl].[vwSolarPandLBalance] as 
  
  SELECT 
       glb.Company
      ,glb.BookID
      ,glb.BalanceAcct
      ,glb.BalanceType
      ,glb.FiscalYear
      ,glb.FiscalPeriod
      ,glb.BalanceAmt
      ,glb.DebitAmt
      ,glb.CreditAmt
      ,CONCAT(glb.SegValue1,glb.SegValue2) as DeptAcct
      ,glb.SegValue1 as Account
      ,coa.SegmentName as AccountName
      ,glb.SegValue2 as Department
      ,coa2.SegmentName as DepartmentName
      ,glb.SegValue3 as Division
      FROM [ERPDB].[Erp].[GLPeriodBal] As glb
    Left Join Erp.COASegValues as coa
    on glb.SegValue1 = coa.SegmentCode and glb.company = coa.company
    Left Join Erp.COASegValues as coa2
    on glb.SegValue2 = coa2.SegmentCode and glb.company = coa2.company
   --Where glb.Company = 'Solar'
    Where (glb.Company = 'Solar' or glb.Company = 'TERRA' or glb.Company= 'SOLARBOS' or glb.Company = 'Japan')
    and coa2.SegmentNbr <> 3
    And (glb.Segvalue1 >= 4000 and glb.Segvalue1 <= 9999)
 


   
