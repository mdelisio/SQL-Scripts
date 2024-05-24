

---Epicor ERPDB


SELECT *
  FROM [ERPDB].[Erp].[PartBin]
  Where Company = 'solar'
  and Partnum = 'D18-1'

--ODS Delta History

  SELECT 
  Company,
  Partnum,
  Binnum,
  onhandqty,
  Actiontype,
  ODSModifyUTCDateTime
  FROM ODS_ERPDB.Erp_PartBinDeltaHistory
  Where Company = 'solar'
  and Partnum = 'D18-1'
  --and binnum = 'S0/P77'
  order by ODSModifyUTCDateTime dESC
    and Partnum = 'D18-1'

  Select Distinct (CAST(ODSModifyUTCDateTime as DATE))
   FROM ODS_ERPDB.Erp_PartDeltaHistory
  WHERE 1=1
  --Where company = 'solar'     
  --and Partnum = 'D18-1'
  AND ODSModifyUTCDateTime BETWEEN '2023-10-01' AND '2023-10-27'
         order by ODSModifyUTCDateTime dESC

-- ODS PartBin VIew that excludes delets
  SELECT 
  
  FROM ODS_ERPDB.Erp_PartBinBASE
  Where Company = 'solar'
  and Partnum = 'D18-1'
  and binnum = 'S0/P77'


  SELECT *
  FROM ODS_ERPDB.Erp_PartBinDeltaHistory
  Where SysRowID IN ('30018be4-28c1-4d36-814d-45be40eba0a6','a1b1c3f4-29b1-46a6-b179-e98c30197bab')


SELECT *
  FROM ODS_ERPDB.Erp_PartBinDeltaHistory
 WHERE ActionType = 'D'
 order by ODSModifyUTCDateTime dESC


 Select Count (*)
  FROM ODS_ERPDB.Erp_PartTranBASE

   Select *
  FROM ODS_ERPDB.Erp_PartTranDeltaHistory
   WHERE ActionType = 'U'

