SELECT Distinct 
      --SegmentNbr as SegmentTypeCode,
      SegmentCode as DepartmentNumber,
      SegmentName as DepartmentName,
      SegmentDesc as DepartmentDescription,
      SegmentAbbrev,
      ActiveFlag
 FROM Erp.COASegValues
    WHERE 1=1
    AND Company = 'Solar' 
    and SegmentNbr = 2


    


