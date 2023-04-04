SELECT TOP (1000)
od.Company,
od.OrderNum,
od.ProjectID,
od.OrderLine,
od.ChangeDate,
pp.PhaseID,
pp.TotQuotODCCost,
pp.BudTotODCCost,
pp.BudTotMtlBurCost
-- BudTotMtlBurCost is field that holds additional Cost Estimate Adjustment on each phase line item
-- ProjPhase.DocGTBudgetCost is file
  FROM [ERPDB].[dbo].[OrderDtl] AS od
  LEFT JOIN [ERPDB].[Erp].[ProjPhase] AS pp
  ON od.OrderNum=pp.OrderNum and od.OrderLine=pp.OrderLine
  Where od.Company = 'Solar' --and od.ProjectID = '20-6711'
  Order BY ChangeDate DESC
