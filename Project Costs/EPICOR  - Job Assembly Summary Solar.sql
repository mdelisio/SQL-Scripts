SELECT *    
  FROM [ERPDB].[Erp].[JobAsmbl]
  WHERE JobNum like '2170022%'
  and Company = 'Solar'
  Order BY StartDate DESC