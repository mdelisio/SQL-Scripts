SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

 -- Created for updated view of PerpetualInventory with Extended Cost added 
 -- Created 2/28/2023

Create VIEW [etl].[vwPerpetualInventory] AS

with ActualAvgCostPerRow
as ( 
SELECT
    p.Company as Company,
    p.PartNum as PartNum,
    Sum(COALESCE(pb.OnhandQty,0)) as OnhandQty,
    Sum((pc.AvgLaborCost + pc.AvgBurdenCost + pc.AvgMaterialCost + pc.AvgSubContCost + pc.AvgMtlBurCost) * (COALESCE(pb.OnhandQty,0))) as TotalExtCost,
    MAX((pc.AvgLaborCost + pc.AvgBurdenCost + pc.AvgMaterialCost + pc.AvgSubContCost + pc.AvgMtlBurCost)) MaxAvgCost,
    Case 
        When COALESCE(SUM(pb.OnhandQty),0) = 0 Then MAX((pc.AvgLaborCost + pc.AvgBurdenCost + pc.AvgMaterialCost + pc.AvgSubContCost + pc.AvgMtlBurCost))
        Else Sum((pc.AvgLaborCost + pc.AvgBurdenCost + pc.AvgMaterialCost + pc.AvgSubContCost + pc.AvgMtlBurCost) * COALESCE(pb.OnhandQty,0))/COALESCE(SUM(pb.OnhandQty),0)
    END as WeightedAverageCost
from Erp.Part as P
left outer join Erp.PartPlant as pp on 
	p.Company = pp.Company
	and p.PartNum = pp.PartNum
inner join Erp.PlantWhse as pw on 
	pp.Company = pw.Company
	and pp.PartNum = pw.PartNum
	and pp.Plant = pw.Plant
left outer join Erp.PartBin as pb on 
	pb.Company = pw.Company
	and pb.PartNum = pw.PartNum
	and pb.WarehouseCode = pw.WarehouseCode
left outer join Erp.PartCost as pc on 
	p.PartNum = pc.PartNum
where (p.ClassID <> 'CUST'  and p.ClassID <> 'MCUST'  and p.ClassID <> 'JOB'  and p.ClassID <> 'IMP')
    and p.Inactive = 0 -- exclude inactive part rows
    and p.Company = 'Solar'
GROUP By p.Company, p.Partnum
)

Select 
    p.company as Company,
    p.ClassID as ClassID,
    p.PartNum as PartNum,
	p.PartDescription as PartDescription,
	p.TypeCode as Part_TypeCode,
	p.NonStock as Part_NonStock,
    p.NetWeight as Part_NetWeight,
	p.InActive as Part_InActive,
	p.IUM as Part_IUM,
	p.UserChar1 as Part_UserChar1,
	p.PUM as Part_PUM,
	pc.StdLaborCost as StdLaborCost,
	pc.StdBurdenCost as StdBurdenCost,
	pc.StdMaterialCost as tdMaterialCost,
	pc.StdSubContCost as StdSubContCost,
	pc.StdMtlBurCost as StdMtlBurCost,
    pc.StdLaborCost + pc.StdBurdenCost + pc.StdMaterialCost + pc.StdSubContCost + pc.StdMtlBurCost as TotalStandardCost,
	pc.AvgLaborCost as AvgLaborCost,
	pc.AvgBurdenCost as AvgBurdenCost,
	pc.AvgMaterialCost as AvgMaterialCost,
	pc.AvgSubContCost as AvgSubContCost,
	pc.AvgMtlBurCost as AvgMtlBurCost,
    pc.AvgLaborCost + pc.AvgBurdenCost + pc.AvgMaterialCost + pc.AvgSubContCost + pc.AvgMtlBurCost as TotalAverageCost,
    acpr.WeightedAverageCost as WeightedAverageCost,
	pb.BinNum as PBinNum,
	pb.OnhandQty as POnhandQty,
	pp.MinimumQty as MinimumQty,
	pp.MfgLotMultiple as MfgLotMultiple,
	p.CostMethod as Part_CostMethod,
	pw.PrimBin as PrimBin,
	p.UserChar2 as UserChar2,
	umconv.ConvFactor as UOM_ConvFactor,
	pp.Plant as Plant,
    Case 
        When p.CostMethod = 'S'  Then (pc.StdLaborCost + pc.StdBurdenCost + pc.StdMaterialCost + pc.StdSubContCost + pc.StdMtlBurCost) * COALESCE(pb.OnhandQty,0)
        Else (pc.AvgLaborCost + pc.AvgBurdenCost + pc.AvgMaterialCost + pc.AvgSubContCost + pc.AvgMtlBurCost) * COALESCE(pb.OnhandQty,0)
    End as TotalExtCost
from Erp.Part as P
left outer join Erp.PartPlant as pp on 
	p.Company = pp.Company
	and p.PartNum = pp.PartNum
inner join Erp.PlantWhse as pw on 
	pp.Company = pw.Company
	and pp.PartNum = pw.PartNum
	and pp.Plant = pw.Plant
left outer join Erp.PartBin as pb on 
	pb.Company = pw.Company
	and pb.PartNum = pw.PartNum
	and pb.WarehouseCode = pw.WarehouseCode
left outer join Erp.PartCost as pc on 
	p.PartNum = pc.PartNum
left outer join Erp.UOMClass as umclass on 
	p.Company = umclass.Company
	and p.UOMClassID = umclass.UOMClassID
left outer join Erp.UOMConv as umconv on 
	umclass.Company = umconv.Company
	and umclass.UOMClassID = umconv.UOMClassID
	and umclass.DefUomCode = umconv.UOMCode
LEFT JOIN ActualAvgCostPerRow as acpr
    on p.partnum = acpr.partnum
    and p.company = acpr.company
where (p.ClassID <> 'CUST'  and p.ClassID <> 'MCUST'  and p.ClassID <> 'JOB'  and p.ClassID <> 'IMP')





