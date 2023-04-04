SELECT TOP (1000) 
    Company,
    JobNum,
    --ResourceGrpID,
    Sum(ProdBurRate) As Production_Cost

  FROM [ERPDB].[Erp].[JobOpDtl]
  WHERE Company = 'RBMI'
  AND JobNum Like '2170022%'
  Group BY Company, JobNum
  Order BY Jobnum Asc   