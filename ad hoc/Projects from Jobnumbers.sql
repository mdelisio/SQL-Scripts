SELECT Distinct pd.ProjectID, pd.ProjectName
  FROM [dw].[vw_JobMaterialFact] jmf
  INNER JOIN EDW.ProjectDim pd
  ON jmf.Projectaltkey = CONCAT(pd.ProjectID, pd.CompanyID)
  Where 1=1
  AND jobnumber in ('4000926-5-1','4000926-5-2','4000926-5-3','4000958-5-1','4000958-5-2','4000958-5-3',
  '4000994-5-1','4000994-5-2','4000994-5-3','4000996-5-1','4000996-5-2','4000996-5-3','4000999-5-1','4000999-5-2','4000999-5-3','4001000-5-1','4001000-5-2','4001000-5-3')



