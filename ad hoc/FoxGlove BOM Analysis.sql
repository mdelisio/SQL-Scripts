With OnHandInventory AS
(Select 
    Company,
    PartNum,
    Sum(OnHandQty) as OnHandQty
   FROM [ODS_ERPDB].[Erp_PartBin] 
Group By Company, PartNum
)

Select 
jm.Company,
JobComplete,
IssuedComplete,
JobNum,
AssemblySeq,
MtlSeq,
jm.PartNum,
[Description],
RequiredQty,
IssuedQty,
ohi.OnHandQty,
jm.TotalCost as MaterialActualCost,
jm.MtlBurCost as MaterialBurdenCost,
jm.TotalCost + MtlBurCost as TotalActualCost,
ISNULL((jm.TotalCost+jm.MtlBurCost)/NULLIF(IssuedQty,0),jm.EstUnitCost+jm.EstMtlBurUnitCost) as AverageActualCost,
CASE 
WHEN (RequiredQty - IssuedQty) > 0 THEN (RequiredQty - IssuedQty)
    ELSE 0 
END AS  RemainingQtyToIssue,
jm.EstBurUnitCost as EstimatedBurdenUnitCost,
jm.EstUnitCost as EstimatedMaterialUnitCost,
jm.EstUnitCost + jm.EstBurUnitCost as EstimatedTotalUnitCost,
CASE 
    WHEN (RequiredQty - IssuedQty) * (jm.EstUnitCost + jm.EstBurUnitCost) > 0 THEN (RequiredQty - IssuedQty) * (jm.EstUnitCost + jm.EstBurUnitCost)
    ELSE 0
END AS RemainingEstimatedCost
FROM ODS_ERPDB.Erp_JobMtl AS jm 
LEFT JOIN OnHandInventory ohi
    ON jm.Company = ohi.Company
    AND jm.PartNum = ohi.PartNum
Where jm.Company = 'Solar'
  AND jm.JobNum in ('4000711-5-1','4000711-5-2','4000711-5-3')
Order by Jobnum, MtlSeq
