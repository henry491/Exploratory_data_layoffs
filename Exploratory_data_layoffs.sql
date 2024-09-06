-- Exporatory Data Analysis

SELECT *
FROM
	layoffs_staging2;
    
SELECT MAX(total_laid_off), MAX(percentage_laid_off)
FROM
	layoffs_staging2;
    
SELECT *
FROM
	layoffs_staging2
WHERE
	percentage_laid_off = 1
ORDER BY
	funds_raised_millions DESC;
    
SELECT company, SUM(total_laid_off) AS total_off
FROM
	layoffs_staging2
GROUP BY
	company
ORDER BY
	total_off DESC;
    
SELECT MIN(`date`), MAX(`date`)
FROM
	layoffs_staging2;
    
SELECT industry, SUM(total_laid_off) AS total_off
FROM
	layoffs_staging2
GROUP BY
	industry
ORDER BY
	total_off DESC;
    
SELECT country, SUM(total_laid_off) AS total_off
FROM
	layoffs_staging2
GROUP BY
	country
ORDER BY
	total_off DESC;
    
SELECT YEAR(`date`), SUM(total_laid_off) AS total_off
FROM
	layoffs_staging2
GROUP BY
	YEAR(`date`)
ORDER BY
	total_off DESC;
    
SELECT stage, SUM(total_laid_off) AS total_off
FROM
	layoffs_staging2
GROUP BY
	stage
ORDER BY
	total_off DESC;
    
SELECT company, AVG(percentage_laid_off) AS per_laid_off
FROM
	layoffs_staging2
GROUP BY
	company
ORDER BY
	per_laid_off DESC;
    
SELECT SUBSTRING(`date`, 1, 7) AS `MONTH`, SUM(total_laid_off) AS total_off
FROM
	layoffs_staging2
WHERE
	SUBSTRING(`date`, 1, 7) IS NOT NULL
GROUP BY
	`MONTH`
ORDER BY
	`MONTH`;
    
WITH Rolling_Total AS (
SELECT SUBSTRING(`date`, 1, 7) AS `MONTH`, SUM(total_laid_off) AS total_off
FROM
	layoffs_staging2
WHERE
	SUBSTRING(`date`, 1, 7) IS NOT NULL
GROUP BY
	`MONTH`
ORDER BY
	`MONTH`
)
SELECT
	`MONTH`
    ,total_off
    ,SUM(total_off) OVER(ORDER BY `MONTH`) AS rolling_total
FROM
	Rolling_Total;
    
    
SELECT company, YEAR(`date`) AS `Year`, SUM(total_laid_off) AS total_off
FROM
	layoffs_staging2
GROUP BY
	company
    ,`Year`
ORDER BY
	total_off DESC;
    
    
WITH company_Year (company, Years, total_off) AS (
SELECT
	company
    ,YEAR(`date`) AS `Year`
    ,SUM(total_laid_off) AS total_off
FROM
	layoffs_staging2
GROUP BY
	company
    ,`Year`
), company_Year_Ranking AS (
SELECT *, 
DENSE_RANK() OVER(PARTITION BY Years ORDER BY total_off DESC) AS Ranking
FROM
	company_Year
WHERE
	Years IS NOT NULL
)
SELECT *
FROM
	company_Year_Ranking
WHERE
	Ranking <=5;


SELECT *
FROM
	layoffs_staging2


