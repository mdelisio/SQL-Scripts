select 
	[Vendor].[VendorID] as [Vendor_VendorID],
	[Vendor].[Name] as [Vendor_Name],
	[RcvHead].[PONum] as [RcvHead_PONum],
	[RcvHead].[PackSlip] as [RcvHead_PackSlip],
	[RcvDtl].[PackLine] as [RcvDtl_PackLine],
	[RcvDtl].[PONum] as [RcvDtl_PONum],
	[RcvDtl].[POLine] as [RcvDtl_POLine],
	[RcvDtl].[PORelNum] as [RcvDtl_PORelNum],
	[RcvDtl].[JobNum] as [RcvDtl_JobNum],
	[RcvDtl].[AssemblySeq] as [RcvDtl_AssemblySeq],
	[RcvDtl].[JobSeq] as [RcvDtl_JobSeq],
	[RcvDtl].[JobSeqType] as [RcvDtl_JobSeqType],
	[RcvHead].[Invoiced] as [RcvHead_Invoiced],
	[RcvDtl].[InvoiceNum] as [RcvDtl_InvoiceNum],
	[RcvDtl].[InvoiceLine] as [RcvDtl_InvoiceLine],
	[RcvDtl].[PartNum] as [RcvDtl_PartNum],
	[RcvDtl].[PartDescription] as [RcvDtl_PartDescription],
	[RcvDtl].[VendorQty] as [RcvDtl_VendorQty],
	[RcvDtl].[PUM] as [RcvDtl_PUM],
	[RcvDtl].[OurQty] as [RcvDtl_OurQty],
	[RcvDtl].[IUM] as [RcvDtl_IUM],
	[RcvDtl].[OurUnitCost] as [RcvDtl_OurUnitCost],
	[RcvDtl].[Invoiced] as [RcvDtl_Invoiced],
	[RcvDtl].[ReceivedComplete] as [RcvDtl_ReceivedComplete],
	[RcvDtl].[IssuedComplete] as [RcvDtl_IssuedComplete],
	[RcvDtl].[ArrivedDate] as [RcvDtl_ArrivedDate],
	[RcvDtl].[ReceiptDate] as [RcvDtl_ReceiptDate],
	[RcvHead].[EntryPerson] as [RcvHead_EntryPerson],
	[Vendor].[Inactive] as [Vendor_Inactive],
	[Vendor].[Company] as [Vendor_Company],
	[Vendor].[Address1] as [Vendor_Address1],
	[Vendor].[Address2] as [Vendor_Address2],
	[Vendor].[Address3] as [Vendor_Address3],
	[Vendor].[City] as [Vendor_City],
	[Vendor].[State] as [Vendor_State],
	[Vendor].[ZIP] as [Vendor_ZIP],
	[Vendor].[Country] as [Vendor_Country],
	[Vendor].[TaxPayerID] as [Vendor_TaxPayerID],
	[Vendor].[TermsCode] as [Vendor_TermsCode],
	[Vendor].[GroupCode] as [Vendor_GroupCode],
	[RcvDtl].[WareHouseCode] as [RcvDtl_WareHouseCode],
	[RcvDtl].[BinNum] as [RcvDtl_BinNum],
	[RcvDtl].[ReceiptType] as [RcvDtl_ReceiptType],
	[RcvDtl].[ReceivedTo] as [RcvDtl_ReceivedTo]
from Erp.RcvHead as RcvHead
inner join Erp.RcvDtl as RcvDtl on 
	RcvHead.Company = RcvDtl.Company
	and RcvHead.PackSlip = RcvDtl.PackSlip
inner join Erp.Vendor as Vendor on 
	RcvHead.Company = Vendor.Company
	and RcvHead.VendorNum = Vendor.VendorNum
Where RcvDtl.company = 'rbmi'
and Rcvdtl.ReceiptDate >= '2021-01-01'
order by RcvDtl.Company Desc, RcvHead.PackSlip Desc, Vendor.VendorID Desc, RcvDtl.PackLine
