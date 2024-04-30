-- SQL PROJECT -- Exploratory Data Analysis --

-- Retrieves all data from the layoffs_staging2 table.
SELECT *
FROM layoffs_staging2;

-- Finds the maximum total laid-off employees.
SELECT max(total_laid_off)
FROM layoffs_staging2;

-- Finds the maximum total laid-off employees and maximum percentage laid-off.
SELECT max(total_laid_off),max(percentage_laid_off)
FROM layoffs_staging2;
 
 -- Retrieves companies with 100% layoffs.
SELECT * 
FROM layoffs_staging2
WHERE percentage_laid_off=1;

-- Retrieves companies with 100% layoffs sorted by funds raised and total layoffs.
SELECT * 
FROM layoffs_staging2
WHERE percentage_laid_off=1
ORDER BY funds_raised_millions DESC,total_laid_off DESC;

-- Calculates the total layoffs for each company and orders them by total layoffs.
SELECT company, sum(total_laid_off)
FROM layoffs_staging2
GROUP BY company
ORDER BY 2 DESC,1;

-- Finds the maximum and minimum dates in the dataset.
	#date range
SELECT max(date),min(date)
FROM layoffs_staging2;

-- Calculates the total layoffs for each industry and orders them by total layoffs.
SELECT industry, sum(total_laid_off)
FROM layoffs_staging2
GROUP BY industry
ORDER BY 2 DESC;


-- Calculates the total layoffs for each country and orders them by total layoffs.
SELECT country, sum(total_laid_off)
FROM layoffs_staging2
GROUP BY country
ORDER BY 2 DESC;

-- Calculates the total layoffs for each year and orders them by year.
SELECT year(date), sum(total_laid_off)
FROM layoffs_staging2
GROUP BY year(date)
ORDER BY 1 DESC;

-- Calculates the total layoffs for each funding stage and orders them by total layoffs.
SELECT year(date), sum(total_laid_off)
FROM layoffs_staging2
GROUP BY year(date)
ORDER BY 1 DESC;

-- Calculates the total layoffs for each funding stage and orders them by total layoffs.
SELECT stage, sum(total_laid_off)
FROM layoffs_staging2
GROUP BY stage
ORDER BY 2 DESC;

-- Calculates the total layoffs for each month(of all years).
SELECT substring(date,1,7) as 'MONTH', SUM(total_laid_off)
FROM layoffs_staging2
WHERE substring(date,1,7) IS NOT NULL
GROUP BY substring(date,1,7)
ORDER BY 1 ASC;

-- Calculates the monthly rolling total layoffs.
WITH monthly_totals AS(
SELECT substring(date,1,7) as 'month', SUM(total_laid_off) as monthly_total
FROM layoffs_staging2
WHERE substring(date,1,7) IS NOT NULL
GROUP BY substring(date,1,7)
ORDER BY 1 ASC
)
SELECT month , monthly_total, SUM(monthly_total) OVER (ORDER BY month) as monthly_rolling_total
FROM monthly_totals; 

-- Top Companies by Year Queries --

-- Retrieves the top 5 companies with the highest total layoffs for each year.
WITH company_year (company, years, total_laid_off) AS (
SELECT company, year(date), sum(total_laid_off)
FROM layoffs_staging2
GROUP BY company, year(date)
), company_year_rank AS (
SELECT *, DENSE_RANK() OVER(PARTITION BY years ORDER BY total_laid_off DESC) as Ranking
FROM company_year
WHERE years IS NOT NULL
)
SELECT * 
FROM company_year_rank
WHERE Ranking <= 5;