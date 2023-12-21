/*SELECT 
      [CustomerAltKey]
      ,[OrgProductLineAltKey]
      ,[TransactionDate]
      ,[TransactionExtendedCost]
      ,TranType
      ,TranClass
      ,ptf.[OrderNum]
      ,[OrderLine]
      ,[OrderRelNum]
      ,ptf.[DivisionID]
      ,[OrderCompany]
      ,ohud.ProjectID_c
  FROM [dw].[vw_PartTransactionFact] ptf
  LEFT JOIN ODS_ERPDB.ERP_OrderHed oh
    ON ptf.OrderCompany = oh.company 
      AND ptf.OrderNum = oh.OrderNum 
  LEFT JOIN ODS_ERPDB.Erp_OrderHed_UD ohud
    on oh.SysRowID = ohud.ForeignSysRowID
  WHERE 1=1
  AND ptf.OrderCompany = 'Solar'
  AND DivisionID IN (2,3,4,7,8)
  and TranType <> 'MFG-VAR'
  and TransactionExtendedCost <> 0
  Order by TransactionDate Desc
  */

  Select 
  --TOP (10) 
  --pt.*
  pt.Company,
  pt.PartNum,
  pt.PartDescription,
  pt.TranDate,
  pt.ExtCost,
  pt.Jobnum,
  pt.TranType,
  jp.OrderNum,
  ohud.Division_c,
  ohud.ProjectID_c
  FROM ODS_ERPDB.ERP_PartTran pt
  LEFT JOIN ODS_ERPDB.Erp_JobProd jp
    ON jp.Company = pt.Company
    AND jp.Jobnum = pt.JobNum
  LEFT JOIN ODS_ERPDB.ERP_OrderHed oh
    ON jp.Company = oh.company 
      AND jp.OrderNum = oh.OrderNum 
  LEFT JOIN ODS_ERPDB.Erp_OrderHed_UD ohud
    ON oh.SysRowID = ohud.ForeignSysRowID
  WHERE 1 = 1
  AND oh.Company = 'Solar'
  AND ohud.Division_c IN (2,3,4,7,8)
  --and TranType <> 'MFG-VAR'
  and Extcost <> 0
  Order By TranDate DESC


  Select top (1) *
  From ODS_ERPDB.Erp_JobProd jp

    Select top (1) pt.*
  FROM ODS_ERPDB.ERP_PartTran pt