SELECT Distinct 
     gla.Company,
    --   ,gla.GLAccount
    --   ,gla.AccountDesc
      gla.SegValue1 as AccountNbr
      ,coa.SegmentName as AccountName
      ,gla.SegValue2 as DeptNbr
      ,coa2.SegmentName as DepartmentName
     -- ,gla.SegValue3 as DivisionNbr
      ,CONCAT(gla.SegValue2,'-',gla.SegValue1) as DeptAcct     
 FROM [ERPDB].[Erp].[GLAccount] gla
 Left Join Erp.COASegValues as coa
    on gla.SegValue1 = coa.SegmentCode and gla.company = coa.company
    Left Join Erp.COASegValues as coa2
    on gla.SegValue2 = coa2.SegmentCode and gla.company = coa2.company
    Where gla.Company = 'RBMI'
    and coa2.SegmentNbr <> 3
    and gla.Segvalue2 IN (23,11)
   -- And (gla.Segvalue1 >= 4000 and gla.Segvalue1 <= 9999)
    --Order by AcctDept

