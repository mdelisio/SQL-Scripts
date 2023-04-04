SELECT TOP (1000) [Company]
      ,[OpenLine]
      ,[VoidLine]
      ,[PONUM]
      ,[POLine]
      ,[LineDesc]
      ,[IUM]
      ,[UnitCost]
      ,[DocUnitCost]
      ,[OrderQty]
      ,[XOrderQty]
      ,[Taxable]
      ,[PUM]
      ,[CostPerCode]
      ,[PartNum]
      ,[VenPartNum]
      ,[CommentText]
      ,[ClassID]
      ,[RevisionNum]
      ,[RcvInspectionReq]
      ,[VendorNum]
      ,[AdvancePayBal]
      ,[DocAdvancePayBal]
      ,[Confirmed]
      ,[DateChgReq]
      ,[QtyChgReq]
      ,[PartNumChgReq]
      ,[RevisionNumChgReq]
      ,[ConfirmDate]
      ,[ConfirmVia]
      ,[PrcChgReq]
      ,[PurchCode]
      ,[OrderNum]
      ,[OrderLine]
      ,[Linked]
      ,[ExtCompany]
      ,[GlbCompany]
      ,[ContractActive]
      ,[ContractQty]
      ,[ContractUnitCost]
      ,[ContractDocUnitCost]
      ,[Rpt1AdvancePayBal]
      ,[Rpt2AdvancePayBal]
      ,[Rpt3AdvancePayBal]
      ,[Rpt1UnitCost]
      ,[Rpt2UnitCost]
      ,[Rpt3UnitCost]
      ,[ContractQtyUOM]
      ,[Rpt1ContractUnitCost]
      ,[Rpt2ContractUnitCost]
      ,[Rpt3ContractUnitCost]
      ,[BaseQty]
      ,[BaseUOM]
      ,[BTOOrderNum]
      ,[BTOOrderLine]
      ,[VendorPartOpts]
      ,[MfgPartOpts]
      ,[SubPartOpts]
      ,[MfgNum]
      ,[MfgPartNum]
      ,[SubPartNum]
      ,[SubPartType]
      ,[ConfigUnitCost]
      ,[ConfigBaseUnitCost]
      ,[ConvOverRide]
      ,[BasePartNum]
      ,[BaseRevisionNum]
      ,[Direction]
      ,[Per]
      ,[MaintainPricingUnits]
      ,[OverrideConversion]
      ,[RowsManualFactor]
      ,[KeepRowsManualFactorTmp]
      ,[ShipToSupplierDate]
      ,[Factor]
      ,[PricingQty]
      ,[PricingUnitPrice]
      ,[UOM]
      ,[SysRevID]
      ,[SysRowID]
      ,[GroupSeq]
      ,[DocPricingUnitPrice]
      ,[OverridePriceList]
      ,[QtyOption]
      ,[OrigComment]
      ,[SmartString]
      ,[SmartStringProcessed]
      ,[DueDate]
      ,[ContractID]
      ,[LinkToContract]
      ,[SelCurrPricingUnitPrice]
      ,[ChangedBy]
      ,[ChangeDate]
      ,[PCLinkRemoved]
      ,[TaxCatID]
      ,[NoTaxRecalc]
      ,[InUnitCost]
      ,[DocInUnitCost]
      ,[Rpt1InUnitCost]
      ,[Rpt2InUnitCost]
      ,[Rpt3InUnitCost]
      ,[InAdvancePayBal]
      ,[DocInAdvancePayBal]
      ,[Rpt1InAdvancePayBal]
      ,[Rpt2InAdvancePayBal]
      ,[Rpt3InAdvancePayBal]
      ,[InContractUnitCost]
      ,[DocInContractUnitCost]
      ,[Rpt1InContractUnitCost]
      ,[Rpt2InContractUnitCost]
      ,[Rpt3InContractUnitCost]
      ,[DocExtCost]
      ,[ExtCost]
      ,[Rpt1ExtCost]
      ,[Rpt2ExtCost]
      ,[Rpt3ExtCost]
      ,[DocMiscCost]
      ,[MiscCost]
      ,[Rpt1MiscCost]
      ,[Rpt2MiscCost]
      ,[Rpt3MiscCost]
      ,[TotalTax]
      ,[DocTotalTax]
      ,[Rpt1TotalTax]
      ,[Rpt2TotalTax]
      ,[Rpt3TotalTax]
      ,[TotalSATax]
      ,[DocTotalSATax]
      ,[Rpt1TotalSATax]
      ,[Rpt2TotalSATax]
      ,[Rpt3TotalSATax]
      ,[TotalDedTax]
      ,[DocTotalDedTax]
      ,[Rpt1TotalDedTax]
      ,[Rpt2TotalDedTax]
      ,[Rpt3TotalDedTax]
      ,[CommodityCode]
  FROM [ERPDB].[Erp].[PODetail]
  Where Company = 'RBMI'
  Order By ChangeDate DESC