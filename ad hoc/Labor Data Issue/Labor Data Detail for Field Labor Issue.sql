Select 
Company,
EmployeeNum,
LaborHedSeq,
LaborDtlSeq
LaborType,
JobNum,
AssemblySeq,
OprSeq,
ResourceGrpID,
ResourceID,
LaborHrs,
BurdenHrs,
LaborRate,
BurdenRate,
LaborHrs * LaborRate as LaborCost,
BurdenHrs * BurdenRate as BurdenCost,
LaborHrs * LaborRate + BurdenHrs * BurdenRate as LaborAndBurdenCost,
LaborNote,
ExpenseCode,
ClockinDate,
ClockinTime,
ClockOutTime,
PayRollDate,
PostedtoGL,
ProjectID,
PhaseID,
CreatedBy,
CreateDate
FROM [ODS_ERPDB].[Erp_LaborDtl]
Where 1=1
and Company = 'Solar'
and JobNum LIKE '%4-1'
AND (PayrollDate >= '2023-10-23' AND PayrollDate <= '2024-02-25' )
Order By PayrollDate DESC



