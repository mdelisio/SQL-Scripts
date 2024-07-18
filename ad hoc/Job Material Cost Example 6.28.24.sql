SELECT 
Company,
Jobnum,
Partnum,
RequiredQty,
EstUnitCost,
RequiredQty*EstUnitCost AS EstimatedTotalCost,
IssuedQty,
TotalCost as IssuedTotalCost,
TotalCost/IssuedQty as IssuedUnitCost
FROM [ODS_ERPDB].[Erp_JobMtl]
WHERE Company = 'solar'
AND Jobnum ='4001353-5-1'
AND Partnum = '113923-DM'

SELECT 
Company,
Partnum,
AvgLaborCost + AvgBurdenCost + AvgMaterialCost + AvgMtlBurCost + AvgSubContCost AS AverageUnitCost,
StdLaborCost + StdBurdenCost + StdMaterialCost + StdMtlBurCost + StdSubContCost AS StandardUnitCost
FROM [ODS_ERPDB].[Erp_PartCost]
WHERE Company = 'solar'
AND Partnum = '113923-DM'

SELECT 
Company,
TranDate,
Partnum,
JobNum,
TranQty,
MtlUnitCost + LbrUnitCost + BurUnitCost + SubUnitCost + MtlBurdenUnitCost as UnitCost,
ExtCost
FROM [ODS_ERPDB].[Erp_PartTran]
WHERE Company = 'solar'
AND Jobnum ='4001353-5-1'
AND Partnum = '113923-DM'
Order by TranDate DESC

Select 
Company,
Partnum,
Jobnum,
Sum(ExtCost) as TotalPartCost
FROM [ODS_ERPDB].[Erp_PartTran]
WHERE Company = 'solar'
AND Jobnum ='4001353-5-1'
AND Partnum = '113923-DM'
Group By Company,Partnum, Jobnum





