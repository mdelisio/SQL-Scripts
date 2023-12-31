SELECT TOP (1000) [Company]
      ,[Type]
      ,[PartNum]
      ,[DueDate]
      ,[RequirementFlag]
      ,[Quantity]
      ,[JobNum]
      ,[AssemblySeq]
      ,[JobSeq]
      ,[OrderNum]
      ,[OrderLine]
      ,[OrderRelNum]
      ,[PONum]
      ,[POLine]
      ,[PORelNum]
      ,[PartDescription]
      ,[IUM]
      ,[SourceFile]
      ,[CustNum]
      ,[StockTrans]
      ,[FirmRelease]
      ,[RevisionNum]
      ,[TargetOrderNum]
      ,[TargetOrderLine]
      ,[TargetOrderRelNum]
      ,[TargetWarehouseCode]
      ,[TargetJobNum]
      ,[TargetAssemblySeq]
      ,[TargetMtlSeq]
      ,[Plant]
      ,[InvLinkNum]
      ,[PlantTranNum]
      ,[TFOrdLine]
      ,[TFOrdNum]
      ,[TFLineNum]
      ,[SourceDBRecid]
      ,[NonPart]
      ,[BOMChanged]
      ,[BaseQty]
      ,[BaseQtyUOM]
      ,[InvtyQty]
      ,[InvtyQtyUOM]
      ,[JobFirm]
      ,[PartDtlSeq]
      ,[SysRevID]
      ,[SysRowID]
      ,[ContractID]
      ,[EpicorFSA]
      ,[AttributeSetID]
      ,[AttributeSetDescription]
      ,[AttributeSetShortDescription]
      ,[NumberOfPieces]
      ,[PlanningNumberOfPieces]
      ,[PlanningAttributeSetSeq]
      ,[PlanningAttributeSetHash]
      ,[IsContiguous]
      ,[InventoryNumberOfPieces]
      ,[OriginalAttributeSetID]
  FROM [ERPDB].[Erp].[PartDtl]
  Where Company = 'Solar'
  AND JobNum like '2170022%'