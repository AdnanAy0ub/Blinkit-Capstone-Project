use blinkitdb;

select * from blinkit_data;

select count(*) from blinkit_data; -- Includes Nulls

select count(Item_Weight) from blinkit_data; -- Neglects null values

----------------------------------Data Cleaning--------------------------------------------------

--- Standardise data in column 1---
select distinct (item_fat_Content) from blinkit_data; 

update blinkit_data
Set Item_Fat_Content = 
Case 
	when Item_Fat_Content IN ('LF','low fat') Then 'Low Fat'
	when Item_Fat_Content = 'reg' then 'Regular'
Else Item_Fat_Content 
End

--- re-run the previous distinct query to check if the data is  standardised ---




