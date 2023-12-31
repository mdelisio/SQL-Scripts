SELECT TOP (1000) [Company]
      ,[JobComplete]
      ,[IssuedComplete]
      ,[JobNum]
      ,[AssemblySeq]
      ,[MtlSeq]
      ,[PartNum]
      ,[Description]
      ,[QtyPer]
      ,[RequiredQty]
      ,[IUM]
      ,[LeadTime]
      ,[RelatedOperation]
      ,[MtlBurRate]
      ,[EstMtlBurUnitCost]
      ,[EstUnitCost]
      ,[IssuedQty]
      ,[TotalCost]
      ,[MtlBurCost]
      ,[ReqDate]
      ,[WarehouseCode]
      ,[SalvagePartNum]
      ,[SalvageDescription]
      ,[SalvageQtyPer]
      ,[SalvageUM]
      ,[SalvageMtlBurRate]
      ,[SalvageUnitCredit]
      ,[SalvageEstMtlBurUnitCredit]
      ,[SalvageQtyToDate]
      ,[SalvageCredit]
      ,[SalvageMtlBurCredit]
      ,[MfgComment]
      ,[VendorNum]
      ,[PurPoint]
      ,[BuyIt]
      ,[Ordered]
      ,[PurComment]
      ,[BackFlush]
      ,[EstScrap]
      ,[EstScrapType]
      ,[FixedQty]
      ,[FindNum]
      ,[RevisionNum]
      ,[SndAlrtCmpl]
      ,[RcvInspectionReq]
      ,[Plant]
      ,[Direct]
      ,[MaterialMtlCost]
      ,[MaterialLabCost]
      ,[MaterialSubCost]
      ,[MaterialBurCost]
      ,[SalvageMtlCredit]
      ,[SalvageLbrCredit]
      ,[SalvageBurCredit]
      ,[SalvageSubCredit]
      ,[APSAddResType]
      ,[CallNum]
      ,[CallLine]
      ,[ProdCode]
      ,[UnitPrice]
      ,[BillableUnitPrice]
      ,[DocBillableUnitPrice]
      ,[ResReasonCode]
      ,[PricePerCode]
      ,[Billable]
      ,[ShippedQty]
      ,[DocUnitPrice]
      ,[QtyStagedToDate]
      ,[AddedMtl]
      ,[MiscCharge]
      ,[MiscCode]
      ,[SCMiscCode]
      ,[RFQNeeded]
      ,[RFQVendQuotes]
      ,[RFQNum]
      ,[RFQLine]
      ,[RFQStat]
      ,[AnalysisCode]
      ,[GlbRFQ]
      ,[WhseAllocFlag]
      ,[WIReqDate]
      ,[Rpt1BillableUnitPrice]
      ,[Rpt2BillableUnitPrice]
      ,[Rpt3BillableUnitPrice]
      ,[Rpt1UnitPrice]
      ,[Rpt2UnitPrice]
      ,[Rpt3UnitPrice]
      ,[BaseRequiredQty]
      ,[BaseUOM]
      ,[Weight]
      ,[WeightUOM]
      ,[ReqRefDes]
      ,[BasePartNum]
      ,[BaseRevisionNum]
      ,[SelectForPicking]
      ,[StagingWarehouseCode]
      ,[StagingBinNum]
      ,[PickError]
      ,[EstMtlUnitCost]
      ,[EstLbrUnitCost]
      ,[EstBurUnitCost]
      ,[EstSubUnitCost]
      ,[SalvageEstMtlUnitCredit]
      ,[SalvageEstLbrUnitCredit]
      ,[SalvageEstBurUnitCredit]
      ,[SalvageEstSubUnitCredit]
      ,[LoanedQty]
      ,[BorrowedQty]
      ,[ReassignSNAsm]
      ,[GeneralPlanInfo]
      ,[EstStdDescription]
      ,[PricingUOM]
      ,[RemovedFromPlan]
      ,[IsPOCostingMaintained]
      ,[EstStdType]
      ,[POCostingFactor]
      ,[PlannedQtyPerUnit]
      ,[POCostingDirection]
      ,[POCostingUnitVal]
      ,[GroupSeq]
      ,[SysRevID]
      ,[SysRowID]
      ,[OrigStructTag]
      ,[OrigGroupSeq]
      ,[ShowStatusIcon]
      ,[ContractID]
      ,[LinkToContract]
      ,[StagingLotNum]
      ,[PCLinkRemoved]
      ,[ExternalMESSyncRequired]
      ,[ExternalMESLastSync]
      ,[LocationView]
      ,[AttributeSetID]
      ,[PlanningNumberOfPieces]
      ,[SalvageAttributeSetID]
      ,[SalvagePlanningNumberOfPieces]
      ,[SalvagePlanningAttributeSetID]
  FROM [ERPDB].[Erp].[JobMtl]
  WHERE JobNum = '2170022-5-1'
  and Company = 'Solar'