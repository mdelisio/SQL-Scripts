Select * 
from ERPDB.etl.vwJobMtlChange
Where ProjectID = '2234009'
Order by ReqDate desc;

Select * 
from ERPDB.erp.JobAsmbl
Where jobnum like '2234009%'
Order by DueDate Desc;

Select * 
from ERPDB.erp.Jobhead
Where jobnum like '2234009%';


Select * 
from ERPDB.etl.vwLaborDtl
Where Company = 'rbmi'
and ProjectID = '2234009'