CREATE VIEW [etl].[vwOrderDetail] AS

SELECT[VoidLine]
      ,[OpenLine]
      ,[Company]
      ,[OrderNum]
      ,[OrderLine]
      ,[LineType]
      ,[PartNum]
      ,[LineDesc]
      ,[Reference]
      ,[IUM]
      ,[RevisionNum]
      ,[POLine]
      ,[Commissionable]
      ,[DiscountPercent]
      ,[UnitPrice]
      ,[DocUnitPrice]
      ,[OrderQty]
      ,[Discount]
      ,[DocDiscount]
      ,[RequestDate]
      ,[ProdCode]
      ,[XPartNum]
      ,[XRevisionNum]
      ,[PricePerCode]
      ,[OrderComment]
      ,[ShipComment]
      ,[InvoiceComment]
      ,[PickListComment]
      ,[TaxCatID]
      ,[AdvanceBillBal]
      ,[DocAdvanceBillBal]
      ,[QuoteNum]
      ,[QuoteLine]
      ,[TMBilling]
      ,[OrigWhyNoTax]
      ,[NeedByDate]
      ,[CustNum]
      ,[Rework]
      ,[RMANum]
      ,[RMALine]
      ,[ProjectID]
      ,[ContractNum]
      ,[ContractCode]
      ,[BasePartNum]
      ,[Warranty]
      ,[WarrantyCode]
      ,[MaterialDuration]
      ,[LaborDuration]
      ,[MiscDuration]
      ,[MaterialMod]
      ,[LaborMod]
      ,[WarrantyComment]
      ,[Onsite]
      ,[MatCovered]
      ,[LabCovered]
      ,[MiscCovered]
      ,[SalesUM]
      ,[SellingFactor]
      ,[SellingQuantity]
      ,[SalesCatID]
      ,[ShipLineComplete]
      ,[CumeQty]
      ,[CumeDate]
      ,[MktgCampaignID]
      ,[MktgEvntSeq]
      ,[LockQty]
      ,[Linked]
      ,[ICPONum]
      ,[ICPOLine]
      ,[ExtCompany]
      ,[LastConfigDate]
      ,[LastConfigTime]
      ,[LastConfigUserID]
      ,[ConfigUnitPrice]
      ,[ConfigBaseUnitPrice]
      ,[PriceListCode]
      ,[BreakListCode]
      ,[PricingQty]
      ,[LockPrice]
      ,[ListPrice]
      ,[DocListPrice]
      ,[OrdBasedPrice]
      ,[DocOrdBasedPrice]
      ,[PriceGroupCode]
      ,[OverridePriceList]
      ,[BaseRevisionNum]
      ,[PricingValue]
      ,[DisplaySeq]
      ,[KitParentLine]
      ,[KitAllowUpdate]
      ,[KitShipComplete]
      ,[KitBackFlush]
      ,[KitPrintCompsPS]
      ,[KitPrintCompsInv]
      ,[KitPricing]
      ,[KitQtyPer]
      ,[SellingFactorDirection]
      ,[RepRate1]
      ,[RepRate2]
      ,[RepRate3]
      ,[RepRate4]
      ,[RepRate5]
      ,[RepSplit1]
      ,[RepSplit2]
      ,[RepSplit3]
      ,[RepSplit4]
      ,[RepSplit5]
      ,[DemandContractLine]
      ,[CreateNewJob]
      ,[DoNotShipBeforeDate]
      ,[GetDtls]
      ,[DoNotShipAfterDate]
      ,[SchedJob]
      ,[RelJob]
      ,[EnableCreateNewJob]
      ,[EnableGetDtls]
      ,[EnableSchedJob]
      ,[EnableRelJob]
      ,[CounterSaleWarehouse]
      ,[CounterSaleBinNum]
      ,[CounterSaleLotNum]
      ,[CounterSaleDimCode]
      ,[DemandDtlRejected]
      ,[KitFlag]
      ,[KitsLoaded]
      ,[DemandContractNum]
      ,[DemandHeadSeq]
      ,[DemandDtlSeq]
      ,[ChangedBy]
      ,[ChangeDate]
      ,[ChangeTime]
      ,Dateadd(second, ChangeTime, cast(ChangeDate as Datetime)) as ChangeDateTime
      ,[ReverseCharge]
      ,[TotalReleases]
      ,[Rpt1UnitPrice]
      ,[Rpt2UnitPrice]
      ,[Rpt3UnitPrice]
      ,[Rpt1Discount]
      ,[Rpt2Discount]
      ,[Rpt3Discount]
      ,[Rpt1AdvanceBillBal]
      ,[Rpt2AdvanceBillBal]
      ,[Rpt3AdvanceBillBal]
      ,[Rpt1ListPrice]
      ,[Rpt2ListPrice]
      ,[Rpt3ListPrice]
      ,[Rpt1OrdBasedPrice]
      ,[Rpt2OrdBasedPrice]
      ,[Rpt3OrdBasedPrice]
      ,[ExtPriceDtl]
      ,[DocExtPriceDtl]
      ,[Rpt1ExtPriceDtl]
      ,[Rpt2ExtPriceDtl]
      ,[Rpt3ExtPriceDtl]
      ,[LineStatus]
      ,[InUnitPrice]
      ,[DocInUnitPrice]
      ,[InDiscount]
      ,[DocInDiscount]
      ,[InListPrice]
      ,[DocInListPrice]
      ,[InOrdBasedPrice]
      ,[DocInOrdBasedPrice]
      ,[Rpt1InUnitPrice]
      ,[Rpt2InUnitPrice]
      ,[Rpt3InUnitPrice]
      ,[Rpt1InDiscount]
      ,[Rpt2InDiscount]
      ,[Rpt3InDiscount]
      ,[Rpt1InListPrice]
      ,[Rpt2InListPrice]
      ,[Rpt3InListPrice]
      ,[Rpt1InOrdBasedPrice]
      ,[Rpt2InOrdBasedPrice]
      ,[Rpt3InOrdBasedPrice]
      ,[InExtPriceDtl]
      ,[DocInExtPriceDtl]
      ,[Rpt1InExtPriceDtl]
      ,[Rpt2InExtPriceDtl]
      ,[Rpt3InExtPriceDtl]
      ,[OldOurOpenQty]
      ,[OldSellingOpenQty]
      ,[OldOpenValue]
      ,[OldProdCode]
      ,[PrevSellQty]
      ,[PrevPartNum]
      ,[PrevXPartNum]
      ,[KitCompOrigSeq]
      ,[KitCompOrigPart]
      ,[SmartStringProcessed]
      ,[SmartString]
      ,[RenewalNbr]
      ,[DiscBreakListCode]
      ,[DiscListPrice]
      ,[LockDisc]
      ,[OverrideDiscPriceList]
      ,[GroupSeq]
      ,[ECCOrderNum]
      ,[ECCOrderLine]
      ,[DupOnJobCrt]
      ,[UndersPct]
      ,[Overs]
      ,[Unders]
      ,[OversUnitPrice]
      ,[PlanUserID]
      ,[PlanGUID]
      ,[MOMsourceType]
      ,[MOMsourceEst]
      ,[DefaultOversPricing]
      ,[ECCPlant]
      ,[ECCQuoteNum]
      ,[ECCQuoteLine]
      ,[SysRevID]
      ,[SysRowID]
      ,[MfgJobType]
      ,[ProFormaInvComment]
      ,[CreateJob]
      ,[ContractID]
      ,[LinkToContract]
      ,[DocInAdvanceBillBal]
      ,[InAdvanceBillBal]
      ,[Rpt1InAdvanceBillBal]
      ,[Rpt2InAdvanceBillBal]
      ,[Rpt3InAdvanceBillBal]
      ,[PCLinkRemoved]
      ,[CommodityCode]
      ,[MSRP]
      ,[DocMSRP]
      ,[Rpt1MSRP]
      ,[Rpt2MSRP]
      ,[Rpt3MSRP]
      ,[EndCustomerPrice]
      ,[DocEndCustomerPrice]
      ,[Rpt1EndCustomerPrice]
      ,[Rpt2EndCustomerPrice]
      ,[Rpt3EndCustomerPrice]
      ,[PromotionalPrice]
      ,[DocPromotionalPrice]
      ,[Rpt1PromotionalPrice]
      ,[Rpt2PromotionalPrice]
      ,[Rpt3PromotionalPrice]
      ,[OrderLineStatusCode]
      ,[AttributeSetID]
      ,[ForeignSysRowID]
      ,[UD_SysRevID]
      ,[DoNotBook_c]
      ,[EstUnitCost_c]
      ,[OriginalEstimate_c]
  FROM [ERPDB].[dbo].[OrderDtl]