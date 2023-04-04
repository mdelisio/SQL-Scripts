SELECT TOP (1000) [Company]
      ,[JEDate]
      ,[FiscalYear]
      ,[FiscalPeriod]
      ,[COACoad]
      ,[GLAccount]
      ,[AcctDept]
      ,[AccountNbr]
      ,[DepartmentNbr]
      ,[DivisionNbr]
      ,[DebitAmount]
      ,[CreditAmount]
      ,[BalanceAmount]
      ,[Scenario]
  FROM [ERPDB].[etl].[vwSolarBudgetFcst]
  Where FiscalYear = 2023
  and AccountNbr = 5240
  and Company = 'Solar'
  and DivisionNbr = 08
  and DepartmentNbr = 40