SELECT TOP (1000) [Company]
      ,[JobClosed]
      ,[ClosedDate]
      ,[JobComplete]
      ,[JobCompletionDate]
      ,[JobEngineered]
      ,[CheckOff1]
      ,[CheckOff2]
      ,[CheckOff3]
      ,[CheckOff4]
      ,[CheckOff5]
      ,[JobReleased]
      ,[JobHeld]
      ,[SchedStatus]
      ,[JobNum]
      ,[PartNum]
      ,[RevisionNum]
      ,[DrawNum]
      ,[PartDescription]
      ,[ProdQty]
      ,[IUM]
      ,[StartDate]
      ,[StartHour]
      ,[DueDate]
      ,[DueHour]
      ,[ReqDueDate]
      ,[JobCode]
      ,[QuoteNum]
      ,[QuoteLine]
      ,[ProdCode]
      ,[UserChar1]
      ,[UserChar2]
      ,[UserChar3]
      ,[UserChar4]
      ,[UserDate1]
      ,[UserDate2]
      ,[UserDate3]
      ,[UserDate4]
      ,[UserDecimal1]
      ,[UserDecimal2]
      ,[UserInteger1]
      ,[UserInteger2]
      ,[CommentText]
      ,[ExpenseCode]
      ,[InCopyList]
      ,[WIName]
      ,[WIStartDate]
      ,[WIStartHour]
      ,[WIDueDate]
      ,[WIDueHour]
      ,[Candidate]
      ,[SchedCode]
      ,[SchedLocked]
      ,[ProjectID]
      ,[WIPCleared]
      ,[JobFirm]
      ,[PersonList]
      ,[PersonID]
      ,[ProdTeamID]
      ,[QtyCompleted]
      ,[Plant]
      ,[DatePurged]
      ,[TravelerReadyToPrint]
      ,[TravelerLastPrinted]
      ,[StatusReadyToPrint]
      ,[StatusLastPrinted]
      ,[CallNum]
      ,[CallLine]
      ,[JobType]
      ,[RestoreFlag]
      ,[PhaseID]
      ,[AnalysisCode]
      ,[LockQty]
      ,[HDCaseNum]
      ,[ProcessMode]
      ,[PlannedActionDate]
      ,[PlannedKitDate]
      ,[MSPTaskID]
      ,[MSPPredecessor]
      ,[UserMapData]
      ,[ProductionYield]
      ,[OrigProdQty]
      ,[PreserveOrigQtys]
      ,[NoAutoCompletion]
      ,[NoAutoClosing]
      ,[CreatedBy]
      ,[CreateDate]
      ,[WhseAllocFlag]
      ,[OwnershipStatus]
      ,[PDMObjID]
      ,[ExportRequested]
      ,[SplitMfgCostElements]
      ,[XRefPartNum]
      ,[XRefPartType]
      ,[XRefCustNum]
      ,[BasePartNum]
      ,[BaseRevisionNum]
      ,[RoughCutScheduled]
      ,[EquipID]
      ,[PlanNum]
      ,[MaintPriority]
      ,[SplitJob]
      ,[NumberSource]
      ,[CloseMeterReading]
      ,[IssueTopicID1]
      ,[IssueTopicID2]
      ,[IssueTopicID3]
      ,[IssueTopicID4]
      ,[IssueTopicID5]
      ,[IssueTopicID6]
      ,[IssueTopicID7]
      ,[IssueTopicID8]
      ,[IssueTopicID9]
      ,[IssueTopicID10]
      ,[IssueTopics]
      ,[ResTopicID1]
      ,[ResTopicID2]
      ,[ResTopicID3]
      ,[ResTopicID4]
      ,[ResTopicID5]
      ,[ResTopicID6]
      ,[ResTopicID7]
      ,[ResTopicID8]
      ,[ResTopicID9]
      ,[ResTopicID10]
      ,[ResTopics]
      ,[Forward]
      ,[SchedSeq]
      ,[PAAExists]
      ,[DtlsWithinLeadTime]
      ,[GroupSeq]
      ,[RoughCut]
      ,[PlanGUID]
      ,[PlanUserID]
      ,[LastChangedBy]
      ,[LastChangedOn]
      ,[EPMExportLevel]
      ,[JobWorkflowState]
      ,[JobCSR]
      ,[ExternalMES]
      ,[SysRevID]
      ,[SysRowID]
      ,[LastExternalMESDate]
      ,[LastScheduleDate]
      ,[LastScheduleProc]
      ,[SchedPriority]
      ,[DaysLate]
      ,[ContractID]
      ,[ProjProcessed]
      ,[SyncReqBy]
      ,[CustName]
      ,[CustID]
      ,[IsCSRSet]
      ,[UnReadyCostProcess]
      ,[ProcSuspendedUpdates]
      ,[ProjProcessedDate]
      ,[PCLinkRemoved]
      ,[ExternalMESSyncRequired]
      ,[ExternalMESLastSync]
      ,[EpicorFSA]
  FROM [ERPDB].[Erp].[JobHead]
  WHERE ProjectID = 2170022
  AND Company = 'SOLAR'
   ORDER BY DueDate