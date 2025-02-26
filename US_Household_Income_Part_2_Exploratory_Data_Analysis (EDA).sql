

-- STEP # 0 : Run the table to start identifying columns to be analyzed

SELECT *
FROM  us_household_income ;


-- STEP # 1 : Find the Top 5 states with the largest Land area in the U.S

SELECT State_Name , SUM(ALand), SUM(AWater)
FROM us_household_income 
GROUP BY State_Name
ORDER by SUM(ALand) DESC 
LIMIT 5 ;

-- Results : Top 5 states by land area are :
-- Texas, California , Missouri , Minnesota & Illinois

-- STEP # 2 : Find the  Top 5 states with the largest Water area in the U.S

SELECT State_Name , SUM(AWater), SUM(ALand)
FROM us_household_income 
GROUP BY State_Name
ORDER by SUM(AWater) DESC
LIMIT 5 ;

-- Results : Top 5 states by Water area are :
-- Michigain , Texas , Florida , Minnesota & Louisiana 

-- STEP # 3 : We Join the two tables ( Household Income & Household Income Statistics )
--  Goal is to find out the rows from Household income table that have recorded Statistics 
-- We first use a Right Join to identify rows Household Income Table that have no recorded statistics


SELECT COUNT(*) 
FROM us_household_income ui
RIGHT JOIN us_household_income_statistics uis
	ON ui.id = uis.id
WHERE ui.id IS NULL ;

-- Results :  240 rows in the Household Income Table that have no recorded statistics in 
-- the Household Income statistics table
-- Now, we USE The inner JOIN to identify from Household income table that have recorded Statistics 

SELECT * 
FROM us_household_income ui
INNER JOIN us_household_income_statistics uis
	ON ui.id = uis.id
 ;
 
 -- Results : On First glance, data indicates rows with un-recorded statistics parameters 
 -- with zero values (MEAN, MEdian , Stdev & sum_w )
 -- Therefore, we filter out these rows to ensure accurate data analysis using the following :
SELECT * 
FROM us_household_income ui
INNER JOIN us_household_income_statistics uis
	ON ui.id = uis.id
WHERE Mean <> 0
 ;
 
 -- STEP # 4 : We analyze the Income statistics by State
 -- Methodology : We will adjust the last query as follows :
 
 -- First, We Identify Top 5 States by Average Income 
 
SELECT ui.State_Name , 
		ROUND(Avg(Mean),1) AS Average_Income, 
        ROUND (Avg(Median),1) AS Median_income 
FROM us_household_income ui
INNER JOIN us_household_income_statistics uis
	ON ui.id = uis.id
WHERE Mean <> 0
GROUP BY ui.State_Name
ORDER BY Average_income DESC
LIMIT 5
 ;
 
 -- Results : Top 5 States are :
 -- District of Columbia , Connecticut , New Jersey, Maryland & Massachusetts
 
 
-- Secondly, We Identify Bottom 5 States by Average Income 

SELECT ui.State_Name , 
		ROUND(Avg(Mean),1) AS Average_Income, 
        ROUND (Avg(Median),1) AS Median_income 
FROM us_household_income ui
INNER JOIN us_household_income_statistics uis
	ON ui.id = uis.id
WHERE Mean <> 0
GROUP BY ui.State_Name
ORDER BY Average_income ASC
LIMIT 5
 ;
 
 -- Results : Bottom  5 States are :
 -- Puerto Rico, Mississippi ,Arkansas , West Virginia & Alabama
 
 -- STEP # 5 : Analyze the income distribution of a Household by the Type of area 
 
SELECT Type , 
 		COUNT(Type) AS Number_of_Households,
        ROUND( (COUNT(Type) * 100.0) / SUM(COUNT(Type)) OVER (), 2) AS Percentage_of_Households,
		ROUND(Avg(Mean),1) AS Average_Income, 
        ROUND (Avg(Median),1) AS Median_income 
FROM us_household_income ui
INNER JOIN us_household_income_statistics uis
	ON ui.id = uis.id
WHERE Mean <> 0
GROUP BY Type
ORDER BY Average_income DESC
 ;
 
 -- Results Found are as follows :
 -- First, 90.5% of Households in the US are 'Track' areas that have an average income of around $68.1K
 -- And a Median Income of around $86.9K
 -- Secondly, Municipalities have the highest average income of $83K but only one data point was collected
 -- Furthermore, Communities have the lowest average incomes of  &  median Salaries 
 -- of $18.9K  & $ 14.1K respectively
 
 -- STEP # 6 : We Analyze the Highest & Lowest Earning Cities in the United States
 
 -- First, we identify the top 5 earning cities in the United States
 
SELECT ui.State_Name , 
        City,
		ROUND(Avg(Mean),1) AS Average_Income, 
        ROUND (Avg(Median),1) AS Median_income 
FROM us_household_income ui
INNER JOIN us_household_income_statistics uis
	ON ui.id = uis.id
WHERE Mean <> 0
GROUP BY  ui.State_Name, City
ORDER BY Average_income DESC
Limit 5 ;
 ;
 
-- Results: Top 5 Cities by Average Income are :
-- Delta Junction in Alaska, Short Hills in New Jersey , Narberth in Pennsylvania ,
-- Chevy Chase in Maryland, and Darien in Conneccticut 
-- The Average Incomes are between $192.8k & $242.8 k in those top cities 

-- Secondly, we identify the lowest 5 earning cities in the United States

SELECT ui.State_Name , 
        City,
		ROUND(Avg(Mean),1) AS Average_Income, 
        ROUND (Avg(Median),1) AS Median_income 
FROM us_household_income ui
INNER JOIN us_household_income_statistics uis
	ON ui.id = uis.id
WHERE Mean <> 0
GROUP BY  ui.State_Name, City
ORDER BY Average_income ASC
Limit 5 ;
 ;
 
-- Results: Lowest 5 Cities by Average Income are :
-- Center in Cholorado, Estancia in New Mexico , Corsica in North Dakota ,
-- Mount Olivet in Kentucky , and Fordvilla in North Dakota 
-- The Average Incomes are between $10.9K & $13.9k in those  cities 