SELECT TOP (1000) 
    od.[VoidLine]
    ,od.[OpenLine]
    ,od.[Company]
    ,od.[OrderNum]
      ,od.[OrderLine]
      ,od.[LineType]
      ,od.[PartNum]
      ,od.[LineDesc]
      ,od.[Reference]
      ,od.[IUM]
      ,od.[RevisionNum]
      ,od.[POLine]
      ,od.[Commissionable]
      ,od.[DiscountPercent]
      ,od.[UnitPrice]
      ,od.[DocUnitPrice]
      ,od.[OrderQty]
      ,od.[Discount]
      ,od.[DocDiscount]
      ,od.[RequestDate]
      ,od.[ProdCode]
      ,od.[XPartNum]
      ,od.[XRevisionNum]
      ,od.[PricePerCode]
      ,od.[OrderComment]
      ,od.[ShipComment]
      ,od.[InvoiceComment]
      ,od.[PickListComment]
      ,od.[TaxCatID]
      ,od.[AdvanceBillBal]
      ,od.[DocAdvanceBillBal]
      ,od.[QuoteNum]
      ,od.[QuoteLine]
      ,od.[TMBilling]
      ,od.[OrigWhyNoTax]
      ,od.[NeedByDate]
      ,od.[CustNum]
      ,od.[Rework]
      ,od.[RMANum]
      ,od.[RMALine]
      ,od.[ProjectID]
      ,od.[ContractNum]
      ,od.[ContractCode]
      ,od.[BasePartNum]
      ,od.[Warranty]
      ,od.[WarrantyCode]
      ,od.[MaterialDuration]
      ,od.[LaborDuration]
      ,od.[MiscDuration]
      ,od.[MaterialMod]
      ,od.[LaborMod]
      ,od.[WarrantyComment]
      ,od.[Onsite]
      ,od.[MatCovered]
      ,od.[LabCovered]
      ,od.[MiscCovered]
      ,od.[SalesUM]
      ,od.[SellingFactor]
      ,od.[SellingQuantity]
      ,od.[SalesCatID]
      ,od.[ShipLineComplete]
      ,od.[CumeQty]
      ,od.[CumeDate]
      ,od.[MktgCampaignID]
      ,od.[MktgEvntSeq]
      ,od.[LockQty]
      ,od.[Linked]
      ,od.[ICPONum]
      ,od.[ICPOLine]
      ,od.[ExtCompany]
      ,od.[LastConfigDate]
      ,od.[LastConfigTime]
      ,od.[LastConfigUserID]
      ,od.[ConfigUnitPrice]
      ,od.[ConfigBaseUnitPrice]
      ,od.[PriceListCode]
      ,od.[BreakListCode]
      ,od.[PricingQty]
      ,od.[LockPrice]
      ,od.[ListPrice]
      ,od.[DocListPrice]
      ,od.[OrdBasedPrice]
      ,od.[DocOrdBasedPrice]
      ,od.[PriceGroupCode]
      ,od.[OverridePriceList]
      ,od.[BaseRevisionNum]
      ,od.[PricingValue]
      ,od.[DisplaySeq]
      ,od.[KitParentLine]
      ,od.[KitAllowUpdate]
      ,od.[KitShipComplete]
      ,od.[KitBackFlush]
      ,od.[KitPrintCompsPS]
      ,od.[KitPrintCompsInv]
      ,od.[KitPricing]
      ,od.[KitQtyPer]
      ,od.[SellingFactorDirection]
      ,od.[RepRate1]
      ,od.[RepRate2]
      ,od.[RepRate3]
      ,od.[RepRate4]
      ,od.[RepRate5]
      ,od.[RepSplit1]
      ,od.[RepSplit2]
      ,od.[RepSplit3]
      ,od.[RepSplit4]
      ,od.[RepSplit5]
      ,od.[DemandContractLine]
      ,od.[CreateNewJob]
      ,od.[DoNotShipBeforeDate]
      ,od.[GetDtls]
      ,od.[DoNotShipAfterDate]
      ,od.[SchedJob]
      ,od.[RelJob]
      ,od.[EnableCreateNewJob]
      ,od.[EnableGetDtls]
      ,od.[EnableSchedJob]
      ,od.[EnableRelJob]
      ,od.[CounterSaleWarehouse]
      ,od.[CounterSaleBinNum]
      ,od.[CounterSaleLotNum]
      ,od.[CounterSaleDimCode]
      ,od.[DemandDtlRejected]
      ,od.[KitFlag]
      ,od.[KitsLoaded]
      ,od.[DemandContractNum]
      ,od.[DemandHeadSeq]
      ,od.[DemandDtlSeq]
      ,od.[ChangedBy]
      ,od.[ChangeDate]
      ,od.[ChangeTime]
      ,Dateadd(second, od.ChangeTime, cast(od.ChangeDate as Datetime)) as ChangeDateTime
      ,od.[ReverseCharge]
      ,od.[TotalReleases]
      ,od.[Rpt1UnitPrice]
      ,od.[Rpt2UnitPrice]
      ,od.[Rpt3UnitPrice]
      ,od.[Rpt1Discount]
      ,od.[Rpt2Discount]
      ,od.[Rpt3Discount]
      ,od.[Rpt1AdvanceBillBal]
      ,od.[Rpt2AdvanceBillBal]
      ,od.[Rpt3AdvanceBillBal]
      ,od.[Rpt1ListPrice]
      ,od.[Rpt2ListPrice]
      ,od.[Rpt3ListPrice]
      ,od.[Rpt1OrdBasedPrice]
      ,od.[Rpt2OrdBasedPrice]
      ,od.[Rpt3OrdBasedPrice]
      ,od.[ExtPriceDtl]
      ,od.[DocExtPriceDtl]
      ,od.[Rpt1ExtPriceDtl]
      ,od.[Rpt2ExtPriceDtl]
      ,od.[Rpt3ExtPriceDtl]
      ,od.[LineStatus]
      ,od.[InUnitPrice]
      ,od.[DocInUnitPrice]
      ,od.[InDiscount]
      ,od.[DocInDiscount]
      ,od.[InListPrice]
      ,od.[DocInListPrice]
      ,od.[InOrdBasedPrice]
      ,od.[DocInOrdBasedPrice]
      ,od.[Rpt1InUnitPrice]
      ,od.[Rpt2InUnitPrice]
      ,od.[Rpt3InUnitPrice]
      ,od.[Rpt1InDiscount]
      ,od.[Rpt2InDiscount]
      ,od.[Rpt3InDiscount]
      ,od.[Rpt1InListPrice]
      ,od.[Rpt2InListPrice]
      ,od.[Rpt3InListPrice]
      ,od.[Rpt1InOrdBasedPrice]
      ,od.[Rpt2InOrdBasedPrice]
      ,od.[Rpt3InOrdBasedPrice]
      ,od.[InExtPriceDtl]
      ,od.[DocInExtPriceDtl]
      ,od.[Rpt1InExtPriceDtl]
      ,od.[Rpt2InExtPriceDtl]
      ,od.[Rpt3InExtPriceDtl]
      ,od.[OldOurOpenQty]
      ,od.[OldSellingOpenQty]
      ,od.[OldOpenValue]
      ,od.[OldProdCode]
      ,od.[PrevSellQty]
      ,od.[PrevPartNum]
      ,od.[PrevXPartNum]
      ,od.[KitCompOrigSeq]
      ,od.[KitCompOrigPart]
      ,od.[SmartStringProcessed]
      ,od.[SmartString]
      ,od.[RenewalNbr]
      ,od.[DiscBreakListCode]
      ,od.[DiscListPrice]
      ,od.[LockDisc]
      ,od.[OverrideDiscPriceList]
      ,od.[GroupSeq]
      ,od.[ECCOrderNum]
      ,od.[ECCOrderLine]
      ,od.[DupOnJobCrt]
      ,od.[UndersPct]
      ,od.[Overs]
      ,od.[Unders]
      ,od.[OversUnitPrice]
      ,od.[PlanUserID]
      ,od.[PlanGUID]
      ,od.[MOMsourceType]
      ,od.[MOMsourceEst]
      ,od.[DefaultOversPricing]
      ,od.[ECCPlant]
      ,od.[ECCQuoteNum]
      ,od.[ECCQuoteLine]
      ,od.[SysRevID]
      ,od.[SysRowID]
      ,od.[MfgJobType]
      ,od.[ProFormaInvComment]
      ,od.[CreateJob]
      ,od.[ContractID]
      ,od.[LinkToContract]
      ,od.[DocInAdvanceBillBal]
      ,od.[InAdvanceBillBal]
      ,od.[Rpt1InAdvanceBillBal]
      ,od.[Rpt2InAdvanceBillBal]
      ,od.[Rpt3InAdvanceBillBal]
      ,od.[PCLinkRemoved]
      ,od.[CommodityCode]
      ,od.[MSRP]
      ,od.[DocMSRP]
      ,od.[Rpt1MSRP]
      ,od.[Rpt2MSRP]
      ,od.[Rpt3MSRP]
      ,od.[EndCustomerPrice]
      ,od.[DocEndCustomerPrice]
      ,od.[Rpt1EndCustomerPrice]
      ,od.[Rpt2EndCustomerPrice]
      ,od.[Rpt3EndCustomerPrice]
      ,od.[PromotionalPrice]
      ,od.[DocPromotionalPrice]
      ,od.[Rpt1PromotionalPrice]
      ,od.[Rpt2PromotionalPrice]
      ,od.[Rpt3PromotionalPrice]
      ,od.[OrderLineStatusCode]
      ,od.[AttributeSetID]
      ,od.[ForeignSysRowID]
      ,od.[UD_SysRevID]
      ,od.[DoNotBook_c]
      ,od.[EstUnitCost_c]
      ,od.[OriginalEstimate_c],

pp.PhaseID,
pp.TotQuotODCCost,
pp.BudTotODCCost,
pp.BudTotMtlBurCost
-- BudTotMtlBurCost is field that holds additional Cost Estimate Adjustment on each phase line item
  FROM [ERPDB].[dbo].[OrderDtl] as od
  LEFT JOIN [ERPDB].[Erp].[ProjPhase] pp
  ON od.OrderNum = pp.OrderNum and od.OrderLine = pp.OrderLine
  Where od.Company = 'Solar'
  ORDER BY ChangeDate DESC
