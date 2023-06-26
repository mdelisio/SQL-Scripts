/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [ProjectGrossMarginFactKey]
	  ,pd.ProjectID
	  ,pd.ProjectDescription
	  ,opld.ProductLineName
	  ,opld.ReportingGroupName
	  ,dc.CustomerName
      ,pd.ProjectManagerName
      
      ,[ProjectSellPrice]
      ,[ProjectQuotedCost]
      ,[ProjectEstimatedCost]
      ,[ProjectActualCost]
      ,[ProjectOpenDemandAmount]
      ,[ProjectActualCostPlusOpenDemandAmount]
      ,[ProjectMaxCost]
      ,[ProjectCurrentBudgetAmount]
      ,[ProjectBudgetCostVsMaxCost]
      ,[ProjectPercentComplete]
      ,[ProjectRevenueEarnedAmount]
      ,[ProjectBacklogAmount]
      ,[ProjectGrossMarginPercent]
      ,[ProjectBillingAmount]
      ,[ProjectInvoiceBalance]
      ,[ProjectCustomerPaid]
      ,[ProjectPullForwardPullBackAmount]
  FROM [dw].[ProjectGrossMarginFact] AS pgmf
  inner join edw.ProjectDim pd
  on pgmf.ProjectDimKey = pd.ProjectDimKey
  inner join edw.OrgProductLineDim opld
  on pgmf.OrgProductLineDimKey = opld.OrgProductLineDimKey
  inner join dw.DimCustomer dc
  on pgmf.SurrogateCustomerDimKey = dc.SurrogateCustomerDimKey 

  Where 1=1
  And opld.ReportingGroupName = 'terrasmart'
  and pd.IsProjectActive = 1
