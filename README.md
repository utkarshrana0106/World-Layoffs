# World-Layoffs

# Data Cleaning and Exploratory Data Analysis (EDA) Project

## Overview

The Data Cleaning and EDA Project focuses on cleaning and analyzing data related to layoffs using MySQL. The project involves cleaning and standardizing the data to ensure accuracy and consistency, followed by exploratory analysis to gain insights into layoffs trends by company, industry, country, and time period.

## Key Steps in the Data Cleaning Process

1. **Remove Duplicates**: Identify and remove duplicate entries in the dataset to avoid data redundancy.
2. **Standardize Data**: Fix issues such as spellings or formatting inconsistencies to make the data uniform and consistent.
3. **Handle Null and Blank Values**: Address null and blank values by either populating them or deciding whether to keep them based on the context.
4. **Remove Unnecessary Columns and Rows**: Eliminate columns and rows that are not required for analysis to streamline the dataset for further processing.

## Exploratory Data Analysis (EDA) Queries

### Layoffs Overview

- **Total Layoffs**: Retrieves all data from the `layoffs_staging2` table.
- **Maximum Total Layoffs**: Finds the maximum total laid-off employees.
- **Maximum Total Layoffs and Percentage**: Finds the maximum total laid-off employees and maximum percentage laid-off.
- **Companies with 100% Layoffs**: Retrieves companies with 100% layoffs.
- **Companies with 100% Layoffs (Sorted)**: Retrieves companies with 100% layoffs sorted by funds raised and total layoffs.
- **Total Layoffs by Company**: Calculates the total layoffs for each company and orders them by total layoffs.
- **Date Range**: Finds the maximum and minimum dates in the dataset.
- **Total Layoffs by Industry**: Calculates the total layoffs for each industry and orders them by total layoffs.
- **Total Layoffs by Country**: Calculates the total layoffs for each country and orders them by total layoffs.
- **Total Layoffs by Year**: Calculates the total layoffs for each year and orders them by year.
- **Total Layoffs by Funding Stage**: Calculates the total layoffs for each funding stage and orders them by total layoffs.
- **Total Layoffs by Month**: Calculates the total layoffs for each month.
- **Monthly Rolling Total Layoffs**: Calculates the monthly rolling total layoffs.

### Top Companies by Year

- **Top Companies by Year**: Retrieves the top 5 companies with the highest total layoffs for each year.

## Conclusion

The project provides valuable insights into layoffs trends by company, industry, country, and time period. It demonstrates the importance of data cleaning and exploratory analysis in understanding complex datasets and making informed decisions.

