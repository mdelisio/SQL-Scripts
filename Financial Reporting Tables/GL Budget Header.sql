SELECT TOP (1000) [Company]
      ,[BookID]
      ,[BalanceAcct]
      ,[BalanceType]
      ,[FiscalYear]
      ,[BudgetCodeID]
      ,[SegValue1]
      ,[SegValue2]
      ,[SegValue3]
      ,[TotalBudgetAmt]
      ,[BudgetPerCode]
   FROM [ERPDB].[Erp].[GLBudgetHd]
      Where (Company = 'Solar' or Company = 'TERRA' or Company= 'SOLARBOS' or Company = 'Japan' or Company = 'RSA')
      and FiscalYear >= 2022