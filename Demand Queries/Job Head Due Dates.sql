SELECT TOP (1000) [Company]
      ,[JobClosed]
      ,[JobReleased]
      ,[JobHeld]
      ,[SchedStatus]
      ,[JobNum]
      ,[PartNum]
      ,[PartDescription]
      ,[ProdQty]
      ,[StartDate]
      ,[DueDate]
      ,[ReqDueDate]
      ,[ProdCode]
      ,[ProjectID]
      ,[JobFirm]
      ,[QtyCompleted]
      ,[Plant]
      ,[JobType]
      ,[PhaseID]
      ,[CreatedBy]
      ,[CreateDate]
      ,[LastChangedBy]
      ,[LastChangedOn]


  FROM [ERPDB].[Erp].[JobHead]
  where jobnum like '2170100%'
  and (company = 'rbmi' or company = 'solar')