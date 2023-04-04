SELECT TOP (1000) [Company]
      ,PayrollDate
      --,[JobNum]
      ,Sum(LaborHrs*LaborRate) as LaborCost
      ,Sum(BurdenHrs*BurdenRate) as BurdenCost
      ,(Sum(LaborHrs*LaborRate) + Sum(BurdenHrs*BurdenRate)) as DECost
 FROM [ERPDB].[Erp].[LaborDtl]
 WHERE Company = 'Solar' and JobNum Like '4%'
 Group BY Company, PayrollDate--, Jobnum
 Order BY PayrollDate DESC