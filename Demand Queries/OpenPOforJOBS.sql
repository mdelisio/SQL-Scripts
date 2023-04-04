select top (1000)
	[PORel].[OpenRelease] as [PORel_OpenRelease],
	[Vendor].[VendorID] as [Vendor_VendorID],
	[POHeader].[PONum] as [POHeader_PONum],
	[PODetail].[POLine] as [PODetail_POLine],
	[PORel].[PORelNum] as [PORel_PORelNum],
	[PODetail].[PartNum] as [PODetail_PartNum],
	[PODetail].[RevisionNum] as [PODetail_RevisionNum],
	[PODetail].[LineDesc] as [PODetail_LineDesc],
	[PODetail].[VenPartNum] as [PODetail_VenPartNum],
	[PODetail].[XOrderQty] as [PODetail_XOrderQty],
	[PODetail].[PUM] as [PODetail_PUM],
	[PODetail].[DocUnitCost] as [PODetail_DocUnitCost],
	[PODetail].[CostPerCode] as [PODetail_CostPerCode],
	[PODetail].[ExtCost] as [PODetail_ExtCost],
	[PORel].[JobNum] as [PORel_JobNum],
	[PORel].[JobSeqType] as [PORel_JobSeqType],
	[POHeader].[OrderDate] as [POHeader_OrderDate],
	[PORel].[DueDate] as [PORel_DueDate],
	[PORel].[PromiseDt] as [PORel_PromiseDt],
	[PODetail].[ClassID] as [PODetail_ClassID],
	[POHeader].[EntryPerson] as [POHeader_EntryPerson],
	[POHeader].[BuyerID] as [POHeader_BuyerID],
	[Vendor].[Name] as [Vendor_Name],
	[POHeader].[ApprovalStatus] as [POHeader_ApprovalStatus],
	[POHeader].[ShipState] as [POHeader_ShipState],
	[PORel].[AssemblySeq] as [PORel_AssemblySeq],
	[PORel].[JobSeq] as [PORel_JobSeq],
	[PORel].[WarehouseCode] as [PORel_WarehouseCode],
	[PORel].[ReceivedQty] as [PORel_ReceivedQty],
	[PORel].[Plant] as [PORel_Plant],
	[PORel].[ProjectID] as [PORel_ProjectID],
	[PORel].[ReqChgDate] as [PORel_ReqChgDate],
	[PORel].[ReqChgQty] as [PORel_ReqChgQty],
	[PORel].[BaseQty] as [PORel_BaseQty],
	[PORel].[BaseUOM] as [PORel_BaseUOM],
	[PORel].[Status] as [PORel_Status],
	[PORel].[ArrivedQty] as [PORel_ArrivedQty],
	[PORel].[InvoicedQty] as [PORel_InvoicedQty],
	(PORel.RelQty- PORel.ReceivedQty) as [Calculated_OpenQty],
	((PORel.RelQty - PORel.ReceivedQty) * PODetail.UnitCost) as [Calculated_OpenAmt],
	[JobMtl].[QtyPer] as [JobMtl_QtyPer],
	[JobMtl].[EstUnitCost] as [JobMtl_EstUnitCost],
	(JobMtl.QtyPer * JobMtl.EstUnitCost) as [Calculated_JobCost]
from Erp.POHeader as POHeader
inner join Erp.PODetail as PODetail on 
	POHeader.Company = PODetail.Company
	and POHeader.PONum = PODetail.PONUM
inner join Erp.PORel as PORel on 
	PODetail.Company = PORel.Company
	and PODetail.PONUM = PORel.PONum
	and PODetail.POLine = PORel.POLine
	and ( PORel.OpenRelease = 1  )

full outer join Erp.OrderRel as OrderRel on 
	OrderRel.OrderNum = PORel.OrderNum
	and OrderRel.OrderLine = PORel.OrderLine
	and OrderRel.OrderRelNum = PORel.OrderRelNum
left outer join Erp.JobMtl as JobMtl on 
	PORel.Company = JobMtl.Company
	and PORel.JobNum = JobMtl.JobNum
	and PORel.AssemblySeq = JobMtl.AssemblySeq
	and PORel.JobSeq = JobMtl.MtlSeq
inner join Erp.Vendor as Vendor on 
	POHeader.Company = Vendor.Company
	and POHeader.VendorNum = Vendor.VendorNum
inner join Erp.PurAgent as PurAgent on 
	POHeader.Company = PurAgent.Company
	and POHeader.BuyerID = PurAgent.BuyerID
where Poheader.company = 'Solar'
order by POHeader.Company, POHeader.PONum Desc, PODetail.POLine
