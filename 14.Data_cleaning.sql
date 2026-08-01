-- Data Cleaning

-- Remove Duplicates
-- Standadize the data
-- Null values or blank values
-- Remove any columns
SELECT *
FROM layoffs;

DESCRIBE layoffs;


CREATE TABLE layoffs_staging
LIKE layoffs;

SELECT *
FROM layoffs_staging;

INSERT layoffs_staging
SELECT *
FROM layoffs;

SELECT *
FROM layoffs;

SELECT *,
ROW_NUMBER() OVER(
PARTITION BY company, industry, total_laid_off, percentage_laid_off, `date`) AS row_num
FROM layoffs_staging;


WITH duplicate_cte AS 
(
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY company,location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised) AS row_num
FROM layoffs_staging
)
SELECT *
FROM duplicate_cte
WHERE row_num > 1;


SELECT *
FROM layoffs_staging
WHERE company = 'Amazon';


WITH duplicate_cte AS 
(
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY company,location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised) AS row_num
FROM layoffs_staging
)
DELETE
FROM duplicate_cte
WHERE row_num > 1;


CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `total_laid_off` text,
  `date` text,
  `percentage_laid_off` text,
  `industry` text,
  `source` text,
  `stage` text,
  `funds_raised` int DEFAULT NULL,
  `country` text,
  `date_added` text,
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

SELECT *
FROM layoffs_staging2;

INSERT INTO layoffs_staging2
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY company,location,total_laid_off, `date`, percentage_laid_off, industry,`source`,  stage, funds_raised,country, date_added) AS row_num
FROM layoffs_staging;


SELECT *
FROM layoffs_staging2
WHERE row_num > 1;

SET SQL_SAFE_UPDATES = 0;

DELETE 
FROM layoffs_staging2
WHERE row_num > 1;

SELECT *
FROM layoffs_staging2;


-- Standardizing data

SELECT DISTINCT(TRIM(company)), company
FROM layoffs_staging2;


UPDATE layoffs_staging2
SET company = TRIM(company);


SELECT DISTINCT(industry)
FROM layoffs_staging2
ORDER BY 1;

SELECT *
FROM layoffs_staging2
WHERE industry LIKE 'Crypto%';


UPDATE layoffs_staging2
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%';

SELECT DISTINCT location
FROM layoffs_staging2
ORDER BY 1;

SELECT DISTINCT country, TRIM(TRAILING '.' FROM country)
FROM layoffs_staging2
ORDER BY 1;

UPDATE layoffs_staging2
SET country = TRIM(TRAILING '.' FROM country)
WHERE country LIKE 'United States%';


SELECT `date`,
STR_TO_DATE(`date`, '%m/%d/%Y')
FROM layoffs_staging2;

UPDATE layoffs_Staging2
SET date = STR_TO_DATE(`date`, '%m/%d/%Y');

SELECT `date`
FROM layoffs_staging2;

ALTER TABLE layoffs_staging2
MODIFY COLUMN `date` DATE;

SELECT *
FROM layoffs_staging2;





-- Remove null/blank values
SELECT *
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

UPDATE layoffs_staging2
SET industry = NULL
WHERE industry  = '';

UPDATE layoffs_staging2
SET total_laid_off = NULL
WHERE total_laid_off  = '';

UPDATE layoffs_staging2
SET percentage_laid_off = NULL
WHERE percentage_laid_off  = '';


SELECT *
FROM layoffs_staging2
WHERE industry IS NULL
OR industry = '';

SELECT *
FROM layoffs_staging2
WHERE company = 'Appsmith';

SELECT DISTINCT industry
FROM layoffs_staging2;

SELECT t1.industry, t2.industry
FROM layoffs_staging2 t1
JOIN layoffs_staging2 t2
ON t1.company = t2.company
AND t1.location = t2.location
WHERE (t1.industry IS NULL OR t1.industry = '')
AND t2.industry IS NOT NULL;


UPDATE layoffs_staging t1
JOIN layoffs_staging t2
ON t1.company = t2.company
SET t1.industry = t2.industry
WHERE t1.industry IS NULL 
AND t2.industry IS NOT NULL;


SELECT *
FROM layoffs_staging2
WHERE percentage_laid_off IS NULL
AND total_laid_off IS NULL;


DELETE
FROM layoffs_staging2
WHERE percentage_laid_off IS NULL
AND total_laid_off IS NULL;


SELECT *
FROM layoffs_staging2;

ALTER TABLE layoffs_staging2
DROP COLUMN row_num;

SELECT *
FROM layoffs_staging2;









