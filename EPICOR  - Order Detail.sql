SELECT TOP (1000) *
  FROM [ERPDB].dbo.[OrderDtl]
  --WHERE OrderNum = 2170022 AND Company = 'SOLAR'
  ORDER BY ChangeDate DESC
