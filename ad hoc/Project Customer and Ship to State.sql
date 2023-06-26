SELECT [ProjectDimKey]
      ,[ProjectID]
      ,[CompanyID]
      ,[ProjectName]
      ,[ProjectCustomerNumber]
      ,[ProjectCustomerName]
      ,[ProjectShipToState]
   FROM [EDW].[ProjectDim]
Where CompanyID = 'solar'
  