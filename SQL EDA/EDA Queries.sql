Select * from blinkit_data;

----------------------------------------KPIs------------------------------------------------

--Total Sales in Millions--

Select 
	concat(cast(Sum(Total_Sales)/1000000 as decimal(10,2)),'M') as Total_Sales_Millions
from blinkit_data;

-- Average sales --

Select 
	cast(avg(Total_Sales) as decimal(10,1)) as Avg_Sales
from blinkit_data;

-- No of Items--
SELECT 
	COUNT(*) AS No_of_orders
FROM blinkit_data;

-- Average Ratings --
Select
	cast(Avg(rating) as decimal(10,1)) as Avg_Rating
from blinkit_data;

--------------------------------------Granular Requirements -----------------------------------------

----------Total Sales by Fat Content-----------
Select 
	Item_Fat_Content,
	Round(Sum(Total_Sales),2) as Total_Sales
from blinkit_data
group by Item_Fat_Content;

-- Other parameters by Fat Content --
Select 
	Item_Fat_Content,
	Round(Sum(Total_Sales),2) as Total_Sales,
	cast (avg(Total_Sales) as decimal(10,1)) as Avg_Sales,
	COUNT(*) AS No_of_orders,
	cast (Avg(rating) as decimal(10,1)) as Avg_Rating
from blinkit_data
group by Item_Fat_Content;

---------Total Sales by Item Type ---------------------
Select 
	Item_Type,
	Round(Sum(Total_Sales),2) as Total_Sales
from blinkit_data
group by Item_Type
order by Total_Sales desc;

-- Other parameters by Item Type --

Select 
	Item_Type,
	Round(Sum(Total_Sales),2) as Total_Sales,
	cast (avg(Total_Sales) as decimal(10,1)) as Avg_Sales,
	COUNT(*) AS No_of_orders,
	cast (Avg(rating) as decimal(10,2)) as Avg_Rating
from blinkit_data
group by Item_Type
order by Total_Sales desc;


-------------------Outlet Total Sales by Fat Content--------------------
SELECT Outlet_Location_Type, 
       ISNULL([Low Fat], 0) AS Low_Fat, 
       ISNULL([Regular], 0) AS Regular
FROM 
(
    SELECT Outlet_Location_Type, Item_Fat_Content, 
           CAST(SUM(Total_Sales) AS DECIMAL(10,2)) AS Total_Sales
    FROM blinkit_data
    GROUP BY Outlet_Location_Type, Item_Fat_Content
) AS SourceTable
PIVOT 
(
    Sum(Total_Sales)
    FOR Item_Fat_Content IN ([Low Fat], [Regular])
) AS PivotTable
ORDER BY Outlet_Location_Type;  

----------------------Total Sales by Outlet Establishment Year----------------------
Select	
	Outlet_Establishment_Year,
	cast(Sum(Total_Sales) as decimal(10,2)) as Total_Sales
From blinkit_data
group by Outlet_Establishment_Year
order by Outlet_Establishment_Year;

--Other parameters by establishment year--
Select	
	Outlet_Establishment_Year,
	cast(Sum(Total_Sales) as decimal(10,2)) as Total_Sales,
	cast (avg(Total_Sales) as decimal(10,1)) as Avg_Sales,
	COUNT(*) AS No_of_orders,
	cast (Avg(rating) as decimal(10,2)) as Avg_Rating
From blinkit_data
group by Outlet_Establishment_Year
order by Outlet_Establishment_Year;


---------Percentage of Sales by Outlet Size-------------
select
	Outlet_Size,
	round(sum(Total_Sales),2) as Total_Sales,
	round(Sum(Total_Sales)*100/sum(sum(Total_Sales)) over(),2)as Sales_Percentage
from blinkit_data
group by outlet_size
order by Sales_Percentage desc;

---------Sales and other parameters by Outlet Location-----------------
SELECT 
	Outlet_Location_Type,
	cast(Sum(Total_Sales) as decimal(10,2)) as Total_Sales,
	round(Sum(Total_Sales)*100/sum(sum(Total_Sales)) over(),2)as Sales_Percentage,
	cast (avg(Total_Sales) as decimal(10,1)) as Avg_Sales,
	COUNT(*) AS No_of_orders,
	cast (Avg(rating) as decimal(10,2)) as Avg_Rating
FROM blinkit_data
GROUP BY Outlet_Location_Type
ORDER BY Total_Sales DESC

------------Sales and Other parameters by Outlet Type---------------
SELECT Outlet_Type, 
CAST(SUM(Total_Sales) AS DECIMAL(10,2)) AS Total_Sales,
		CAST(AVG(Total_Sales) AS DECIMAL(10,0)) AS Avg_Sales,
		COUNT(*) AS No_Of_Items,
		CAST(AVG(Rating) AS DECIMAL(10,2)) AS Avg_Rating,
		CAST(AVG(Item_Visibility) AS DECIMAL(10,2)) AS Item_Visibility
FROM blinkit_data
GROUP BY Outlet_Type
ORDER BY Total_Sales DESC

