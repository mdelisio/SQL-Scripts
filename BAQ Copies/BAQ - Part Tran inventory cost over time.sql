SELECT TOP (1000) 
PartNum,
PartDescription,
TranDate,
SysTime,
EntryPerson,
BinNum,
OrderNum,
JobNum,
TranType,
TranQty,
BeginQty,
AfterQty,
PONum,
POLine,
PORelNum,
MtlMtlUnitCost,
BegMtlUnitCost,
AfterMtlUnitCost
  FROM [ERPDB].[Erp].[PartTran]
  WHERE TranType >='01/01/2022' /*AND TranType = 'PUR-STK' */ AND PartNum like '6c%'
  ORDER BY TranDate DESC