SELECT TOP (1000) 
    Company,
    JobNum,
    AssemblySeq,
    OprSeq,
    OpCode,
    ActProdHours,
    EstProdHours,
    ActSetupHours,
    EstSetHours,
    ActLabCost   
  FROM [ERPDB].[Erp].[JobOper]
  WHERE Company = 'Solar'
  AND JobNum like '2170022%'