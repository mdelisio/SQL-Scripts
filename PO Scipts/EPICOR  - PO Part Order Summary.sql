SELECT TOP (1000)
      [PartNum]
      ,[ClassID]
      ,[IUM]
      ,AVG([UnitCost]) as AVG_UnitCost
      ,SUM([OrderQty]) as Total_Qty
      ,SUM([BaseQty]) as Total_BaseQty
      ,SUM([ExtCost]) as Total_ExtCost
  FROM [ERPDB].[Erp].[PODetail]
  WHERE Company = 'RBMI' AND DueDate > '2021-01-01'
  GROUP BY PartNum, IUM, ClassID
  ORDER BY Total_ExtCost DESC
