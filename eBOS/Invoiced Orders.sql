Select 
ih.company,
oh.Divsion_c as Divsion,
ih.invoicenum,
ih.InvoiceDate,
ih.applydate,
ih.ordernum,
ih.InvoiceAmt
From erp.InvcHead Ih
Left Join dbo.Orderhed oh
    ON ih.Company = oh.company
    and oh.OrderNum = ih.OrderNum
Where ih.Company = 'solar'
and oh.Division_c = 6