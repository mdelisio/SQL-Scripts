SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER VIEW [etl].[vwLaborDtl] AS

SELECT [Company]
      ,[EmployeeNum]
      ,[LaborHedSeq]
      ,[LaborDtlSeq]
      ,[LaborType]
      ,[LaborTypePseudo]
      ,[ReWork]
      ,[ReworkReasonCode]
      ,[JobNum]
      ,REVERSE(PARSENAME(REPLACE(REVERSE([JobNum]), '-', '.'), 1)) as OrderNum
      ,REVERSE(PARSENAME(REPLACE(REVERSE([JobNum]), '-', '.'), 2)) as OrderLine
      ,(Case
        When
            REVERSE(PARSENAME(REPLACE(REVERSE([JobNum]), '-', '.'), 2)) is Null
        Then
            REVERSE(PARSENAME(REPLACE(REVERSE([JobNum]), '-', '.'), 1))
        Else
            CONCAT(REVERSE(PARSENAME(REPLACE(REVERSE([JobNum]), '-', '.'), 1))
            ,'-'
            ,REVERSE(PARSENAME(REPLACE(REVERSE([JobNum]), '-', '.'), 2))
        )
        end) as OrderNumLine
      ,[AssemblySeq]
      ,[OprSeq]
      ,[JCDept]
      ,[ResourceGrpID]
      ,[OpCode]
      ,[LaborHrs]
      ,[BurdenHrs]
      ,[LaborQty]
      ,[ScrapQty]
      ,[ScrapReasonCode]
      ,[SetupPctComplete]
      ,[Complete]
      ,[IndirectCode]
      ,[LaborNote]
      ,[ExpenseCode]
      ,[LaborCollection]
      ,[AppliedToSchedule]
      ,[ClockInMInute]
      ,[ClockOutMinute]
      ,[ClockInDate]
      ,[ClockinTime]
      ,[ClockOutTime]
      ,[ActiveTrans]
      ,[OverRidePayRate]
      ,[LaborRate]
      ,[BurdenRate]
      ,[DspClockInTime]
      ,[DspClockOutTime]
      ,[ResourceID]
      ,[OpComplete]
      ,[EarnedHrs]
      ,[AddedOper]
      ,[PayrollDate]
      ,[PostedToGL]
      ,[FiscalYear]
      ,[FiscalPeriod]
      ,[JournalNum]
      ,[GLTrans]
      ,[JournalCode]
      ,[InspectionPending]
      ,[CallNum]
      ,[CallLine]
      ,[ServNum]
      ,[ServCode]
      ,[ResReasonCode]
      ,[WipPosted]
      ,[DiscrepQty]
      ,[DiscrpRsnCode]
      ,[ParentLaborDtlSeq]
      ,[LaborEntryMethod]
      ,[FiscalYearSuffix]
      ,[FiscalCalendarID]
      ,[BFLaborReq]
      ,[ABTUID]
      ,[ProjectID]
      ,[PhaseID]
      ,[RoleCd]
      ,[TimeTypCd]
      ,[PBInvNum]
      ,[PMUID]
      ,[TaskSetID]
      ,[ApprovedDate]
      ,[ClaimRef]
      ,[QuickEntryCode]
      ,[TimeStatus]
      ,[CreatedBy]
      ,[CreateDate]
      ,[CreateTime]
      ,Dateadd(second, CreateTime, cast(CreateDate as Datetime)) as CreateDateTime
      ,[ChangedBy]
      ,[ChangeDate]
      ,[ChangeTime]
      ,Dateadd(second, ChangeTime, cast(ChangeDate as Datetime)) as ChangeDateTime
      ,[ActiveTaskID]
      ,[LastTaskID]
      ,[CreatedViaTEWeekView]
      ,[CurrentWFStageID]
      ,[WFGroupID]
      ,[WFComplete]
      ,[ApprovalRequired]
      ,[SubmittedBy]
      ,[PBRateFrom]
      ,[PBCurrencyCode]
      ,[PBHours]
      ,[PBChargeRate]
      ,[PBChargeAmt]
      ,[DocPBChargeRate]
      ,[Rpt1PBChargeRate]
      ,[Rpt2PBChargeRate]
      ,[Rpt3PBChargeRate]
      ,[DocPBChargeAmt]
      ,[Rpt1PBChargeAmt]
      ,[Rpt2PBChargeAmt]
      ,[Rpt3PBChargeAmt]
      ,[Shift]
      ,[ActID]
      ,[DtailID]
      ,[ProjProcessed]
      ,[AsOfDate]
      ,[AsOfSeq]
      ,[JDFInputFiles]
      ,[JDFNumberOfPages]
      ,[BatchWasSaved]
      ,[AssignToBatch]
      ,[BatchComplete]
      ,[BatchRequestMove]
      ,[BatchPrint]
      ,[BatchLaborHrs]
      ,[BatchPctOfTotHrs]
      ,[BatchQty]
      ,[BatchTotalExpectedHrs]
      ,[JDFOpCompleted]
      ,[SysRevID]
      ,[SysRowID]
      ,[Downtime]
      ,[RefJobNum]
      ,[RefAssemblySeq]
      ,[RefOprSeq]
      ,[Imported]
      ,[ImportDate]
      ,[TimeAutoSubmit]
      ,[BatchMode]
      ,[BillServiceRate]
      ,[HCMPayHours]
      ,[EpicorFSA]
      ,[DiscrepAttributeSetID]
      ,[LaborAttributeSetID]
      ,[ScrapAttributeSetID]
  FROM [ERPDB].[Erp].[LaborDtl]
GO
