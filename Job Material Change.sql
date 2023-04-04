/*
 * Disclaimer!!!
 * This is not a real query being executed, but a simplified version for general vision.
 * Executing it with any other tool may produce a different result.
 */
DECLARE @Today as date
Set @Today = GetDate() 

select Top (1000)
	[SubQuery1].[JobMtl_Company] as [JobMtl_Company],
	[SubQuery1].[JobMtl_JobComplete] as [JobMtl_JobComplete],
	[SubQuery1].[JobMtl_IssuedComplete] as [JobMtl_IssuedComplete],
	[SubQuery1].[JobMtl_JobNum] as [JobMtl_JobNum],
	[SubQuery1].[JobMtl_AssemblySeq] as [JobMtl_AssemblySeq],
	[SubQuery1].[JobMtl_MtlSeq] as [JobMtl_MtlSeq],
	[SubQuery1].[JobMtl_PartNum] as [JobMtl_PartNum],
	[SubQuery1].[JobMtl_Description] as [JobMtl_Description],
	[SubQuery1].[JobMtl_QtyPer] as [JobMtl_QtyPer],
	[SubQuery1].[JobMtl_RequiredQty] as [JobMtl_RequiredQty],
	[SubQuery1].[JobMtl_IUM] as [JobMtl_IUM],
	[SubQuery1].[JobMtl_LeadTime] as [JobMtl_LeadTime],
	[SubQuery1].[JobMtl_RelatedOperation] as [JobMtl_RelatedOperation],
	[SubQuery1].[JobMtl_MtlBurRate] as [JobMtl_MtlBurRate],
	[SubQuery1].[JobMtl_EstMtlBurUnitCost] as [JobMtl_EstMtlBurUnitCost],
	[SubQuery1].[JobMtl_EstUnitCost] as [JobMtl_EstUnitCost],
	[SubQuery1].[JobMtl_IssuedQty] as [JobMtl_IssuedQty],
	[SubQuery1].[JobMtl_TotalCost] as [JobMtl_TotalCost],
	[SubQuery1].[JobMtl_MtlBurCost] as [JobMtl_MtlBurCost],
	[SubQuery1].[JobMtl_ReqDate] as [JobMtl_ReqDate],
	[SubQuery1].[JobMtl_WarehouseCode] as [JobMtl_WarehouseCode],
	[SubQuery1].[JobMtl_MfgComment] as [JobMtl_MfgComment],
	[SubQuery1].[JobMtl_VendorNum] as [JobMtl_VendorNum],
	[SubQuery1].[JobMtl_PurPoint] as [JobMtl_PurPoint],
	[SubQuery1].[JobMtl_PurComment] as [JobMtl_PurComment],
	[SubQuery1].[JobMtl_RevisionNum] as [JobMtl_RevisionNum],
	[SubQuery1].[JobMtl_Plant] as [JobMtl_Plant],
	[SubQuery1].[JobMtl_MaterialMtlCost] as [JobMtl_MaterialMtlCost],
	[SubQuery1].[JobMtl_MaterialLabCost] as [JobMtl_MaterialLabCost],
	[SubQuery1].[JobMtl_MaterialSubCost] as [JobMtl_MaterialSubCost],
	[SubQuery1].[JobMtl_MaterialBurCost] as [JobMtl_MaterialBurCost],
	[SubQuery1].[JobMtl_ProdCode] as [JobMtl_ProdCode],
	[SubQuery1].[JobMtl_UnitPrice] as [JobMtl_UnitPrice],
	[SubQuery1].[JobMtl_PricePerCode] as [JobMtl_PricePerCode],
	[SubQuery1].[JobMtl_ShippedQty] as [JobMtl_ShippedQty],
	[SubQuery1].[JobMtl_DocUnitPrice] as [JobMtl_DocUnitPrice],
	[SubQuery1].[JobMtl_MiscCharge] as [JobMtl_MiscCharge],
	[SubQuery1].[JobMtl_MiscCode] as [JobMtl_MiscCode],
	[SubQuery1].[JobMtl_Weight] as [JobMtl_Weight],
	[SubQuery1].[JobMtl_WeightUOM] as [JobMtl_WeightUOM],
	[SubQuery1].[JobMtl_EstMtlUnitCost] as [JobMtl_EstMtlUnitCost],
	[SubQuery1].[JobMtl_EstLbrUnitCost] as [JobMtl_EstLbrUnitCost],
	[SubQuery1].[JobMtl_EstBurUnitCost] as [JobMtl_EstBurUnitCost],
	[SubQuery1].[JobMtl_EstSubUnitCost] as [JobMtl_EstSubUnitCost],
	[SubQuery1].[JobMtl_BuyIt] as [JobMtl_BuyIt],
	[SubQuery1].[Calculated_ChangeDate] as [Calculated_ChangeDate]
from  (select 
	[JobMtl].[Company] as [JobMtl_Company],
	[JobMtl].[JobComplete] as [JobMtl_JobComplete],
	[JobMtl].[IssuedComplete] as [JobMtl_IssuedComplete],
	[JobMtl].[JobNum] as [JobMtl_JobNum],
	[JobMtl].[AssemblySeq] as [JobMtl_AssemblySeq],
	[JobMtl].[MtlSeq] as [JobMtl_MtlSeq],
	[JobMtl].[PartNum] as [JobMtl_PartNum],
	[JobMtl].[Description] as [JobMtl_Description],
	[JobMtl].[QtyPer] as [JobMtl_QtyPer],
	[JobMtl].[RequiredQty] as [JobMtl_RequiredQty],
	[JobMtl].[IUM] as [JobMtl_IUM],
	[JobMtl].[LeadTime] as [JobMtl_LeadTime],
	[JobMtl].[RelatedOperation] as [JobMtl_RelatedOperation],
	[JobMtl].[MtlBurRate] as [JobMtl_MtlBurRate],
	[JobMtl].[EstMtlBurUnitCost] as [JobMtl_EstMtlBurUnitCost],
	[JobMtl].[EstUnitCost] as [JobMtl_EstUnitCost],
	[JobMtl].[IssuedQty] as [JobMtl_IssuedQty],
	[JobMtl].[TotalCost] as [JobMtl_TotalCost],
	[JobMtl].[MtlBurCost] as [JobMtl_MtlBurCost],
	[JobMtl].[ReqDate] as [JobMtl_ReqDate],
	[JobMtl].[WarehouseCode] as [JobMtl_WarehouseCode],
	[JobMtl].[MfgComment] as [JobMtl_MfgComment],
	[JobMtl].[VendorNum] as [JobMtl_VendorNum],
	[JobMtl].[PurPoint] as [JobMtl_PurPoint],
	[JobMtl].[PurComment] as [JobMtl_PurComment],
	[JobMtl].[RevisionNum] as [JobMtl_RevisionNum],
	[JobMtl].[Plant] as [JobMtl_Plant],
	[JobMtl].[MaterialMtlCost] as [JobMtl_MaterialMtlCost],
	[JobMtl].[MaterialLabCost] as [JobMtl_MaterialLabCost],
	[JobMtl].[MaterialSubCost] as [JobMtl_MaterialSubCost],
	[JobMtl].[MaterialBurCost] as [JobMtl_MaterialBurCost],
	[JobMtl].[ProdCode] as [JobMtl_ProdCode],
	[JobMtl].[UnitPrice] as [JobMtl_UnitPrice],
	[JobMtl].[PricePerCode] as [JobMtl_PricePerCode],
	[JobMtl].[ShippedQty] as [JobMtl_ShippedQty],
	[JobMtl].[DocUnitPrice] as [JobMtl_DocUnitPrice],
	[JobMtl].[MiscCharge] as [JobMtl_MiscCharge],
	[JobMtl].[MiscCode] as [JobMtl_MiscCode],
	[JobMtl].[Weight] as [JobMtl_Weight],
	[JobMtl].[WeightUOM] as [JobMtl_WeightUOM],
	[JobMtl].[EstMtlUnitCost] as [JobMtl_EstMtlUnitCost],
	[JobMtl].[EstLbrUnitCost] as [JobMtl_EstLbrUnitCost],
	[JobMtl].[EstBurUnitCost] as [JobMtl_EstBurUnitCost],
	[JobMtl].[EstSubUnitCost] as [JobMtl_EstSubUnitCost],
	[JobMtl].[BuyIt] as [JobMtl_BuyIt],
	[SubQuery3].[PartTran_TranDate] as [PartTran_TranDate],
	(case when
 SubQuery3.PartTran_TranDate = @Today
 then
 SubQuery3.PartTran_TranDate
 when
 SubQuery2.JobHead_CreateDate = @Today
 then
 SubQuery2.JobHead_CreateDate
 else
 SubQuery2.JobHead_ClosedDate
 end) as [Calculated_ChangeDate]
from Erp.JobMtl as JobMtl
left outer join  (select 
	[JobHead].[Company] as [JobHead_Company],
	[JobHead].[ClosedDate] as [JobHead_ClosedDate],
	[JobHead].[JobNum] as [JobHead_JobNum],
	[JobHead].[CreateDate] as [JobHead_CreateDate]
from Erp.JobHead as JobHead
where (JobHead.ClosedDate = @Today  or JobHead.CreateDate = @Today))  as SubQuery2 on 
	JobMtl.Company = SubQuery2.JobHead_Company
	and JobMtl.JobNum = SubQuery2.JobHead_JobNum
left outer join  (select 
	[PartTran].[Company] as [PartTran_Company],
	[PartTran].[JobNum] as [PartTran_JobNum],
	[PartTran].[AssemblySeq] as [PartTran_AssemblySeq],
	[PartTran].[JobSeq] as [PartTran_JobSeq],
	[PartTran].[TranDate] as [PartTran_TranDate],
	[PartTran].[PartNum] as [PartTran_PartNum]
from Erp.PartTran as PartTran
where (PartTran.TranDate = @Today))  as SubQuery3 on 
	JobMtl.Company = SubQuery3.PartTran_Company
	and JobMtl.JobNum = SubQuery3.PartTran_JobNum
	and JobMtl.AssemblySeq = SubQuery3.PartTran_AssemblySeq
	and JobMtl.PartNum = SubQuery3.PartTran_PartNum
where (JobMtl.Company = 'RBMI'  or JobMtl.Company = 'SOLAR'))  as SubQuery1
where (SubQuery1.Calculated_ChangeDate = @Today)