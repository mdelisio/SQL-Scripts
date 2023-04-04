SELECT TOP (1000) 
  Company,
  OrderNum,
  OrderLine,
  Partnum,
  LineDesc,
  UnitPrice,
  DocUnitPrice,
  RequestDate,
  ChangedBy,
  ChangeDate,
  ChangeTime,
  Dateadd(second, ChangeTime, cast(ChangeDate as datetime)) as ChangeDateTime,
  EstUnitCost_c
  --using the dbo Orderdtl instead of erp
  FROM [ERPDB].dbo.[OrderDtl]
  WHERE OrderNum = 2170022 AND Company = 'SOLAR' and VoidLine = 0
  ORDER BY ChangeDateTime DESC  
