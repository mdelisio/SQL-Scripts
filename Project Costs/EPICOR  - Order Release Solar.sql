SELECT TOP (1000) *
  FROM [ERPDB].[erp].[OrderRel]
  WHERE OrderNum = 2170022
  AND Company = 'SOLAR'
  ORDER BY ReqDate DESC  