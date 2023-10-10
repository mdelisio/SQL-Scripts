
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
WHERE       COLUMN_NAME LIKE 'resource%'
and         Table_Schema = 'erp'
ORDER BY    ColumnName




 


            

