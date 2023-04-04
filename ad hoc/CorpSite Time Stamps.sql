SELECT Distinct
      [company],
      [insertTimeStamp]
  
  FROM [RBI].[dbo].[JobCost]
  Where Company = 'tes'

  Order by insertTimeStamp ASC