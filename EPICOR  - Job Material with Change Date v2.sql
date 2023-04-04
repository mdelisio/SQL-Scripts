SELECT top (1000) a.*, cl.*, jh.*
FROM
(
    SELECT JobMtl.*,
    CONCAT(JobNum,'~',AssemblySeq,'~',MtlSeq) as KeyConcat
    FROM [ERPDB].[Erp].[JobMtl]
) a

LEFT JOIN 
(select 
	jh.[Company] 
	jh.[ClosedDate] 
	jh.[JobNum] 
	jh.[CreateDate] 
    From [ERPDB].[Erp].[JobHead]
 ) as jh
	on a.Company = jh.Company and a.JobNum = jh.JobNum

LEFT JOIN
(
    Select
    DateStampedON,
    Key1,
    Key2,
    LogText
    From [ERPDB].[Ice].[ChgLog] 
) cl
  ON a.JobNum=cl.Key1 and a.KeyConcat=cl.Key2

 -- WHERE DateStampedOn >= '06-01-2022'
-- WHERE JobNum like '1970070-5-1'
-- and Company = 'Solar'