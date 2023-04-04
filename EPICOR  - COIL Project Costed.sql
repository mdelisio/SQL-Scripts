SELECT 
  Company,
  SysDate,
  Partnum,
  PartDescription
  BinNum,
  TranType,
  Trandate,
  TranQty,
  UM,
  MtlUnitCost,
  ExtCost,
  Jobnum,
  JobSeq,
  ordernum,
  OrderNumLine,
  ProjectID
  FROM [ERPDB].[etl].[vwPartTran]
  WHERE Company = 'RBMI' --OR Company = 'Solar')
  AND PartNum like '6c%'
  and Projectid IS NOT NULL 
  and Projectid <> ' '
  and Trandate > '2018-01-01'
  ORDER BY TranDate DESC

