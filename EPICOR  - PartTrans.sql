SELECT TOP (1000) *
  FROM [ERPDB].[Erp].[PartTran]
  WHERE Company = 'RBMI' --OR Company = 'Solar')
  AND JobNum like '2170022%'
  ORDER BY TranDate DESC