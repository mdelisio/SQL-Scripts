SELECT TOP (1000) [Company]
      ,[PayrollDate]
      ,Sum(LaborHrs*LaborRate) as LaborCost
      ,Sum(BurdenHrs*BurdenRate) as BurdenCost
      ,(Sum(LaborHrs*LaborRate) + Sum(BurdenHrs*BurdenRate)) as DECost
 FROM [ERPDB].[Erp].[LaborDtl]
 WHERE Company = 'Solar' and PayrollDate >= '01/01/2021'
 Group BY Company, PayrollDate
 Order BY PayrollDate DESC