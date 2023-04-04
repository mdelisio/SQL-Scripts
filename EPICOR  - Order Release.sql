SELECT TOP (1000) *
  FROM [ERPDB].[Erp].[OrderRel]
  WHERE OrderNum = 2170022
  AND Company = 'SOLAR'
  ORDER BY ChangeDate DESC  