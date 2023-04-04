
select top (1000)
	[GLJrnDtl].[Company] as [GLJrnDtl_Company],
	[GLJrnDtl].[FiscalYear] as [GLJrnDtl_FiscalYear],
	[GLJrnDtl].[JournalNum] as [GLJrnDtl_JournalNum],
	[GLJrnDtl].[Description] as [GLJrnDtl_Description],
	[GLJrnDtl].[JEDate] as [GLJrnDtl_JEDate],
	[GLJrnDtl].[FiscalPeriod] as [GLJrnDtl_FiscalPeriod],
	[GLJrnDtl].[GroupID] as [GLJrnDtl_GroupID],
	[GLJrnDtl].[DebitAmount] as [GLJrnDtl_DebitAmount],
	[GLJrnDtl].[CreditAmount] as [GLJrnDtl_CreditAmount],
	[GLJrnDtl].[PostedBy] as [GLJrnDtl_PostedBy],
	[GLJrnDtl].[PostedDate] as [GLJrnDtl_PostedDate],
	[GLJrnDtl].[Posted] as [GLJrnDtl_Posted],
	[GLJrnDtl].[GLAccount] as [GLJrnDtl_GLAccount],
	[GLJrnDtl].[SegValue3] as [GLJrnDtl_SegValue3],
	[GLJrnDtl].[SegValue2] as [GLJrnDtl_SegValue2],
	[GLJrnDtl].[SegValue1] as [GLJrnDtl_SegValue1],
	[GLJrnDtl].[SourceModule] as [GLJrnDtl_SourceModule],
	[GLJrnDtl].[VendorNum] as [GLJrnDtl_VendorNum],
	[GLJrnDtl].[APInvoiceNum] as [GLJrnDtl_APInvoiceNum],
	[GLJrnDtl].[JournalCode] as [GLJrnDtl_JournalCode],
	[GLJrnDtl].[ARInvoiceNum] as [GLJrnDtl_ARInvoiceNum],
	[GLJrnDtl].[BankAcctID] as [GLJrnDtl_BankAcctID],
	[GLJrnDtl].[CheckNum] as [GLJrnDtl_CheckNum],
	[GLJrnDtl].[CRHeadNum] as [GLJrnDtl_CRHeadNum]
from Erp.GLJrnDtl as GLJrnDtl
where GLJrnDtl.FiscalYear = 2022 
    And GLJrnDtl.FiscalPeriod = 5
    And GLJrnDtl.Company = 'Solar'
	And (GLJrnDtl.SegValue1 >= 4000 and GLJrnDtl.SegValue1 <= 9999)
Order by SegValue1 