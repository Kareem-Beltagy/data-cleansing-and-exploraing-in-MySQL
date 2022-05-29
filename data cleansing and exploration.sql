#  GENERAL  LOOK OF DATA 
SELECT 	* 
FROM proj1.tmdb
limit 20; 
# DATA WRANGLING AND CLEANSING

# CHECKINTG  FOR DATA  TYPES
SELECT column_name, DATA_TYPE  from INFORMATION_SCHEMA.COLUMNS 
WHERE table_schema='proj1' AND table_name='tmdb';


# checking for   duplicated values 
SELECT 
	id,imdb_id,runtime, COUNT(*) AS counts
FROM 
	proj1.tmdb
GROUP BY
	id,imdb_id,runtime,homepage
HAVING 
	COUNT(*) > 1
-------------------------------------------------------------
#deletion od duplicates  using CTE  AND  ROW_NUMBER  
WITH duplicates AS (
	SELECT  *  FROM(
		SELECT 
			id,imdb_id,runtime
			,ROW_NUMBER() OVER(
				PARTITION BY imdb_id,runtime ORDER BY id) AS cub_count
		FROM  
			proj1.tmdb
) as  duplicates) 
DELETE FROM duplicates
where 
	dub_count>1




    ------------------------
#dropping the unwanted  columns in the table
ALTER TABLE proj1.tmdb
	DROP COLUMN   tagline, 
    DROP COLUMN  revenue_adj, 
    DROP COLUMN  budget_adj, 
    DROP COLUMN  release_date,
    DROP COLUMN  overview;
-------------------------------------------
# CHECKING FOR NULL VALUES IN  EACH COLUMN
SELECT 
	COUNT(id)
FROM  
	proj1.tmdb
WHERE 
	director IS NULL;# CHANGE THE COLUMN NAME TO CHECK FOR NULL VALUES
-------------------------------------------------

#DATA EXPLORATION
# top 10 Directors with max  revenues
USE proj1; # to avoid the error of no database selected
SELECT 
	director,
    sum(revenue)   AS total_revenues
FROM 
	proj1.tmdb
GROUP BY 
	director
ORDER BY 
	total_revenues DESC
LIMIT 10;
-------------------------------------
#  top 10 directors  with  highest number of movies
SELECT 
	director,
    count(id)   AS movie_counts
FROM 
	proj1.tmdb
GROUP BY 
	director
ORDER BY 
	movie_counts DESC
LIMIT 10;

---------------------------------------
# TOP MOVIES  MADE REVENUES
SELECT 
	id,
    original_title,
    sum(revenue)   AS movie_revenues
FROM 
	proj1.tmdb
GROUP BY 
	id
ORDER BY 
	movie_revenues DESC
LIMIT 10;
-----------------------------------
# TOP  10 MOVIES MADE PROFITS/LOSSES (REVENUE-BUDGET)
SELECT 
	
    original_title,
    sum(budget)   AS movie_budget,
    sum(revenue)   AS movie_revenue,
    sum(revenue)-sum(budget)  AS profits
    
FROM 
	proj1.tmdb
GROUP BY 
	id
ORDER BY 
	profits ASC # ASC  gives movies with most losses
    # Desc  gives movies with most profits
LIMIT 10;
-----------------------------------------------------------
#   Revenues of Action movies
SELECT 
	sum(revenue) AS  total_revenues
FROM
	proj1.tmdb
WHERE 
	genres like '%Action%'

---------------------------------------------
#AVERAGE POPULARITY  FOR EACH  DIRECTOR MOVIES
SELECT 
	AVG(popularity) AS avg_popularity,
    director
    
FROM 
	proj1.tmdb
GROUP BY 
	director
ORDER BY 
	avg_popularity DESC;
----------------------------------------------------------
#TOP COMPANIES WITH MOST REVENUES
SELECT 
	SUM(revenue) AS  revenue_sum,
    production_companies
    
FROM 
	proj1.tmdb
GROUP BY 
	production_companies
ORDER BY 
	revenue_sum DESC;
-------------------------------
#NUMBER OF MOVIES MADE EVERY YEAR
SELECT 
	count(id) AS  movie_counts,
    release_year
    
FROM 
	proj1.tmdb
GROUP BY 
	release_year
ORDER BY 
	release_year ASC;
    

 
	
 

	
	

    
    
    
    
    
     
	 








