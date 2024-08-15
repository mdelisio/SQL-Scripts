  With SolarPartTransactions as (
  SELECT
  Company,
  PartNum,
  PartDescription,
  TranDate,
  ExtCost,
  Jobnum,
  TranType
  FROM ODS_ERPDB.ERP_PartTran 
  Where Company = 'Solar'
  )
  
  Select
  pt.Company,
  pt.PartNum,
  pt.PartDescription,
  pt.TranDate,
  pt.ExtCost,
  pt.Jobnum,
  pt.TranType,
  jp.OrderNum,
  jp.orderline,
  ohud.Division_c,
  CASE WHEN ohud.Division_c = 2 THEN 'Agile'
  WHEN ohud.Division_c = 3 THEN 'Wave'
  WHEN ohud.Division_c = 4 THEN 'Trak'
  WHEN ohud.Division_c = 8 THEN 'Trak'
  WHEN ohud.Division_c = 7 THEN 'Canopy'
  ELSE Null
  END AS ProductLine,
  ohud.ProjectID_c,
  FPPLI.ProjectID
  FROM SolarPartTransactions pt
  LEFT JOIN ODS_ERPDB.Erp_JobProd jp
    ON jp.Company = pt.Company
    AND jp.Jobnum = pt.JobNum
  LEFT JOIN ODS_ERPDB.Erp_OrderRel orl
    ON jp.Company = orl.company
    AND jp.Ordernum = orl.OrderNum
    AND jp.OrderLine = orl.OrderLine
    and jp.OrderRelNum = orl.OrderRelNum
  LEFT JOIN ODS_ERPDB.Erp_OrderDtl od 
    ON orl.company = od.Company
    and orl.Ordernum = od.Ordernum
    and orl.Orderline = od.Orderline
  LEFT JOIN ODS_ERPDB.ERP_OrderHed oh
    ON jp.Company = oh.company 
      AND jp.OrderNum = oh.OrderNum 
  LEFT JOIN ODS_ERPDB.Erp_OrderHed_UD ohud
    ON oh.SysRowID = ohud.ForeignSysRowID
  LEFT JOIN EDWETL.vw_FetchProjectPhaseLevelInfo FPPLI
    ON FPPLI.CompanyID = od.Company
    and FPPLI.OrderNumber = od.OrderNum
    and FPPLI.OrderLine = od.Orderline
  WHERE 1 = 1
  AND oh.Company = 'Solar'
  AND ohud.Division_c IN (2,3,4,7,8)
  and TranType <> 'MFG-VAR'
  and Extcost <> 0
  Order By TranDate DESC





-- Use this to Join the Order to the Phase and Project
  	Select top (10) 
    CompanyID,
    Ordernumber,
    Orderline,
    ProjectID,
    ProjectPhaseID
		FROM EDWETL.vw_FetchProjectPhaseLevelInfo
        Where CompanyID = 'solar'
        and ProjectID is not null
        and ProjectID = '23825764'
    Order by Ordernumber desc

  
  -- Use this to join the Job to the OrderLine
  Select Top (10) 
  CompanyID,
  JobNumber,
  OrderNumber,
  OrderlIne,
  OrderLineRelease
    FROM [EDWReport].[JobProductionFact]

Select Top (100)
JPF.JobNumber,
JPF.OrderNumber,
JPF.OrderLineRelease,
FPPLI.CompanyID,
FPPLI.Ordernumber,
FPPLI.Orderline,
FPPLI.ProjectID,
FPPLI.ProjectPHaseID
FROM EDWReport.JobProductionFact as JPF
LEFT JOIN EDWETL.vw_FetchProjectPhaseLevelInfo AS FPPLI
  ON FPPLI.OrderNumber = JPF.OrderNumber
  AND FPPLI.OrderLine = JPF.OrderLine
Where FPPLI.CompanyID = 'solar'
AND FPPLI.ProjectID = '23825764'

  	Select top (10) * FROM
		EDWETL.vw_FetchProjectPhaseLevelInfo
        Where CompanyID = 'solar'
        and ProjectID is not null
        and ProjectID = '23825764'
    Order by Ordernumber desc


Select Top (100)
JPF.JobNumber,
JPF.OrderNumber,
JPF.OrderLineRelease,
FPPLI.CompanyID,
FPPLI.Ordernumber,
FPPLI.Orderline,
FPPLI.ProjectID,
FPPLI.ProjectPHaseID
FROM EDWReport.JobProductionFact as JPF
LEFT JOIN EDWETL.vw_FetchProjectPhaseLevelInfo AS FPPLI
  ON FPPLI.OrderNumber = JPF.OrderNumber
  AND FPPLI.OrderLine = JPF.OrderLine
Where JPF.Ordernumber = 4002626

Select Top(100) *
FROM ODS_ERPDB.Erp_JobProd
Where Company = 'solar'
and Ordernum = 4002626

Select Top (100) *
FROM EDW.JobProductionFact
Where CompanyID = 'solar'
and Ordernumber = 4002626

Select Top (100) 
Jobnumber,
OrderNumber,
OrderLine,
OrderLineRelease
FROM EDW.JobMaterialProductionReleaseFact
Where CompanyID = 'solar'
and Ordernumber = 4002626



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


/* Select 
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
  jp.orderline,
  ohud.Division_c,
  ohud.ProjectID_c,
  FPPLI.ProjectID
  FROM ODS_ERPDB.ERP_PartTran pt
  LEFT JOIN ODS_ERPDB.Erp_JobProd jp
    ON jp.Company = pt.Company
    AND jp.Jobnum = pt.JobNum
  LEFT JOIN ODS_ERPDB.Erp_OrderRel orl
    ON jp.Company = orl.company
    AND jp.Ordernum = orl.OrderNum
    AND jp.OrderLine = orl.OrderLine
    and jp.OrderRelNum = orl.OrderRelNum
  LEFT JOIN ODS_ERPDB.Erp_OrderDtl od 
    ON orl.company = od.Company
    and orl.Ordernum = od.Company
    and orl.Orderline = od.Orderline
  LEFT JOIN ODS_ERPDB.ERP_OrderHed oh
    ON jp.Company = oh.company 
      AND jp.OrderNum = oh.OrderNum 
  LEFT JOIN ODS_ERPDB.Erp_OrderHed_UD ohud
    ON oh.SysRowID = ohud.ForeignSysRowID
  LEFT JOIN EDWETL.vw_FetchProjectPhaseLevelInfo FPPLI
    ON FPPLI.CompanyID = od.Company
    and FPPLI.OrderNumber = od.OrderNum
    and FPPLI.OrderLine = od.Orderline
  WHERE 1 = 1
  AND oh.Company = 'Solar'
  AND ohud.Division_c IN (2,3,4,7,8)
  --and TranType <> 'MFG-VAR'
  and Extcost <> 0
  Order By TranDate DESC
  */