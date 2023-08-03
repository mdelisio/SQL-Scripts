SELECT TOP (1000)
      [SysRowID]
      ,[VoidLine]
      ,[OpenLine]
      ,[ProjectID]
      ,[Date]
      ,[ChangeDateTime]
      ,[OrderNum]
      ,[OrderNumLine]
      ,[BaseEstimate]
      ,[SellPrice]
      ,[PartNum]
      ,[OrderLine]
      ,[ProdCode]
      ,[OrderQty]
      ,[IsCurrent]
      ,[EffectiveStartDateRow]
      ,[EffectiveEndDateRow]
      ,[CreatedDateRow]
      ,[LastUpdateDateRow]
  FROM [dw].[FactOrderDetails]
    Where ProjectID in ('2230115', '2130240')
   and Company = 'Solar'
   and orderline in (7,8,10,13,14)


SELECT *
  FROM [stg].[FactOrderDetails]
      Where ProjectID = '2230115'
         and Company = 'Solar'
         and Unitprice > 0

      Select * 
    FROM [dw].[FactOrderDetails]
    Where Ordernum = '2130240'
       and Company = 'Solar'
          order by IsCurrent 

         
   Select Count(*) 
    FROM [dw].[FactOrderDetails]
  