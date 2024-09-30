-- Data Cleaning 



Select *
from layoffs;

-- 1. Remove duplicates 
-- 2. Standardize the Data
-- 3. Null values or blank values 
-- 4. Remove any columns or rows

Create Table layoffs_staging 
Like layoffs;

Insert layoffs_staging 
Select * 
From layoffs;


Select* from layoffs_staging;


-- 1. Remove duplicates 

Select *,
ROW_Number() over ( partition by Company, location,industry,total_laid_off, percentage_laid_off,'date',stage,country,funds_raised_millions) as row_num
from layoffs_staging;

with duplicate_cte as
 (
Select *,
ROW_Number() over ( partition by Company, location,industry,total_laid_off, percentage_laid_off,'date',stage,country,funds_raised_millions) as row_num
from layoffs_staging
)
select *
from duplicate_cte
where row_num > 1;

select * 
from layoffs_staging2;



 
CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
	`row_num  ` int 
  
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



Insert into layoffs_staging2
Select *,
ROW_Number() over ( partition by Company, location,industry,total_laid_off, percentage_laid_off,'date',stage,country,funds_raised_millions) as row_num
from layoffs_staging;

select *
from layoffs_staging2;

Select * 
from layoffs_staging2
where row_num > 1;
Delete
from layoffs_staging2
where row_num > 1;


-- 2. Standardize the Data


select distinct(company)
from layoffs_staging2;

Select company, trim(company)
From layoffs_staging2;

Update layoffs_staging2
set company= trim(company);

select distinct(industry)
from layoffs_staging2
order by 1;

select *
from layoffs_staging2
where industry like 'Crypto%';


select distinct (industry)
from layoffs_staging2
where industry like 'Crypto%';

Update layoffs_staging2 
set industry = 'Crypto'
where industry like 'Crypto%';


Select distinct location 
From layoffs_staging2
order by 1;

Select distinct country
From layoffs_staging2
order by 1;

select *
from layoffs_staging2
where country like 'United States%';

select distinct country , trim(Trailing '.' from country)
from layoffs_staging2
order by 1;
-- where country like 'United States%';

update layoffs_staging2
set country = trim(Trailing '.' from country)
where country like 'United states%';

select * 
from layoffs_staging2;

select date
from layoffs_staging2;

select date,
str_to_date(date, '%m/%d/%Y')
from layoffs_staging2;


update layoffs_staging2
set date = str_to_date(date, '%m/%d/%Y');

ALTER TABLE layoffs_staging2
Modify Column date DATE ;



-- 3. Null values or blank values 
select * 
from layoffs_staging2
where total_laid_off is null
and percentage_laid_off is null  ;

Select *
from layoffs_staging2
where industry is null
or industry='';

Select *
from layoffs_staging2
where company='Airbnb';


select * 
from layoffs_staging2 t1
Join layoffs_staging2 t2
on t1.company= t2.company
and t1.location = t2.location
where (t1.industry is null or t1.industry ='' )
and t2.industry is not null;

select t1.company,t2.company,t1.location,t2.location, t1.industry, t2.industry
from layoffs_staging2 t1
Join layoffs_staging2 t2
on t1.company= t2.company
and t1.location = t2.location
where t1.industry is null  
and t2.industry is not null;

update layoffs_staging2
set industry = null
where industry='';


update layoffs_staging2 t1
Join layoffs_staging2 t2
on t1.company= t2.company
set t1.industry= t2.industry
where t1.industry is null 
and t2.industry is not null;


Select *
from layoffs_staging2
where company like 'Bally%';

select *
from layoffs_staging2;


-- 4. Remove any columns or rows

select * 
from layoffs_staging2
where total_laid_off is null
and percentage_laid_off is null  ;

delete 
from layoffs_staging2
where total_laid_off is null
and percentage_laid_off is null  ;

select *
from layoffs_staging2;

alter table layoffs_staging2
drop column row_num;




