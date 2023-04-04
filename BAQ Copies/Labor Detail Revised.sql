Declare @BeginDate DATE
Declare @EndDate DATE
Set @BeginDate = '2021-01-01'
Set @EndDate = '2022-07-31'


Select TOP (1000)
	[LaborDtl].[Company] as [LaborDtl_Company],
	[LaborDtl].[EmployeeNum] as [LaborDtl_EmployeeNum],
	[LaborDtl].[LaborHedSeq] as [LaborDtl_LaborHedSeq],
	[LaborDtl].[LaborDtlSeq] as [LaborDtl_LaborDtlSeq],
	[LaborDtl].[LaborType] as [LaborDtl_LaborType],
	[LaborDtl].[ReWork] as [LaborDtl_ReWork],
	[LaborDtl].[JobNum] as [LaborDtl_JobNum],
	[LaborDtl].[OprSeq] as [LaborDtl_OprSeq],
	[LaborDtl].[LaborHrs] as [LaborDtl_LaborHrs],
	[LaborDtl].[BurdenHrs] as [LaborDtl_BurdenHrs],
	[LaborDtl].[IndirectCode] as [LaborDtl_IndirectCode],
	[LaborDtl].[ApprovedDate] as [LaborDtl_ApprovedDate],
	[LaborDtl].[ExpenseCode] as [LaborDtl_ExpenseCode],
	[LaborDtl].[ClockInDate] as [LaborDtl_ClockInDate],
	[LaborDtl].[LaborRate] as [LaborDtl_LaborRate],
	[LaborDtl].[BurdenRate] as [LaborDtl_BurdenRate],
	[LaborDtl].[JCDept] as [LaborDtl_JCDept],
	[LaborDtl].[ResourceGrpID] as [LaborDtl_ResourceGrpID],
	[LaborDtl].[OpCode] as [LaborDtl_OpCode],
	[ResourceGroup].[Description] as [ResourceGroup_Description],
	[OpMaster].[OpDesc] as [OpMaster_OpDesc],
	[JobProd].[PartNum] as [JobProd_PartNum],
	[EmpBasic].[LastName] as [EmpBasic_LastName],
	[EmpBasic].[JCDept] as [EmpBasic_JCDept],
	[EmpBasic].[Payroll] as [EmpBasic_Payroll],
	[EmpBasic].[PayrollCode_c] as [EmpBasic_PayrollCode_c],
	[EmpBasic].[PayrollFileNo_c] as [EmpBasic_PayrollFileNo_c],
	[EmpBasic].[PayrollLocID_c] as [EmpBasic_PayrollLocID_c],
	[ResourceGroup].[Plant] as [ResourceGroup_Plant],
	[OrderHed].[Division_c] as [OrderHed_Division_c]
from Erp.LaborDtl as LaborDtl
left outer join Erp.ResourceGroup as ResourceGroup on 
	LaborDtl.Company = ResourceGroup.Company
	and LaborDtl.ResourceGrpID = ResourceGroup.ResourceGrpID
left outer join Erp.OpMaster as OpMaster on 
	LaborDtl.Company = OpMaster.Company
	and LaborDtl.OpCode = OpMaster.OpCode
left outer join erpdb.dbo.EmpBasic as EmpBasic on 
	LaborDtl.Company = EmpBasic.Company
	and LaborDtl.EmployeeNum = EmpBasic.EmpID
left outer join Erp.JobProd as JobProd on 
	LaborDtl.Company = JobProd.Company
	and LaborDtl.JobNum = JobProd.JobNum
left outer join erpdb.dbo.OrderHed as OrderHed on 
	JobProd.Company = OrderHed.Company
	and JobProd.OrderNum = OrderHed.OrderNum
where (LaborDtl.ClockInDate >= @BeginDate  and LaborDtl.ClockInDate <= @EndDate)