SELECT TOP (1000) [Company]
      ,[PartNum]
      ,[SearchWord]
      ,[PartDescription]
      ,[ClassID]
      ,[IUM]
      ,[PUM]
      ,[TypeCode]
      ,[NonStock]
      ,[PurchasingFactor]
      ,[CostMethod]
      ,[NetWeight]
      ,[UOMClassID]
      ,[CreatedBy]
      ,[CreatedOn]
      ,[ChangedOn]
  FROM [ERPDB].[Erp].[Part]
  WHere PartNum LIKE '6c%'


 -- test this for updates to the 
