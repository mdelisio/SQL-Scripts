SELECT 
    Company,
   -- JobNum,
    --AssemblySeq,
    --OprSeq,
    --OpCode,
    Sum(ActProdHours) AS ActProdHours,
    Sum(EstProdHours) AS EstProdHours,
    Sum(ActSetupHours) AS ActSetupHours,
    Sum(EstSetHours) AS EstSetHours,
    Sum(ActLabCost) AS ActLabCost,
    Sum(ActBurCost) AS ActBurCost   
  FROM [ERPDB].[Erp].[JobOper]
  WHERE Company = 'RBMI'
  AND JobNum like '2170022%'
  GROUP BY Company
  --, Jobnum
  --, OpCode