SELECT
	SourceServerEnvironmentVariable
	,SourceDatabase
	,SourceSchema
	,SourceTable
    ,ExecutionGroupName
FROM
	Config.ODSControl_Tables
WHERE 1=1
	AND ExecutionGroupName = 'HighFrequency'
	AND SourceServerEnvironmentVariable = 'DS_EPICOR'
	AND ChangeTrackingMethod = 'ChangeTracking'
	AND IsTableActive = 1