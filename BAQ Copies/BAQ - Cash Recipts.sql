Declare @TransDateStart date
Set @TransDateStart = '3/1/2024';

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
	[CashDtl].[Reference] as [CashDtl_Reference]
from Erp.CashDtl as CashDtl
where (CashDtl.TranDate >= @TransDateStart and CashDtl.TranType = 'PayInv')