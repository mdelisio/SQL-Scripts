USE [RBI]
GO
/****** Object:  StoredProcedure [dbo].[InvoiceService_GetAPInvHeadByVendorInvoice]    Script Date: 5/19/2022 1:50:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Malinda Perera
-- Create date: 2018-01-17
-- Description:	Get Account Payable Invoice Head By Invoice Number
-- =============================================
ALTER PROCEDURE [dbo].[InvoiceService_GetAPInvHeadByVendorInvoice]
	
	@company nvarchar(8),
	@vendorNumber int,
	@invoiceNumber nvarchar(20)
AS
BEGIN
	SET NOCOUNT ON;

	SELECT 
		ap.Company,OpenPayable,ap.VendorNum,ap.InvoiceNum,InvoiceDate,aps.PayAmount as PayAmounts,InvoiceAmt,
		InvoiceVendorAmt,ApplyDate
	FROM 
		[ERPDB].Erp.APInvHed ap
		INNER JOIN [ERPDB].[ERp].APInvSched aps
		ON aps.COmpany = ap.Company AND aps.INvoiceNUm = ap.InvoiceNum AND aps.VendorNum = ap.VendorNUm
	WHERE 
		ap.Company = @company AND
		ap.VendorNum = @vendorNumber AND
		ap.InvoiceNum = @invoiceNumber
END
