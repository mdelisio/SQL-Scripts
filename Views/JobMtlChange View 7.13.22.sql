--ALTER VIEW [etl].[vwJobMtlChange] AS
 -- Creaeed for inital JobMtl Table ETL.  Changed and corrected on 7/14/22
SELECT a.*, cl.*, jh.*, pt.*,
(case when
 pt.pt_TranDate >= jh.jh_CreateDate
 then
 pt.pt_TranDate
 when
 jh.jh_CreateDate >= jh.jh_ClosedDate
 then
 jh.jh_CreateDate
 else
 jh.jh_ClosedDate
 end) as [Calculated_ChangeDate]
FROM
(
    SELECT JobMtl.*,
    CONCAT(JobNum,'~',AssemblySeq,'~',MtlSeq) as ForeignKey2
    FROM [ERPDB].[Erp].[JobMtl]
) a

LEFT JOIN 
(SELECT 
	Company as jh_Company, 
    ClosedDate as jh_ClosedDate, 
	JobNum as jh_JobNum,
	CreateDate as jh_CreateDate
    FROM [ERPDB].[Erp].[JobHead]
 ) as jh
	on a.Company = jh.jh_Company and a.JobNum = jh.jh_JobNum

LEFT JOIN
(SELECT
    Company as pt_Company,
    JobNum as pt_JobNum,
    AssemblySeq as pt_AssemblySeq,
    JobSeq as pt_JobSeq,
    TranDate as pt_TranDate,
    PartNum as pt_PartNum
    FROM [ERPDB].[Erp].[PartTran]
) as pt
    on a.Company = pt.pt_Company AND a.JobNum = pt.pt_JobNum AND a.AssemblySeq = pt.pt_AssemblySeq AND a.PartNum = pt.pt_PartNum

LEFT JOIN
(
    Select
    DateStampedON,
    Key1,
    Key2,
    LogText
    From [ERPDB].[Ice].[ChgLog] 
) cl
  ON a.JobNum=cl.Key1 and a.ForeignKey2=cl.Key2