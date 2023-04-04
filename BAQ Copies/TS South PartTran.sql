SELECT TOP (2000) 
    Company,
    projectID,
    TranDate,
    SUM(ExtCost) as MaterialCost
  FROM [ERPDB].[etl].[vwPartTran]
  WHERE Company = 'Solar'
  AND JobNum like '4%'
  GROUP BY Company, TranDate, ProjectID
  ORDER BY Company DESC, TranDate DESC