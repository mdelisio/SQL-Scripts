Declare @TransDateStart date
Set @TransDateStart = '6/1/2024';

select 
	[CashDtl].[HeadNum] as [CashDtl_HeadNum],
	[CashDtl].[InvoiceNum] as [CashDtl_InvoiceNum],
	[CashDtl].[InvoiceRef] as [CashDtl_InvoiceRef],
	[CashDtl].[TranType] as [CashDtl_TranType],
	[CashDtl].[Posted] as [CashDtl_Posted],
	[CashDtl].[FiscalYear] as [CashDtl_FiscalYear],
	[CashDtl].[FiscalPeriod] as [CashDtl_FiscalPeriod],
	[CashDtl].[TranDate] as [CashDtl_TranDate],
	[CashDtl].[CheckRef] as [CashDtl_CheckRef],
	[CashDtl].[TranAmt] as [CashDtl_TranAmt],
	[CashDtl].[CustNum] as [CashDtl_CustNum]
from Erp.CashDtl as CashDtl
where (CashDtl.TranDate >= @TransDateStart and CashDtl.TranType = 'PayInv')
AND Company = 'solar'
Order by CashDtl.TranDate DESC, [CashDtl].[TranAmt] dESC




Declare @TransDateStart date
Set @TransDateStart = '5/1/2024';

select 
	[CashDtl].[HeadNum] as [CashDtl_HeadNum],
	[CashDtl].[InvoiceNum] as [CashDtl_InvoiceNum],
	[CashDtl].[InvoiceRef] as [CashDtl_InvoiceRef],
	[CashDtl].[TranType] as [CashDtl_TranType],
	[CashDtl].[Posted] as [CashDtl_Posted],
	[CashDtl].[FiscalYear] as [CashDtl_FiscalYear],
	[CashDtl].[FiscalPeriod] as [CashDtl_FiscalPeriod],
	[CashDtl].[TranDate] as [CashDtl_TranDate],
	[CashDtl].[CheckRef] as [CashDtl_CheckRef],
	[CashDtl].[TranAmt] as [CashDtl_TranAmt],
	[CashDtl].[CustNum] as [CashDtl_CustNum],
	[CashDtl].[Comment] as [CashDtl_Comment],
	[CashDtl].[Reference] as [CashDtl_Reference],
	c.name as customerName
from Erp.CashDtl as CashDtl
INNER JOIN erp.customer c
	on cashdtl.custnum = c.custnum
	and cashdtl.Company = c.Company
where (CashDtl.TranDate >= @TransDateStart and CashDtl.TranType = 'PayInv')
AND cashdtl.Company = 'solar'
Order by CashDtl.TranDate DESC, [CashDtl].[TranAmt] dESC


Select top (10)*
From erp.Customer

/*
Declare @TransDateStart date
Set @TransDateStart = '4/1/2024';

select 
	cd.[HeadNum] as [CashDtl_HeadNum],
	cd.[InvoiceNum] as [InvoiceNum],
	cd.[TranDate] as [TransactionDate],
	cd.[TranAmt] as [TransactionAmt]
from Erp.CashDtl as CD
where (cd.TranDate >= @TransDateStart and cd.TranType = 'PayInv')
AND Company = 'solar'
Order by CD.TranDate DESC
*/



