  Select Distinct
        Company,
        BookID,
        BalanceAcct,
        BalanceType,
        FiscalYear,
        FiscalCalendarID,
        BudgetCodeID
  FROM [ERPDB].[Erp].[GLBudgetDtl]
 Where (Company = 'Solar' or Company = 'TERRA' or Company= 'SOLARBOS' or Company = 'Japan' or Company = 'RSA')
 and FiscalYear >= 2022
 Order BY FiscalYear DESC
