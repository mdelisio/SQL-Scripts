SELECT TOP (1000) [Company]
      --,[JobNum]
      ,Sum(LaborHrs*LaborRate) as LaborCost
      ,Sum(BurdenHrs*BurdenRate) as BurdenCost
 FROM [ERPDB].[Erp].[LaborDtl]
 WHERE Company = 'RBMI' and JobNum Like '2170022%'
 Group BY Company--, Jobnum