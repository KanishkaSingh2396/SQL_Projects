
Use [AdventureWorksDW2019];
go 

select 
		e.[EmployeeKey], 
		e.[FirstName], 
		e.[LastName], 
		e.[Title], 
		e.[HireDate], 
		e.[DepartmentName], 
		s.[SalesAmount],
		CUME_DIST() over(partition by e.[DepartmentName] order by s.[SalesAmount]) as CumulativeSales
from [dbo].[DimEmployee] e
		inner join  [dbo].[FactResellerSales] s
			on s.[EmployeeKey] = e.[EmployeeKey]

--SQL first value
select 
		e.[EmployeeKey], 
		e.[FirstName], 
		e.[LastName], 
		e.[Title], 
		e.[HireDate], 
		e.[DepartmentName], 
		s.[SalesAmount],
		FIRST_VALUE (e.[FirstName]) over( partition by e.[Title] order by s.[SalesAmount] desc) as max_sales_emp
		

from [dbo].[DimEmployee] e
		join  [dbo].[FactResellerSales] s
			on e.[EmployeeKey] = s.[EmployeeKey]

--last value
select 
		e.[EmployeeKey], 
		e.[FirstName], 
		e.[LastName], 
		e.[Title], 
		e.[HireDate], 
		e.[DepartmentName], 
		s.[SalesAmount],
		LAST_VALUE(e.[FirstName]) over( partition by e.[Title] order by s.[SalesAmount] asc) as least_sales_emp
		
from [dbo].[DimEmployee] e
		join  [dbo].[FactResellerSales] s
			on e.[EmployeeKey] = s.[EmployeeKey]

--LAG
select 
		e.[EmployeeKey], 
		e.[FirstName] + ' ' + e.[LastName], 
		e.[Title], 
		e.[HireDate], 
		e.[DepartmentName], 
		s.[SalesAmount],
		LAG(s.[SalesAmount], 3,100) over( partition by e.[Title] order by s.[SalesAmount]desc) as sales_comparison
		
from [dbo].[DimEmployee] e
		join  [dbo].[FactResellerSales] s
			on e.[EmployeeKey] = s.[EmployeeKey]

--lead
select 
		e.[EmployeeKey], 
		e.[FirstName] + ' ' + e.[LastName], 
		e.[Title], 
		e.[HireDate], 
		e.[DepartmentName], 
		s.[SalesAmount],
		LEAD(s.[SalesAmount], 1,50) over( partition by e.[Title] order by s.[SalesAmount]desc) as sales_comparison
		
from [dbo].[DimEmployee] e
		join  [dbo].[FactResellerSales] s
			on e.[EmployeeKey] = s.[EmployeeKey]

--percentile_cont
select 
		e.[EmployeeKey], 
		e.[FirstName] + ' ' + e.[LastName], 
		e.[Title], 
		e.[HireDate], 
		e.[DepartmentName], 
		s.[SalesAmount],
		PERCENTILE_CONT(0) WITHIN GROUP (ORDER BY s.[SalesAmount]desc) over( partition by e.[Title]) as percentile,
		PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY s.[SalesAmount]desc) over( partition by e.[Title]) as percentile1,
		PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY s.[SalesAmount]desc) over( partition by e.[Title]) as percentile2,
		PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY s.[SalesAmount]desc) over( partition by e.[Title]) as percentile3,
		PERCENTILE_CONT(1) WITHIN GROUP (ORDER BY s.[SalesAmount]desc) over( partition by e.[Title]) as percentile4
		
from [dbo].[DimEmployee] e
		join  [dbo].[FactResellerSales] s
			on e.[EmployeeKey] = s.[EmployeeKey]

---percentile_discs
select 
		e.[EmployeeKey], 
		e.[FirstName] + ' ' + e.[LastName], 
		e.[Title], 
		e.[HireDate], 
		e.[DepartmentName], 
		s.[SalesAmount],
		PERCENTILE_DISC(0) WITHIN GROUP (ORDER BY s.[SalesAmount]desc) over( partition by e.[Title]) as percentile,
		PERCENTILE_DISC(0.25) WITHIN GROUP (ORDER BY s.[SalesAmount]desc) over( partition by e.[Title]) as percentile1,
		PERCENTILE_DISC(0.5) WITHIN GROUP (ORDER BY s.[SalesAmount]desc) over( partition by e.[Title]) as percentile2,
		PERCENTILE_DISC(0.75) WITHIN GROUP (ORDER BY s.[SalesAmount]desc) over( partition by e.[Title]) as percentile3,
		PERCENTILE_DISC(1) WITHIN GROUP (ORDER BY s.[SalesAmount]desc) over( partition by e.[Title]) as percentile4
		
from [dbo].[DimEmployee] e
		join  [dbo].[FactResellerSales] s
			on e.[EmployeeKey] = s.[EmployeeKey]

--percentage rank
Select 
		e.[EmployeeKey], 
		e.[FirstName] + ' ' + e.[LastName], 
		e.[Title], 
		e.[HireDate], 
		e.[DepartmentName], 
		s.[SalesAmount],
		PERCENT_RANK() over(PARTITION by e.[Title] ORDER BY s.[SalesAmount]desc) as PER_RANK
		
from [dbo].[DimEmployee] e
		join  [dbo].[FactResellerSales] s
			on e.[EmployeeKey] = s.[EmployeeKey]