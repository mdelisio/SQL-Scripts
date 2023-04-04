SELECT TOP (1000) *
  FROM [ERPDB].[Erp].[OrderRel]
  WHERE OrderNum = 2170022
  AND Company = 'RBMI'
  ORDER BY ReqDate DESC  