SELECT TOP (1000) [Company]
      ,[OpenLine]
      ,[PONUM]
      ,[POLine]
      ,[LineDesc]
      ,[IUM]
      ,[UnitCost]
      ,[OrderQty]
      ,[PartNum]
      ,[ClassID]
      ,[BaseQty]
      ,[BaseUOM]
      ,[DueDate]
      ,[ChangeDate]
      ,[ExtCost]
  FROM [ERPDB].[Erp].[PODetail]
  Where Company = 'RBMI' AND PartNum like '6C%'
  Order By DueDate DESC


    -- Partnum =  '6C13165G501790'