SELECT TOP (1000) [Company]
      ,[JobComplete]
      ,[JobNum]
      ,[AssemblySeq]
      ,[PartNum]
      ,[Description]
      ,[QtyPer]
      ,[IUM]
      ,[RequiredQty]
      ,[StartDate]
      ,[DueDate]
      ,[IssuedQty]
      ,[IssuedComplete]
    FROM [ERPDB].[Erp].[JobAsmbl]
    where jobnum like '2170100%'
  and (company = 'rbmi' or company = 'solar')
  order by DueDate Desc
