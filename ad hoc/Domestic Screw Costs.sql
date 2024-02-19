Select Top (100) *
From ODS_ERPDB.ERP_Part
Where 1=1
and Company = 'Solar'
and (Partnum like '120038%'
    OR Partnum like '119327%'
    OR Partnum like '120039%')

Select Top (100) *
From ODS_ERPDB.ERP_Parttran
Where 1=1
and Company = 'Solar'
and (Partnum like '120038%'
    OR Partnum like '119327%'
    OR Partnum like '120039%')

Select 
Company,
TranDate,
Partnum,
Warehousecode,
Binnum,
TranClass,
TranType,
TranQty,
UM,
MtlUnitCost+LbrUnitCost+BurUnitCost+SubUnitCost+MtlBurUnitCost as TotalUnitCost,
MtlUnitCost,
LbrUnitCost,
BurUnitCost,
SubUnitCost,
MtlBurUnitCost,
ExtCost,
CostMethod,
JobNum,
BeginQty,
AfterQty
From ODS_ERPDB.ERP_Parttran
Where 1=1
and Company = 'Solar'
and Partnum in ('113923-DM','115585-DM','119927-DM','120039-DM','120206-DM','120207-DM','116770-DM','120038-DM','115570-DM')
And TranType <> 'ADJ-CST'
Order by TranDate Desc



Select Top (100) *
From ODS_ERPDB.ERP_Part
Where 1=1
and Company = 'Solar'
and Partnum like '%DM'




Select Top (100) *
From ODS_ERPDB.ERP_Part
Where 1=1
and Company = 'Solar'
and ClassID = 'GsCR'


-- All Screw part transactions
Select 
pt.Company,
TranDate,
pt.Partnum,
Warehousecode,
Binnum,
TranClass,
TranType,
TranQty,
UM,
MtlUnitCost+LbrUnitCost+BurUnitCost+SubUnitCost+MtlBurUnitCost as TotalUnitCost,
MtlUnitCost,
LbrUnitCost,
BurUnitCost,
SubUnitCost,
MtlBurUnitCost,
ExtCost,
pt.CostMethod,
JobNum,
BeginQty,
AfterQty
From ODS_ERPDB.ERP_Parttran pt
LEFT JOIN ODS_ERPDB.ERP_Part p
    ON pt.Company = p.Company
    AND pt.partnum = p.partnum
Where 1=1
and pt.Company = 'Solar'
and p.ClassID = 'GsCR'