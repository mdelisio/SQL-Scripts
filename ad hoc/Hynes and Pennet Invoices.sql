SELECT TOP (1000) ap.[Company]
      ,ap.[VendorNum]
      ,v.name
      ,[InvoiceNum]
      ,[InvoiceLine]
      ,[LineType]
      ,[Description]
      ,[VenPartNum]
      ,[GlbCompany]
      ,[GlbVendorNum]
      ,[GlbInvoiceNum]
      ,[GlbInvoiceLine]
      ,[MultiCompany]

  FROM [ERPDB].[Erp].[APInvDtl] as ap
  Left Join  [ERPDB].[Erp].[Vendor] as v
  on ap.VendorNum = v.VendorNum and ap.company = v.Company
  WHERE ap.Company = 'Solar'
  AND (ap.VendorNum = '2409' or ap.VendorNum = '2272')