
SELECT 
  [Company]
      ,[COACode]
      ,[GLAccount]
      ,[AccountDesc]
      ,[SegValue1]
      ,[SegValue2]
      ,[SegValue3]
      ,[Active]
      ,[EffFrom]
      ,[EffTo]
      ,[MultiCompany]
      ,[ParentGLAccount]
      ,ROW_NUMBER() OVER (Partition BY Company, COACode, SegValue1 Order by SegValue2) as Rank
  FROM [ERPDB].[Erp].[GLAccount]
  Where Company = 'Solar'
  AND Active = 1

