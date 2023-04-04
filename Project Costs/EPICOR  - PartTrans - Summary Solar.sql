SELECT TOP (1000) 
    Company,
    JobNum,
    SUM(ExtCost) as MaterialCost
  FROM [ERPDB].[Erp].[PartTran]
  WHERE Company = 'Solar'
  AND JobNum like '2170022%'
  GROUP BY Company, JobNum
  ORDER BY Company DESC, Jobnum ASC
