--Ranking Functions
--Rank

Select 
		e.[EmployeeKey], 
		e.[FirstName] + ' ' + e.[LastName], 
		e.[Title], 
		e.[HireDate], 
		e.[DepartmentName], 
		s.[SalesAmount],
		RANK() over(PARTITION by e.[Title] ORDER BY s.[SalesAmount]desc) as PER_RANK
		
from [dbo].[DimEmployee] e
		join  [dbo].[FactResellerSales] s
			on e.[EmployeeKey] = s.[EmployeeKey]

--dense rank
Select 
		e.[EmployeeKey], 
		e.[FirstName] + ' ' + e.[LastName], 
		e.[Title], 
		e.[HireDate], 
		e.[DepartmentName], 
		s.[SalesAmount],
		DENSE_RANK() over(PARTITION by e.[Title] ORDER BY s.[SalesAmount]desc) as PER_RANK
		
from [dbo].[DimEmployee] e
		join  [dbo].[FactResellerSales] s
			on e.[EmployeeKey] = s.[EmployeeKey]

--NTILE
Select 
		e.[EmployeeKey], 
		e.[FirstName] + ' ' + e.[LastName], 
		e.[Title], 
		e.[HireDate], 
		e.[DepartmentName], 
		s.[SalesAmount],
		NTILE(2) over(PARTITION by e.[Title] ORDER BY s.[SalesAmount]desc) as PER_RANK
		
from [dbo].[DimEmployee] e
		join  [dbo].[FactResellerSales] s
			on e.[EmployeeKey] = s.[EmployeeKey]

--ROW_NUMBER
Select 
		e.[EmployeeKey], 
		e.[FirstName] + ' ' + e.[LastName], 
		e.[Title], 
		e.[HireDate], 
		e.[DepartmentName], 
		s.[SalesAmount],
		ROW_NUMBER() over(PARTITION by e.[Title] ORDER BY s.[SalesAmount]desc) as PER_RANK
		
from [dbo].[DimEmployee] e
		join  [dbo].[FactResellerSales] s
			on e.[EmployeeKey] = s.[EmployeeKey]

