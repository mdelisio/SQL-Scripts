--Create View as etl.PartPuchaseHist
 
select 
	[PartTran].[Company] as [PartTran_Company],
	[PartTran].[SysDate] as [PartTran_SysDate],
	[PartTran].[TranDate] as [PartTran_TranDate],
	[PartTran].[PartNum] as [PartTran_PartNum],
	[PartTran].[PartDescription] as [PartTran_PartDescription],
	[Part].[ClassID] as [Part_ClassID],
	[PartTran].[InventoryTrans] as [PartTran_InventoryTrans],
	[PartTran].[EntryPerson] as [PartTran_EntryPerson],
	[PartTran].[BinNum] as [PartTran_BinNum],
	[PartTran].[TranType] as [PartTran_TranType],
	[PartTran].[JobNum] as [PartTran_JobNum],
	[PartTran].[TranQty] as [PartTran_TranQty],
	[PartTran].[MtlUnitCost] as [PartTran_MtlUnitCost],
	[PartTran].[LbrUnitCost] as [PartTran_LbrUnitCost],
	[PartTran].[BurUnitCost] as [PartTran_BurUnitCost],
	[PartTran].[SubUnitCost] as [PartTran_SubUnitCost],
	[PartTran].[MtlBurUnitCost] as [PartTran_MtlBurUnitCost],
	[PartTran].[ExtCost] as [PartTran_ExtCost],
	[PartTran].[PONum] as [PartTran_PONum],
	[PartTran].[POLine] as [PartTran_POLine],
	[PartTran].[PORelNum] as [PartTran_PORelNum],
	[PartTran].[PostedToGL] as [PartTran_PostedToGL],
	[PartTran].[Plant] as [PartTran_Plant],
	[Vendor].[VendorID] as [Vendor_VendorID],
	[Vendor].[Name] as [Vendor_Name],
	[POHeader].[EntryPerson] as [POHeader_EntryPerson],
	[POHeader].[BuyerID] as [POHeader_BuyerID]
from Erp.PartTran as PartTran
left outer join Erp.Part as Part on 
	PartTran.Company = Part.Company
	and PartTran.PartNum = Part.PartNum
inner join Erp.POHeader as POHeader on 
	PartTran.Company = POHeader.Company
	and PartTran.PONum = POHeader.PONum
--	and ( POHeader.BuyerID = 'COIL'  or POHeader.BuyerID = 'INVENT'  or POHeader.BuyerID = 'INVENT_2'  or POHeader.BuyerID = 'MFG_I'  or POHeader.BuyerID = 'MFG_II'  or POHeader.BuyerID = 'GRBOX'  or POHeader.BuyerID = 'SOLAR'  or POHeader.BuyerID = 'SOLAR4'  or POHeader.BuyerID = 'SOLAR3'  or POHeader.BuyerID = 'Prod_Mgr'  or POHeader.BuyerID = 'AGILE4'  or POHeader.BuyerID = 'TTRAK4'  or POHeader.BuyerID = 'TINVENT'  )

inner join Erp.Vendor as Vendor on 
	POHeader.Company = Vendor.Company
	and POHeader.VendorNum = Vendor.VendorNum
where (PartTran.SysDate >= '01/01/2023'  and PartTran.SysDate <= '02/21/2023'  and 
(PartTran.TranType = 'PUR-STK'  or PartTran.TranType = 'PUR-MTL'  or PartTran.TranType = 'PUR-INS'  or PartTran.TranType = 'PUR-DRP'  or PartTran.TranType = 'ADJ-PUR' ) and (PartTran.Company = 'RBMI'  or PartTran.Company = 'SOLAR' ))
order by PartTran.PartNum, PartTran.SysDate, PartTran.EntryPerson