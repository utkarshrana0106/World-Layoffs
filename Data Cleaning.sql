-- SQL PROJECT -- Data Cleaning --

-- DATASET - https://www.kaggle.com/datasets/swaptr/layoffs-2022

-- Counting total records in the original layoffs table.
SELECT count(*) 
FROM layoffs;

-- Creating a staging table to work with raw data and keep the original data intact.
CREATE TABLE layoffs_staging
LIKE layoffs;

-- Copying data from the original table to the staging table.
INSERT layoffs_staging
SELECT * 
FROM layoffs;

-- Removing Duplicates

-- Identifying duplicates based on selected columns.
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY company, industry, total_laid_off, percentage_laid_off, date) AS row_num
FROM layoffs_staging;

-- Checking and removing duplicates from the staging table.
WITH duplicate_cte AS
(
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY company, industry, total_laid_off, percentage_laid_off, date) AS row_num
FROM layoffs_staging
)
SELECT * FROM duplicate_cte
WHERE row_num > 1;

-- Standardizing Data

-- Removing leading and trailing whitespaces from the company names.
SELECT company, TRIM(company) 
FROM layoffs_staging;

-- Updating company names to remove leading and trailing whitespaces.
UPDATE layoffs_staging
SET company = TRIM(company);

-- Standardizing industry names, e.g., consolidating variations of "Crypto" to "Crypto".
SELECT DISTINCT industry
FROM layoffs_staging
ORDER BY industry;

-- Updating industry names to standardize variations.
UPDATE layoffs_staging
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%';

-- Standardizing country names, e.g., correcting "United States." to "United States".
SELECT DISTINCT country
FROM layoffs_staging
ORDER BY country;

-- Updating country names to standardize variations.
UPDATE layoffs_staging
SET country = 'United States'
WHERE country LIKE 'United States%';

-- Converting the date column from string to date format.
SELECT date
FROM layoffs_staging;

-- Updating the date column to the proper date format.
UPDATE layoffs_staging
SET date = STR_TO_DATE(date,'%m/%d/%Y');

-- Converting the data type of the date column.
ALTER TABLE layoffs_staging MODIFY date DATE; 

-- Populating null industry values with non-null values where possible.
SELECT *
FROM layoffs_staging
WHERE industry IS NULL OR industry = '';

-- Checking and updating null industry values based on non-null values for the same company.
SELECT t1.industry, t2.industry
FROM layoffs_staging t1
JOIN layoffs_staging t2
ON (t1.company = t2.company AND t1.location = t2.location)
WHERE (t1.industry IS NULL OR t1.industry = '') AND (t2.industry IS NOT NULL AND t2.industry != '');

-- Updating null industry values with non-null values for the same company.
UPDATE layoffs_staging t1
JOIN layoffs_staging t2
ON (t1.company = t2.company AND t1.location = t2.location)
SET t1.industry = t2.industry
WHERE (t1.industry IS NULL OR t1.industry = '') AND (t2.industry IS NOT NULL AND t2.industry != '');

-- Remove any columns and rows we need to

-- Deleting rows with null total_laid_off and percentage_laid_off values.
SELECT *
FROM layoffs_staging
WHERE total_laid_off IS NULL AND percentage_laid_off IS NULL;

-- Deleting rows with null total_laid_off and percentage_laid_off values.
DELETE FROM layoffs_staging
WHERE total_laid_off IS NULL AND percentage_laid_off IS NULL;

-- Dropping the row_num column.
ALTER TABLE layoffs_staging
DROP COLUMN row_num;

-- Final cleaned data in the layoffs_staging table.
SELECT *
FROM layoffs_staging;
