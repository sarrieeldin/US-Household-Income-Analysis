

-- STEP # 0 : We load both the two tables ( US Household Income) & (US Household Income Statistics)
-- We run a Query to examine the two tables prior any data cleaning 

-- For US Household Income table 

SELECT *
FROM  us_household_income ;

-- For US Household Income statistics table 

SELECT *
FROM  us_household_income_statistics ;

-- Results : We observed right away that the first column (ID Column) in US Household Income statistics table has some additional symbols added during the upload 

-- STEP #1 Change ID Column name 

ALTER TABLE us_household_income_statistics RENAME COLUMN `ï»¿id` TO id ;

-- STEP # 2 : Identify DUPLICATES in US HOUSEHOLD INCOME TABLE 

SELECT id,
COUNT(id) 
FROM us_household_income
GROUP BY id 
HAVING COUNT(ID) > 1; 

-- Results : We Found 6 Duplicates identified by their 'id'

-- STEP # 3 : REMOVE DUPLICATES FROM US HOUSEHOLD INCOME TABLE 
-- Methodoly : USE delete staement combined with window functions to delete the duplicate rows based on id

DELETE FROM us_household_income
WHERE row_id IN (
				SELECT row_id
				FROM ( 
						SELECT row_id,
								id,
								ROW_NUMBER() OVER( PARTITION BY id ORDER BY id) AS row_num
						FROM us_household_income
						) AS duplicates_table
				WHERE row_num >1 
				);
                
-- RESULTS : 6 Duplicate rows were deleted, to confirm that, we re-run the query below 

SELECT id,
COUNT(id) 
FROM us_household_income
GROUP BY id 
HAVING COUNT(ID) > 1; 

-- STEP # 3 : We identify duplicates for the US household statistics Table 

SELECT id,
COUNT(id) 
FROM us_household_income_statistics
GROUP BY id 
HAVING COUNT(ID) > 1; 

-- RESULTS : NO Duplicates were found 

-- STEP # 4 : Fix Spelling errors in the State column of the us household income table 
-- We first run a query to see state names 


SELECT  DISTINCT state_name 
FROM us_household_income ;

-- We then Update Spelling errors  

UPDATE us_household_income 
SET State_Name = 'Georgia' 
WHERE State_Name = 'georia' ;

UPDATE us_household_income 
SET State_Name = 'Alabama' 
WHERE State_Name = 'alabama' ;

-- STEP # 5 : Check the State ab Column and whether it has any errors/duplicates

SELECT DISTINCT State_ab 
FROM us_household_income  ;

-- Results : No errors/duplicates found


-- STEP # 6 : Check the Place Column and whether it has any Errors/duplicates/Missing Values

SELECT DISTINCT Place ,
 City, 
 County,
 State_Name 
FROM us_household_income  ;

-- Results : We found some missing values 
-- We Can update that using info from the City & County Columns 
-- We found only one result for a missing Place Called  'Autaugaville' ( Based on City & County Columns)

UPDATE us_household_income
SET Place = 'Autaugaville'
WHERE City = 'Vinemont' 
AND County = 'Autauga County' ;

-- STEP # 7 : We Investigate the Type Column in US Household income table

SELECT Type ,
       Count(Type)
FROM us_household_income  
GROUP BY Type
;

-- Results : We notice that there are a couple of typos 
-- First, the  Census Designated places (CDP) is mistyped in a couple of instances as 'CPD' 
-- Therefore, we will update it to make sure we have the correct counts for any future analysis needed 
-- Secondly, there is a typo for 'Borough' as 'Boroughs'
-- We Will update these as well


-- Fixing the 'CPD' Rows
UPDATE us_household_income 
SET Type = 'CDP'
WHERE Type = 'CPD' ;


-- Fixing the ' Boroughs' Rows
UPDATE us_household_income 
SET Type = 'Borough'
WHERE Type = 'Boroughs' ;

-- Running the query again to double check 

SELECT Type ,
       Count(Type)
FROM us_household_income  
GROUP BY Type
;

-- STEP #8  : Investigate the AWater & ALand columns
-- These are Water areas and land areas respectively 

-- First We Investigate the ALand Column 
SELECT ALand 
FROM us_household_income
WHERE (ALand = 0 OR ALand ='' OR ALand IS NULL )
;


-- Secondly, we investigate AWater

SELECT  AWater 
FROM us_household_income
WHERE (AWater = 0 OR AWater='' OR AWater IS NULL )
;

-- We Found many rows with ZERO values
-- it could be either a place where is no land or a place that doesn't have records
-- Running a third query combining both areas ( AWater & ALand ) will help us identify that 

SELECT ALand , AWater 
FROM us_household_income
WHERE (ALand = 0 OR ALand ='' OR ALand IS NULL )
AND (AWater = 0 OR AWater='' OR AWater IS NULL )
;

-- Results indicate no NULL (missing Values) and thus we have a blank table
-- Therefore, the data is fit for analysis 

-- STEP # 9 
-- We investigate the state name column in the uS Houeshold income statistics table 

SELECT * 
FROM us_household_income_statistics
WHERE State_Name ='' OR State_Name IS NULL
;

-- Results : No Errors found 

