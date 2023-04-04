SELECT Top (1000)
	[Part].[ClassID] as [Part_ClassID],
	[Part].[PartNum] as [Part_PartNum],
	[Part].[PartDescription] as [Part_PartDescription],
	[Part].[TypeCode] as [Part_TypeCode],
	[Part].[NonStock] as [Part_NonStock],
	[PartCost].[StdLaborCost] as [PartCost_StdLaborCost],
	[PartCost].[StdBurdenCost] as [PartCost_StdBurdenCost],
	[PartCost].[StdMaterialCost] as [PartCost_StdMaterialCost],
	[PartCost].[StdSubContCost] as [PartCost_StdSubContCost],
	[PartCost].[StdMtlBurCost] as [PartCost_StdMtlBurCost],
	[Part].[NetWeight] as [Part_NetWeight],
	[Part].[InActive] as [Part_InActive],
	[Part].[IUM] as [Part_IUM],
	[Part].[UserChar1] as [Part_UserChar1],
	[Part].[PUM] as [Part_PUM],
	[PartCost].[AvgLaborCost] as [PartCost_AvgLaborCost],
	[PartCost].[AvgBurdenCost] as [PartCost_AvgBurdenCost],
	[PartCost].[AvgMaterialCost] as [PartCost_AvgMaterialCost],
	[PartCost].[AvgSubContCost] as [PartCost_AvgSubContCost],
	[PartCost].[AvgMtlBurCost] as [PartCost_AvgMtlBurCost],
	[PartBin].[BinNum] as [PartBin_BinNum],
	[PartBin].[OnhandQty] as [PartBin_OnhandQty],
	[PartPlant].[MinimumQty] as [PartPlant_MinimumQty],
	[PartPlant].[MfgLotMultiple] as [PartPlant_MfgLotMultiple],
	[Part].[CostMethod] as [Part_CostMethod],
	[PlantWhse].[PrimBin] as [PlantWhse_PrimBin],
	[Part].[UserChar2] as [Part_UserChar2],
	[UOMConv].[ConvFactor] as [UOMConv_ConvFactor],
	[PartPlant].[Plant] as [PartPlant_Plant]
from ERPDB.Erp.Part as Part
left outer join ERPDB.Erp.PartPlant as PartPlant on 
	Part.Company = PartPlant.Company
	and Part.PartNum = PartPlant.PartNum
inner join ERPDB.Erp.PlantWhse as PlantWhse on 
	PartPlant.Company = PlantWhse.Company
	and PartPlant.PartNum = PlantWhse.PartNum
	and PartPlant.Plant = PlantWhse.Plant
left outer join ERPDB.Erp.PartBin as PartBin on 
	PartBin.Company = PlantWhse.Company
	and PartBin.PartNum = PlantWhse.PartNum
	and PartBin.WarehouseCode = PlantWhse.WarehouseCode
left outer join ERPDB.Erp.PartCost as PartCost on 
	Part.PartNum = PartCost.PartNum
left outer join ERPDB.Erp.UOMClass as UOMClass on 
	Part.Company = UOMClass.Company
	and Part.UOMClassID = UOMClass.UOMClassID
left outer join ERPDB.Erp.UOMConv as UOMConv on 
	UOMClass.Company = UOMConv.Company
	and UOMClass.UOMClassID = UOMConv.UOMClassID
	and UOMClass.DefUomCode = UOMConv.UOMCode
where (Part.ClassID <> 'CUST'  and Part.ClassID <> 'MCUST'  and Part.ClassID <> 'JOB'  and Part.ClassID <> 'IMP')
