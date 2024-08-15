SELECT 
      pgmf.[CompanyID]
      ,pd.ProjectID
      ,pd.ProjectName
      ,pgmf.[DivisionID]
      ,opld.ProductLineName
      ,cst.Name as CustomerName
      ,[ProjectSellPrice]
      ,[ProjectQuotedCost]
      ,[ProjectActualCost]
      ,[ProjectCurrentBudgetAmount]
      ,[ProjectPercentComplete]
      ,[ProjectRevenueEarnedAmount]
      ,[ProjectBacklogAmount]
      ,Cast(pd.CreateUTCDateTime as Date) ProjectDimCreatedDate
      ,pd.CreateUTCDateTime
  FROM [dw].[ProjectGrossMarginFact] pgmf
  INNER JOIN EDW.ProjectDim pd
    ON pgmf.ProjectDimKey = pd.ProjectDimKey
  LEFT JOIN EDWReport.OrgProductLineDim opld
    ON Concat(pgmf.CompanyId,pgmf.DivisionID) = opld.OrgProductLineEpicorAltKey
  LEFT JOIN ODS_ERPDB.Erp_Customer cst 
    ON SurrogateCustomerDimKey = Concat(cst.Company,cst.custnum)
  Where 1=1
  AND pd.CompanyID = 'solar'
  AND pd.SourceSystemRecordState = 'active'
  AND opld.IsCurrent = 'YES'
  AND opld.ProductLineName <> 'Sunflower'
  AND pgmf.ProjectPercentComplete > .9
  and pgmf.ProjectRevenueEarnedAmount >= 100000
  --and pd.CreateUTCDateTime > '2023-04-26 17:32:17.930'
  Order by pd.CreateUTCDateTime DESC


/*
  Select Top (4) * From 
  EDW.ProjectDim
 Select Top (20) * From 
  EDWReport.OrgProductLineDim
  Where IsCurrent = 'YES'
 Select Top (4) * From 
  ODS_ERPDB.Erp_Customer
*/