SELECT TOP (1000) *
    --     [Company]
    --   ,[BudgetCodeID]
    --   ,[BudgetCodeDesc]
    --   ,[IsDefault]
    --   ,[Inactive]
    --   ,[SysRevID]
    --   ,[SysRowID]
  FROM [ERPDB].[Erp].[BudgetCode]
   Where (Company = 'Solar' or Company = 'TERRA' or Company= 'SOLARBOS' or Company = 'Japan' or Company = 'RSA')
   