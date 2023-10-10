--This table gives Resource Group Labor and Burdon Rates
Select Top (30) *
FROM erp.ResourceGroup
Where Company = 'SOLAR'


---This gives us the Burden Rates for Labor
Select Top (30) *
FROM erp.CostBurden
Where Company = 'SOLAR'