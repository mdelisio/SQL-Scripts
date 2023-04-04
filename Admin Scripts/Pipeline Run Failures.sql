SELECT TOP (1000) [SourceToADLSPipelineRunLogsId]
      ,[DataFactory_Name]
      ,[Pipeline_Name]
      ,[RunId]
      ,[SourceToTargetType]
      ,[SourceExtractMethod]
      ,[SourceServerName]
      ,[SourceDatabaseName]
      ,[SourceSchemaName]
      ,[SourceTableName]
      ,[TargetDataLakeContainerName]
      ,[TargetDirectoryName]
      ,[TargetFileName]
      ,[TriggerType]
      ,[TriggerId]
      ,[TriggerName]
      ,[TriggerTimeEST]
      ,[RowsCopied]
      ,[RowsRead]
      ,[No_ParallelCopies]
      ,[copyDuration_in_secs]
      ,[effectiveIntegrationRuntime]
      ,[Source_Type]
      ,[Sink_Type]
      ,[Execution_Status]
      ,[CopyActivity_Start_Time_EST]
      ,[CopyActivity_End_Time_EST]
      ,[CopyActivity_queuingDuration_in_secs]
      ,[CopyActivity_preCopyScriptDuration_in_secs]
      ,[CopyActivity_transferDuration_in_secs]
      ,[ErrorMessage]
  FROM [logs].[SourceToADLSPipelineRunLogs]
    Where Execution_Status = 'Failed'
  Order by CopyActivity_End_Time_EST Desc
