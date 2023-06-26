SELECT 
       pp.[Company]
      ,pp.[ProjectID]
      ,[PhaseID]
      ,pp.[Description]
      ,[WBSJobNum]
      ,[ParentPhase]
      ,TotWBSPhaseRev
      ,p.ActiveProject
  FROM [ERPDB].[dbo].[ProjPhase] pp
  Left Join ERPDB.dbo.Project p
  on pp.Company = p.Company 
  And pp.ProjectID = p.ProjectID
  Where pp.Company = 'solar'
  and [Level] = 1
  and pp.[DESCRIPTION] = 'Root Phase'
  and TotWBSPhaseRev <> 0 
  and p.ActiveProject = 1