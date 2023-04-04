SELECT TOP (1000)*
  FROM [ERPDB].[Erp].[JobMtl]
  WHERE JobNum like '2170022%'
  and Company = 'RBMI'
  Order by ReqDate