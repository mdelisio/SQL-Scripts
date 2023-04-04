SELECT TOP (1000) [ControlTable_IngestId]
      ,[PipelineTriggerName]
      ,[PipelineLastRunDateTimeEST]
      ,[DataSourceName]
      ,[SourceServerName]
      ,[SourceDatabaseName]
      ,[SourceSchemaName]
      ,[SourceTableName]
      ,[SourceTablePK]
      ,[SourceKeyColumnList]
      ,[SourceTableColumnsTrack]
      ,[Type2Query]
      ,[SourceExtractMethod]
      ,[SourceExtractSQL]
      ,[DeltaUpdateWatermarkColumnName]
      ,[DeltaLastWatermarkDateTimeEST]
      ,[DataLakeContainer]
      ,[DataLakeFolder]
      ,[DataLakeFile]
      ,[TargetDBSchemaName]
      ,[TargetDBTableName]
      ,[IsActiveFlag]
      ,[TargetDBName]
      ,[PrecopyScript]
      ,[ProcessName]
      ,[WhereClause]
  FROM [etl].[ControlTable_Ingest]
  Order by IsActiveFlag DESC