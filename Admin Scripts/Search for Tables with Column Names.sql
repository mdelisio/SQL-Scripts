
SELECT      COLUMN_NAME AS 'ColumnName'
            ,TABLE_NAME AS  'TableName'
            ,TABLE_SCHEMA as 'SchemaName'
FROM        INFORMATION_SCHEMA.COLUMNS
WHERE       COLUMN_NAME LIKE 'ProjectID%'
ORDER BY    TableName
            ,ColumnName;

            
SELECT      COLUMN_NAME AS 'ColumnName'
            ,TABLE_NAME AS  'TableName'
            ,TABLE_SCHEMA as 'SchemaName'
FROM        INFORMATION_SCHEMA.COLUMNS
WHERE       COLUMN_NAME LIKE 'Vendor%'
and         Table_Schema = 'ODS_ERPDB'
ORDER BY   ColumnName,TableName

SELECT      COLUMN_NAME AS 'ColumnName'
            ,TABLE_NAME AS  'TableName'
            ,TABLE_SCHEMA as 'SchemaName'
FROM        INFORMATION_SCHEMA.COLUMNS
WHERE       COLUMN_NAME LIKE 'Jobseq%'
--AND         TABLE_Name LIke '%PO%'
and         Table_Schema = 'ODS_ERPDB'
ORDER BY    ColumnName,TableName







 


            

