 -- Creaeed for inital JobMtl Table for ETL with latest Change Date on Job Assembly Seq.  Changed and corrected on 7/14/22

ALTER VIEW [etl].[vwJobMtlChange] AS

SELECT jm.*, cl.DateStampedOn, cc.Calculated_ChangeDate,
 (case when
            cc.Calculated_ChangeDate >= cl.DateStampedOn
            then cc.Calculated_ChangeDate
            else 
            cl.DateStampedON
            end) as Latest_ChangeDate
,Dateadd(second, 00, cast(
    (case when
            cc.Calculated_ChangeDate >= cl.DateStampedOn
            then cc.Calculated_ChangeDate
            else 
            cl.DateStampedON
            end)as Datetime)) as Latest_ChangeDateTime
FROM
(
    SELECT JobMtl.*,
    CONCAT(JobNum,'~',AssemblySeq,'~',MtlSeq) as ForeignKey2
    FROM [ERPDB].[Erp].[JobMtl]
) jm

-- Get the DateStampedOn from the ChangeLog
LEFT JOIN
(
Select *
From
    (Select DateStampedOn,
            Key1,
            Key2,
            LogText,
            ROW_NUMBER() OVER(Partition by Key2 Order by DateStampedON Desc) rn
        From [ERPDB].[Ice].[ChgLog] 
    ) a
    Where rn=1 
) cl
ON jm.JobNum=cl.Key1 and jm.ForeignKey2=cl.Key2


--get the calculated change date from PartTran and Job Head Tables 
Left Join
(
Select  *
From 
    (Select 
        f.Company,
        f.JobNum,
        f.AssemblySeq,
        f.JobSeq,
        f.PartNum,
        f.TranDate,
        f.CreateDate,
        f.CloseDate,
        f.ForeignKey2,
        f.Calculated_ChangeDate,
        ROW_NUMBER() OVER(PARTITION By ForeignKey2 ORDER BY f.Calculated_ChangeDate DESC) rn
    FROM
        (SELECT 
            pt.Company as Company, 
            pt.JobNum as JobNum,
            pt.AssemblySeq as AssemblySeq,
            pt.JobSeq as JobSeq,
            pt.TranDate as TranDate,
            pt.PartNum as PartNum,
            jh.CreateDate as CreateDate,
            jh.ClosedDate as CloseDate,
            pt.ForeignKey2 as ForeignKey2,
            (case when
            pt.TranDate >= jh.CreateDate
            then
            pt.TranDate
            when
            jh.CreateDate >= jh.ClosedDate
            then
            jh.CreateDate
            else
            jh.ClosedDate
            end) as Calculated_ChangeDate
                FROM
                (SELECT
                    Company,
                    JobNum,
                    AssemblySeq,
                    JobSeq,
                    TranDate,
                    PartNum,
                    CONCAT(JobNum,'~',AssemblySeq,'~',JobSeq) as ForeignKey2
                    FROM [ERPDB].[Erp].[PartTran]
                ) as pt
                Left Join
                (SELECT 
                    Company, 
                    ClosedDate, 
                    JobNum,
                    CreateDate 
                    FROM [ERPDB].[Erp].[JobHead]
                ) as jh
                    on pt.Company = jh.Company AND pt.JobNum = jh.JobNum
        ) f 
    ) b
    where rn = 1
) cc
on jm.ForeignKey2 = cc.ForeignKey2