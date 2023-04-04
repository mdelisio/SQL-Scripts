SELECT top (1000) a.*, cl.*
FROM
(
    SELECT JobMtl.*,
    CONCAT(JobNum,'~',AssemblySeq,'~',MtlSeq) as KeyConcat
    FROM [ERPDB].[Erp].[JobMtl]
) a
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
 WHERE JobNum like '1970070-5-1'
 and Company = 'Solar'