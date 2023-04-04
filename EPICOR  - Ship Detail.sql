SELECT TOP (1000) *     
  FROM [ERPDB].[Erp].[ShipDtl]
  WHERE Company = 'Solar'
  ORDER BY ChangeDate DESC