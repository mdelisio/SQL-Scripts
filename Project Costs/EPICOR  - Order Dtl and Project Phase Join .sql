SELECT TOP (1000) 
od.Company,
od.OrderNum,
od.ProjectID,
od.OrderLine,
od.Partnum,
od.LineDesc,
od.UnitPrice,
od.DocUnitPrice,
od.RequestDate,
od.ChangedBy,
od.ChangeDate,
od.ChangeTime,
Dateadd(second, od.ChangeTime, cast(od.ChangeDate as datetime)) as ChangeDateTime,
od.EstUnitCost_c,
pp.PhaseID,
pp.TotQuotODCCost,
pp.BudTotODCCost,
pp.BudTotMtlBurCost
-- BudTotMtlBurCost is field that holds additional Cost Estimate Adjustment on each phase line item
  FROM [ERPDB].[dbo].[OrderDtl] as od
  LEFT JOIN [ERPDB].[Erp].[ProjPhase] pp
  ON od.OrderNum = pp.OrderNum and od.OrderLine = pp.OrderLine
  Where od.Company = 'Solar'
  ORDER BY ChangeDate DESC
