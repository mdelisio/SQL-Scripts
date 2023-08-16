 
with [InvcMiscCharges] as 
(select 
	[InvcMisc].[Company] as [InvcMisc_Company],
	[InvcMisc].[InvoiceNum] as [InvcMisc_InvoiceNum],
	[InvcMisc].[InvoiceLine] as [InvcMisc_InvoiceLine],
	(sum( InvcMisc.MiscAmt )) as [Calculated_TotalMiscCharge],
	(sum( InvcMisc.Rpt1MiscAmt )) as [Calculated_Rpt1TotalMiscCharge],
	(sum( InvcMisc.Rpt2MiscAmt )) as [Calculated_Rpt2TotalMiscCharge],
	(sum( InvcMisc.Rpt3MiscAmt )) as [Calculated_Rpt3TotalMiscCharge]
from Erp.InvcMisc as InvcMisc
inner join Erp.MiscChrg as MiscChrg on 
	InvcMisc.Company = MiscChrg.Company
	and InvcMisc.MiscCode = MiscChrg.MiscCode
	and ( MiscChrg.SalesAnalysis = 1  )

group by [InvcMisc].[Company],
	[InvcMisc].[InvoiceNum],
	[InvcMisc].[InvoiceLine])

select 
	[InvcHead].[Company] as [InvcHead_Company],
	[Customer].[CustID] as [Customer_CustID],
	[Customer].[Name] as [Customer_Name],
	[CustGrup].[GroupCode] as [CustGrup_GroupCode],
	[CustGrup].[GroupDesc] as [CustGrup_GroupDesc],
	[InvcHead].[InvoiceNum] as [InvcHead_InvoiceNum],
	[InvcHead].[LegalNumber] as [InvcHead_LegalNumber],
	[InvcHead].[InvoiceDate] as [InvcHead_InvoiceDate],
	[InvcDtl].[PartNum] as [InvcDtl_PartNum],
	[ProdGrup].[ProdCode] as [ProdGrup_ProdCode],
	[ProdGrup].[Description] as [ProdGrup_Description],
	[ShipDtl].[JobNum] as [ShipDtl_JobNum],
	[InvcDtl].[SellingShipQty] as [InvcDtl_SellingShipQty],
	[InvcDtl].[IUM] as [InvcDtl_IUM],
	[InvcDtl].[UnitPrice] as [InvcDtl_UnitPrice],
	((case when  (InvcMiscCharges.Calculated_TotalMiscCharge) is null 
  then InvcDtl.ExtPrice 
  else (InvcDtl.ExtPrice + InvcMiscCharges.Calculated_TotalMiscCharge) end)) as [Calculated_TotalPrice],
	(( InvcDtl.SellingShipQty * InvcDtl.LbrUnitCost )) as [Calculated_LaborCost],
	(( InvcDtl.SellingShipQty * InvcDtl.BurUnitCost )) as [Calculated_BurdenCost],
	(( InvcDtl.SellingShipQty * InvcDtl.MtlUnitCost )) as [Calculated_MaterialCost],
	(( InvcDtl.SellingShipQty * InvcDtl.SubUnitCost )) as [Calculated_SubcontractCost],
	(( InvcDtl.SellingShipQty * InvcDtl.MtlBurUnitCost )) as [Calculated_MaterialBurdenCost],
	((InvcDtl.SellingShipQty * InvcDtl.LbrUnitCost + 
		InvcDtl.SellingShipQty * InvcDtl.BurUnitCost + 
		InvcDtl.SellingShipQty * InvcDtl.MtlUnitCost +
		InvcDtl.SellingShipQty * InvcDtl.SubUnitCost + 
		InvcDtl.SellingShipQty * InvcDtl.MtlBurUnitCost )) as [Calculated_TotalCost],
	((case when TotalPrice = 0 then 0 
  else (( TotalPrice - TotalCost) / TotalPrice) * 100 end)) as [Calculated_MarginPercent],
	(TotalPrice - TotalCost) as [Calculated_ProfitMarginAmt]
from Erp.InvcHead as InvcHead
inner join Erp.InvcDtl as InvcDtl on 
	InvcHead.Company = InvcDtl.Company
	and InvcHead.InvoiceNum = InvcDtl.InvoiceNum
left outer join Erp.Part as Part on 
	InvcDtl.Company = Part.Company
	and InvcDtl.PartNum = Part.PartNum
left outer join Erp.ProdGrup as ProdGrup on 
	Part.Company = ProdGrup.Company
	and Part.ProdCode = ProdGrup.ProdCode
left outer join Erp.ShipDtl as ShipDtl on 
	ShipDtl.Company = InvcDtl.Company
	and ShipDtl.PackNum = InvcDtl.PackNum
	and ShipDtl.PackLine = InvcDtl.PackLine
left outer join  InvcMiscCharges  as InvcMiscCharges on 
	InvcMiscCharges.InvcMisc_Company = InvcDtl.Company
	and InvcMiscCharges.InvcMisc_InvoiceNum = InvcDtl.InvoiceNum
	and InvcMiscCharges.InvcMisc_InvoiceLine = InvcDtl.InvoiceLine
inner join Erp.Customer as Customer on 
	Customer.Company = InvcHead.Company
	and Customer.CustNum = InvcHead.CustNum
left outer join Erp.CustGrup as CustGrup on 
	Customer.Company = CustGrup.Company
	and Customer.GroupCode = CustGrup.GroupCode
where 1=1
and InvcHead.Company = 'TES'
and InvcHead.OrderNum =  5005399