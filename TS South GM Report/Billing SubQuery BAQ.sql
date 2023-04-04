/*
 * Disclaimer!!!
 * This is not a real query being executed, but a simplified version for general vision.
 * Executing it with any other tool may produce a different result.
 */
 /*
select 
	[Project1].[ProjectID] as [Project1_ProjectID],
	(Avg(SubQuery1.Calculated_QuoteValue)) as [Calculated_QuoteValueTot],
	(sum(SubQuery1.Calculated_BillingFinal)) as [Calculated_BillingActuallyFinal],
	(sum(Calculated_Billing)) as [Calculated_BillingTot],
	(sum(Calculated_TaxTotal)) as [Calculated_TaxTotalTot],
	(QuoteValueTot - BillingActuallyFinal) as [Calculated_UnbilledTotal],
	(sum(Calculated_TotInvc)) as [Calculated_TotInvcTot],
	(sum(Calculated_CustPaid)) as [Calculated_CustPaidTot],
	[SubQuery1].[Customer_Name] as [Customer_Name]
from Erp.Project as Project1
inner join  (select 
	[Project].[ProjectID] as [Project_ProjectID],
	[SubQuery2].[Calculated_QuoteValue] as [Calculated_QuoteValue],
	[SubQuery3].[OrderHed_ProjectID_c] as [OrderHed_ProjectID_c],
	[SubQuery3].[Calculated_Billing] as [Calculated_Billing],
	((case when SubQuery3.Calculated_TaxTotal <> 0 then SubQuery3.Calculated_Billing - SubQuery3.Calculated_TaxTotal else SubQuery3.Calculated_Billing end)) as [Calculated_BillingFinal],
	(0) as [Calculated_BillingTax],
	[SubQuery3].[Calculated_TaxTotal] as [Calculated_TaxTotal],
	(round(SubQuery2.Calculated_QuoteValue - SubQuery3.Calculated_Billing,2)) as [Calculated_Unbilled],
	(round(SubQuery3.Calculated_Billing - SubQuery3.Calculated_CustPaid,2)) as [Calculated_TotInvc],
	[SubQuery3].[Calculated_CustPaid] as [Calculated_CustPaid],
	[Customer].[Name] as [Customer_Name],
	[Project].[Company] as [Project_Company]
from Erp.Project as Project
inner join  (select 
	[QuoteDtl].[Company] as [QuoteDtl_Company],
	[QuoteDtl].[ProjectID] as [QuoteDtl_ProjectID],
	(round(sum(QuoteDtl.DocExtPriceDtl),2)) as [Calculated_QuoteValue]
from Erp.QuoteDtl as QuoteDtl
group by [QuoteDtl].[Company],
	[QuoteDtl].[ProjectID])  as SubQuery2 on 
	SubQuery2.QuoteDtl_Company = Project.Company
	and SubQuery2.QuoteDtl_ProjectID = Project.ProjectID
left outer join  (select 
	[OrderHed].[Company] as [OrderHed_Company],
	[OrderHed].[ProjectID_c] as [OrderHed_ProjectID_c],
	[SubQuery4].[Calculated_Billing] as [Calculated_Billing],
	[SubQuery4].[Calculated_CustPaid] as [Calculated_CustPaid],
	[SubQuery4].[Calculated_TaxTotal] as [Calculated_TaxTotal]
from Erp.OrderHed as OrderHed
left outer join  (select 
	[InvcHead].[Company] as [InvcHead_Company],
	[InvcHead].[OrderNum] as [InvcHead_OrderNum],
	(round(sum(InvcHead.InvoiceAmt),2)) as [Calculated_Billing],
	(round(convert(decimal, sum(InvcHead.InvoiceAmt)) - convert(decimal, sum(InvcHead.InvoiceBal)),2)) as [Calculated_CustPaid],
	[SubQuery5].[Calculated_TaxTotal] as [Calculated_TaxTotal]
from Erp.InvcHead as InvcHead
left outer join  (select 
	[InvcDtl].[Company] as [InvcDtl_Company],
	[InvcDtl].[InvoiceNum] as [InvcDtl_InvoiceNum],
	[SubQuery6].[Calculated_TaxTotal] as [Calculated_TaxTotal]
from Erp.InvcDtl as InvcDtl
left outer join  (select 
	(round(sum(InvcTax.TaxAmt),2)) as [Calculated_TaxTotal],
	[InvcTax].[Company] as [InvcTax_Company],
	[InvcTax].[InvoiceNum] as [InvcTax_InvoiceNum],
	[InvcTax].[InvoiceLine] as [InvcTax_InvoiceLine]
from Erp.InvcTax as InvcTax
group by [InvcTax].[Company],
	[InvcTax].[InvoiceNum],
	[InvcTax].[InvoiceLine])  as SubQuery6 on 
	SubQuery6.InvcTax_Company = InvcDtl.Company
	and SubQuery6.InvcTax_InvoiceNum = InvcDtl.InvoiceNum
	and SubQuery6.InvcTax_InvoiceLine = InvcDtl.InvoiceLine
group by [InvcDtl].[Company],
	[InvcDtl].[InvoiceNum],
	[SubQuery6].[Calculated_TaxTotal])  as SubQuery5 on 
	SubQuery5.InvcDtl_Company = InvcHead.Company
	and SubQuery5.InvcDtl_InvoiceNum = InvcHead.InvoiceNum
group by [InvcHead].[Company],
	[InvcHead].[OrderNum],
	[SubQuery5].[Calculated_TaxTotal])  as SubQuery4 on 
	SubQuery4.InvcHead_Company = OrderHed.Company
	and SubQuery4.InvcHead_OrderNum = OrderHed.OrderNum
group by [OrderHed].[Company],
	[OrderHed].[ProjectID_c],
	[SubQuery4].[Calculated_Billing],
	[SubQuery4].[Calculated_CustPaid],
	[SubQuery4].[Calculated_TaxTotal])  as SubQuery3 on 
	SubQuery3.OrderHed_Company = Project.Company
	and SubQuery3.OrderHed_ProjectID_c = Project.ProjectID
inner join Erp.Customer as Customer on 
	Project.Company = Customer.Company
	and Project.ConBTCustNum = Customer.CustNum
group by [Project].[ProjectID],
	[SubQuery2].[Calculated_QuoteValue],
	[SubQuery3].[OrderHed_ProjectID_c],
	[SubQuery3].[Calculated_Billing],
	[SubQuery3].[Calculated_TaxTotal],
	[SubQuery3].[Calculated_CustPaid],
	[Customer].[Name],
	[Project].[Company])  as SubQuery1 on 
	SubQuery1.Project_Company = Project1.Company
	and SubQuery1.Project_ProjectID = Project1.ProjectID
inner join Erp.Customer as Customer1 on 
	Project1.Company = Customer1.Company
	and Project1.ConBTCustNum = Customer1.CustNum
group by [Project1].[ProjectID],
	[SubQuery1].[Customer_Name]
    */

    Select top (10) *
    From erp.[InvcDtl]
    Where company = 'solar'
    and OrderNum like '%4000011%'
    --has a ChangeDate and ChangeTime
    
    Select top (10) *
    From erp.[Invchead]
    Where company = 'solar'
    order by Changedate desc, changetime desc
    and OrderNum like '%4000011%'
    --has a changeDate and change Time

   Select  Count (*)
     From erp.[Invchead]
        Select  Count (*)
    From erp.[InvcDtl]