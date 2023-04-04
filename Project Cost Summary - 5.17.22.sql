
select 
	[Project].[Company] as [Project_Company],
	[Project].[ProjectID] as [Project_ProjectID],
	[Project].[Description] as [Project_Description],
	[OrderSummary].[OrderDtl1_PartNum] as [OrderDtl1_PartNum],
	[OrderSummary].[OrderDtl1_LineDesc] as [OrderDtl1_LineDesc],
	[OrderSummary].[OrderDtl_ProdCode] as [OrderDtl_ProdCode],
	[OrderSummary].[OrderDtl1_OrderNum] as [OrderDtl1_OrderNum],
	[OrderSummary].[OrderDtl1_OrderLine] as [OrderDtl1_OrderLine],
	[OrderSummary].[OrderDtl_OpenLine] as [OrderDtl_OpenLine],
	(sum(OrderSummary.Calculated_SumSellPrice)) as [Calculated_ProjSellPrice],
	(isnull(case when OrderSummary.OrderDtl_OpenLine = 'false' then (sum(OrderSummary.Calculated_SumSellPrice)) else sum(OrderSummary.Calculated_OrdInvVal) end,0)) as [Calculated_ProjInvBilling],
	(((sum(OrderSummary.Calculated_SumSellPrice)) - (isnull(case when OrderSummary.OrderDtl_OpenLine = 'false' then (sum(OrderSummary.Calculated_SumSellPrice)) else sum(OrderSummary.Calculated_OrdInvVal) end,0)) )) as [Calculated_UnbilledBal],
	(isnull(sum(OrderSummary.Calculated_OrdMtlCst),0)) as [Calculated_ProjMtlCost],
	(isnull(sum(OrderSummary.Calculated_OrdLbrCst),0)) as [Calculated_ProjLbtCost],
	(isnull(sum(OrderSummary.Calculated_OrdBurCst),0)) as [Calculated_ProjBurCst],
	(isnull(sum(OrderSummary.Calculated_OrdSubCst),0)) as [Calculated_ProjSubCst],
	(sum(OrderSummary.Calculated_SumOrigEst)) as [Calculated_ProjOrigEst],
	--(ProjMtlCost + ProjLbtCost + ProjBurCst + ProjSubCst) as [Calculated_ProjTtlCst],
    (
        (isnull(sum(OrderSummary.Calculated_OrdMtlCst),0)) 
        + (isnull(sum(OrderSummary.Calculated_OrdLbrCst),0)) 
        + (isnull(sum(OrderSummary.Calculated_OrdBurCst),0)) 
        +(isnull(sum(OrderSummary.Calculated_OrdSubCst),0))
        )
    as [Calculated_ProjTtlCst],
/* 	(ISNULL
(case when (OrderSummary.OrderDtl_OpenLine) = 'true'
then
(case when
sum (OrderSummary.Calculated_OrdCurrEst) > ProjTtlCst
then 
 sum (OrderSummary.Calculated_OrdCurrEst)
 when
 sum (OrderSummary.Calculated_OrdCurrEst) < ProjOrigEst
 then
 ProjOrigEst
 else 
 ProjTtlCst
 end)
 else
 ProjTtlCst
 end,
 0)) as [Calculated_ProjCurrEst],
	(ProjOrigEst-ProjCurrEst) as [Calculated_OverUnder] */
    (ISNULL 
        (case when (OrderSummary.OrderDtl_OpenLine) = 'true'
        then
            (case when
            sum (OrderSummary.Calculated_OrdCurrEst) > 
                ((isnull(sum(OrderSummary.Calculated_OrdMtlCst),0)) 
                + (isnull(sum(OrderSummary.Calculated_OrdLbrCst),0)) 
                + (isnull(sum(OrderSummary.Calculated_OrdBurCst),0)) 
                + (isnull(sum(OrderSummary.Calculated_OrdSubCst),0))
                )
            )
from erp.Project as Project
inner join  (select 
	[OrderSellPrice].[OrderDtl1_Company] as [OrderDtl1_Company],
	[OrderSellPrice].[OrderDtl1_ProjectID] as [OrderDtl1_ProjectID],
	[OrderSellPrice].[OrderDtl1_OrderNum] as [OrderDtl1_OrderNum],
	[OrderSellPrice].[OrderDtl1_OrderLine] as [OrderDtl1_OrderLine],
	[OrderDtl].[ProdCode] as [OrderDtl_ProdCode],
	[OrderSellPrice].[Calculated_TotalPrice] as [Calculated_TotalPrice],
	[OrderSellPrice].[OrderDtl1_EstUnitCost_c] as [OrderDtl1_EstUnitCost_c],
	[OrderSellPrice].[Calculated_OrdDtlOrigEst] as [Calculated_OrdDtlOrigEst],
	((OrderSellPrice.Calculated_TotalPrice)) as [Calculated_SumSellPrice],
	((OrderSellPrice.Calculated_OrdDtlOrigEst)) as [Calculated_SumOrigEst],
	(sum(OrderRelDtl.Calculated_SumInvVal)) as [Calculated_OrdInvVal],
	(sum(OrderRelDtl.Calculated_SumMtlCst)) as [Calculated_OrdMtlCst],
	(sum (OrderRelDtl.Calculated_SumLbrCst)) as [Calculated_OrdLbrCst],
	[OrderSellPrice].[OrderDtl1_PartNum] as [OrderDtl1_PartNum],
	[OrderSellPrice].[OrderDtl1_LineDesc] as [OrderDtl1_LineDesc],
	[OrderDtl].[Company] as [OrderDtl_Company],
	[OrderDtl].[OrderNum] as [OrderDtl_OrderNum],
	[OrderDtl].[OrderLine] as [OrderDtl_OrderLine],
	[OrderDtl].[ProjectID] as [OrderDtl_ProjectID],
	(isnull(sum(OrderRelDtl.Calculated_RelCurrEst),0)) as [Calculated_OrdCurrEst],
	(sum (OrderRelDtl.Calculated_SumBurCst)) as [Calculated_OrdBurCst],
	[OrderDtl].[OpenLine] as [OrderDtl_OpenLine],
	(sum(OrderRelDtl.Calculated_SumSubCst)) as [Calculated_OrdSubCst]
from  (select 
	[OrderDtl1].[Company] as [OrderDtl1_Company],
	[OrderDtl1].[ProjectID] as [OrderDtl1_ProjectID],
	[OrderDtl1].[OrderNum] as [OrderDtl1_OrderNum],
	[OrderDtl1].[OrderLine] as [OrderDtl1_OrderLine],
	[OrderDtl1].[UnitPrice] as [OrderDtl1_UnitPrice],
	[OrderDtl1].[OrderQty] as [OrderDtl1_OrderQty],
	[OrderDtl1].[EstUnitCost_c] as [OrderDtl1_EstUnitCost_c],
	((OrderDtl1.UnitPrice* OrderDtl1.OrderQty)) as [Calculated_TotalPrice],
	((OrderDtl1.EstUnitCost_c)) as [Calculated_OrdDtlOrigEst],
	[OrderDtl1].[PartNum] as [OrderDtl1_PartNum],
	[OrderDtl1].[LineDesc] as [OrderDtl1_LineDesc]
from dbo.OrderDtl as OrderDtl1
group by [OrderDtl1].[Company],
	[OrderDtl1].[ProjectID],
	[OrderDtl1].[OrderNum],
	[OrderDtl1].[OrderLine],
	[OrderDtl1].[UnitPrice],
	[OrderDtl1].[OrderQty],
	[OrderDtl1].[EstUnitCost_c],
	[OrderDtl1].[PartNum],
	[OrderDtl1].[LineDesc])  as OrderSellPrice
inner join Erp.OrderDtl as OrderDtl on 
	OrderDtl.Company = OrderSellPrice.OrderDtl1_Company
	and OrderDtl.OrderNum = OrderSellPrice.OrderDtl1_OrderNum
	and OrderDtl.OrderLine = OrderSellPrice.OrderDtl1_OrderLine
inner join  (select 
	[OrderRel1].[Company] as [OrderRel1_Company],
	[OrderRel1].[OrderNum] as [OrderRel1_OrderNum],
	[OrderRel1].[OrderLine] as [OrderRel1_OrderLine],
	[OrderRel1].[OrderRelNum] as [OrderRel1_OrderRelNum],
	[InvDtl].[Calculated_ExtPrice] as [Calculated_ExtPrice],
	(sum(InvDtl.Calculated_ExtPrice)) as [Calculated_SumInvVal],
	(sum(JobSummary.Calculated_SumMtlCst)) as [Calculated_SumMtlCst],
	(Sum(JobSummary.Calculated_SumCurrEst)) as [Calculated_RelCurrEst],
	(sum(JobSummary.Calculated_SumBurCst)) as [Calculated_SumBurCst],
	(sum(JobSummary.Calculated_SumSubCst)) as [Calculated_SumSubCst],
	(sum(JobSummary.Calculated_SumLbrCst)) as [Calculated_SumLbrCst]
from Erp.OrderRel as OrderRel1
left outer join  (select 
	[InvcDtl].[Company] as [InvcDtl_Company],
	[InvcDtl].[OrderNum] as [InvcDtl_OrderNum],
	[InvcDtl].[OrderLine] as [InvcDtl_OrderLine],
	[InvcDtl].[OrderRelNum] as [InvcDtl_OrderRelNum],
	[InvcDtl].[InvoiceNum] as [InvcDtl_InvoiceNum],
	[InvcDtl].[InvoiceLine] as [InvcDtl_InvoiceLine],
	[InvcDtl].[ExtPrice] as [InvcDtl_ExtPrice],
	(sum(InvcDtl.ExtPrice)) as [Calculated_ExtPrice]
from Erp.InvcDtl as InvcDtl
group by [InvcDtl].[Company],
	[InvcDtl].[OrderNum],
	[InvcDtl].[OrderLine],
	[InvcDtl].[OrderRelNum],
	[InvcDtl].[InvoiceNum],
	[InvcDtl].[InvoiceLine],
	[InvcDtl].[ExtPrice])  as InvDtl on 
	OrderRel1.Company = InvDtl.InvcDtl_Company
	and OrderRel1.OrderNum = InvDtl.InvcDtl_OrderNum
	and OrderRel1.OrderLine = InvDtl.InvcDtl_OrderLine
	and OrderRel1.OrderRelNum = InvDtl.InvcDtl_OrderRelNum
left outer join  (select 
	[JobProd2].[Company] as [JobProd2_Company],
	[JobProd2].[JobNum] as [JobProd2_JobNum],
	[JobProd2].[OrderNum] as [JobProd2_OrderNum],
	[JobProd2].[OrderLine] as [JobProd2_OrderLine],
	[JobProd2].[OrderRelNum] as [JobProd2_OrderRelNum],
	(sum(CurrEst.Calculated_MtlCurrEst)) as [Calculated_SumCurrEst],
	(JobAsmbl.TLABurdenCost) as [Calculated_SumBurCst],
	(JobAsmbl.TLASubcontractCost) as [Calculated_SumSubCst],
	(JobAsmbl.TLALaborCost) as [Calculated_SumLbrCst],
	(JobAsmbl.TLAMaterialCost) as [Calculated_SumMtlCst],
	[JobAsmbl].[TLABurdenCost] as [JobAsmbl_TLABurdenCost],
	[JobAsmbl].[TLALaborCost] as [JobAsmbl_TLALaborCost],
	[JobAsmbl].[TLAMaterialCost] as [JobAsmbl_TLAMaterialCost],
	[JobAsmbl].[TLASubcontractCost] as [JobAsmbl_TLASubcontractCost]
from Erp.JobProd as JobProd2
left outer join Erp.JobAsmbl as JobAsmbl on 
	JobProd2.Company = JobAsmbl.Company
	and JobProd2.JobNum = JobAsmbl.JobNum
inner join  (select 
	[JobAsmbl1].[Company] as [JobAsmbl1_Company],
	[JobAsmbl1].[JobNum] as [JobAsmbl1_JobNum],
	[JobAsmbl1].[AssemblySeq] as [JobAsmbl1_AssemblySeq],
	[JobMtl].[JobNum] as [JobMtl_JobNum],
	[JobMtl].[AssemblySeq] as [JobMtl_AssemblySeq],
	[JobMtl].[MtlSeq] as [JobMtl_MtlSeq],
	[JobMtl].[RequiredQty] as [JobMtl_RequiredQty],
	[JobMtl].[EstUnitCost] as [JobMtl_EstUnitCost],
	[JobMtl].[IssuedQty] as [JobMtl_IssuedQty],
	[JobMtl].[TotalCost] as [JobMtl_TotalCost],
	(case when
 JobMtl.IssuedQty < JobMtl.RequiredQty
 then
 ((JobMtl.RequiredQty- JobMtl.IssuedQty) * JobMtl.EstUnitCost) + JobMtl.TotalCost
 else
 JobMtl.TotalCost
 end) as [Calculated_MtlCurrEst],
	[JobAsmbl1].[TLALaborCost] as [JobAsmbl1_TLALaborCost],
	[JobAsmbl1].[TLABurdenCost] as [JobAsmbl1_TLABurdenCost],
	[JobAsmbl1].[TLAMaterialCost] as [JobAsmbl1_TLAMaterialCost],
	[JobAsmbl1].[TLASubcontractCost] as [JobAsmbl1_TLASubcontractCost],
	[JobAsmbl1].[TLELaborCost] as [JobAsmbl1_TLELaborCost],
	[JobAsmbl1].[TLEBurdenCost] as [JobAsmbl1_TLEBurdenCost],
	[JobAsmbl1].[TLEMaterialCost] as [JobAsmbl1_TLEMaterialCost],
	[JobAsmbl1].[TLESubcontractCost] as [JobAsmbl1_TLESubcontractCost],
	[JobMtl].[PartNum] as [JobMtl_PartNum],
	[JobOper].[ActBurCost] as [JobOper_ActBurCost],
	[JobOper].[ActLabCost] as [JobOper_ActLabCost]
from Erp.JobAsmbl as JobAsmbl1
left outer join Erp.JobMtl as JobMtl on 
	JobAsmbl1.Company = JobMtl.Company
	and JobAsmbl1.JobNum = JobMtl.JobNum
	and JobAsmbl1.AssemblySeq = JobMtl.AssemblySeq
left outer join Erp.JobOper as JobOper on 
	JobAsmbl1.Company = JobOper.Company
	and JobAsmbl1.JobNum = JobOper.JobNum
	and JobAsmbl1.AssemblySeq = JobOper.AssemblySeq
group by [JobAsmbl1].[Company],
	[JobAsmbl1].[JobNum],
	[JobAsmbl1].[AssemblySeq],
	[JobMtl].[JobNum],
	[JobMtl].[AssemblySeq],
	[JobMtl].[MtlSeq],
	[JobMtl].[RequiredQty],
	[JobMtl].[EstUnitCost],
	[JobMtl].[IssuedQty],
	[JobMtl].[TotalCost],
	[JobAsmbl1].[TLALaborCost],
	[JobAsmbl1].[TLABurdenCost],
	[JobAsmbl1].[TLAMaterialCost],
	[JobAsmbl1].[TLASubcontractCost],
	[JobAsmbl1].[TLELaborCost],
	[JobAsmbl1].[TLEBurdenCost],
	[JobAsmbl1].[TLEMaterialCost],
	[JobAsmbl1].[TLESubcontractCost],
	[JobMtl].[PartNum],
	[JobOper].[ActBurCost],
	[JobOper].[ActLabCost])  as CurrEst on 
	JobAsmbl.Company = CurrEst.JobAsmbl1_Company
	and JobAsmbl.JobNum = CurrEst.JobAsmbl1_JobNum
	and JobAsmbl.AssemblySeq = CurrEst.JobAsmbl1_AssemblySeq
group by [JobProd2].[Company],
	[JobProd2].[JobNum],
	[JobProd2].[OrderNum],
	[JobProd2].[OrderLine],
	[JobProd2].[OrderRelNum],
	[JobAsmbl].[TLABurdenCost],
	[JobAsmbl].[TLALaborCost],
	[JobAsmbl].[TLAMaterialCost],
	[JobAsmbl].[TLASubcontractCost])  as JobSummary on 
	OrderRel1.Company = JobSummary.JobProd2_Company
	and OrderRel1.OrderNum = JobSummary.JobProd2_OrderNum
	and OrderRel1.OrderLine = JobSummary.JobProd2_OrderLine
	and OrderRel1.OrderRelNum = JobSummary.JobProd2_OrderRelNum
group by [OrderRel1].[Company],
	[OrderRel1].[OrderNum],
	[OrderRel1].[OrderLine],
	[OrderRel1].[OrderRelNum],
	[InvDtl].[Calculated_ExtPrice])  as OrderRelDtl on 
	OrderDtl.Company = OrderRelDtl.OrderRel1_Company
	and OrderDtl.OrderNum = OrderRelDtl.OrderRel1_OrderNum
	and OrderDtl.OrderLine = OrderRelDtl.OrderRel1_OrderLine
group by [OrderSellPrice].[OrderDtl1_Company],
	[OrderSellPrice].[OrderDtl1_ProjectID],
	[OrderSellPrice].[OrderDtl1_OrderNum],
	[OrderSellPrice].[OrderDtl1_OrderLine],
	[OrderDtl].[ProdCode],
	[OrderSellPrice].[Calculated_TotalPrice],
	[OrderSellPrice].[OrderDtl1_EstUnitCost_c],
	[OrderSellPrice].[Calculated_OrdDtlOrigEst],
	[OrderSellPrice].[OrderDtl1_PartNum],
	[OrderSellPrice].[OrderDtl1_LineDesc],
	[OrderDtl].[Company],
	[OrderDtl].[OrderNum],
	[OrderDtl].[OrderLine],
	[OrderDtl].[ProjectID],
	[OrderDtl].[OpenLine]) as OrderSummary on 
	Project.Company = OrderSummary.OrderDtl_Company
	and Project.ProjectID = OrderSummary.OrderDtl_ProjectID
where (
Project.Company = '2'
and Project.ProjectID = '2170022'
and Project.ActiveProject = 'true'  
)
group by [Project].[Company],
	[Project].[ProjectID],
	[Project].[Description],
	[OrderSummary].[OrderDtl1_PartNum],
	[OrderSummary].[OrderDtl1_LineDesc],
	[OrderSummary].[OrderDtl_ProdCode],
	[OrderSummary].[OrderDtl1_OrderNum],
	[OrderSummary].[OrderDtl1_OrderLine],
	[OrderSummary].[OrderDtl_OpenLine]