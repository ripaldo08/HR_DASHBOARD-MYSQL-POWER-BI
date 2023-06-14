USE project1;

SELECT * FROM hr;
SELECT count(*) FROM hr;

-- data cleaning
-- 1. mengubah kolom ï»¿id menjadi emp_id
ALTER TABLE hr
CHANGE COLUMN ï»¿id emp_id VARCHAR(10) NULL;

-- memeriksa type data
DESC hr;

SELECT birthdate FROM hr;
-- mengubah kolom birthdate yang type nya text menjadi date
SET sql_safe_updates = 0;

UPDATE hr
SET birthdate = CASE
	WHEN birthdate LIKE '%/%' THEN date_format(str_to_date(birthdate, '%m/%d/%Y'), '%Y-%m-%d')
    WHEN birthdate LIKE '%-%' THEN date_format(str_to_date(birthdate, '%m-%d%-%Y'), '%Y-%m-%d')
    ELSE NULL
END;

ALTER TABLE hr
MODIFY COLUMN birthdate DATE;

-- mengubah kolom hire_date yang type nya text menjadi date
UPDATE hr
SET hire_date = case
	WHEN hire_date LIKE '%/%' THEN date_format(str_to_date(hire_date, '%m/%d/%Y'), '%Y-%m-%d')
    WHEN hire_date LIKE '%-%' THEN date_format(str_to_date(hire_date, '%m-%d%-%Y'), '%Y-%m-%d')
    ELSE NULL
END;

ALTER TABLE hr
MODIFY COLUMN hire_date DATE;

-- mengubah kolom termdate yang awalnya dari text menjadi tanggal (date)
UPDATE hr
SET termdate = DATE(str_to_date(termdate, '%Y-%m-%d %H:%i:%s UTC'))
WHERE termdate IS NOT NULL AND termdate !='';

ALTER TABLE hr
MODIFY COLUMN termdate DATE;

SELECT termdate FROM hr;
SELECT * FROM hr;

-- menambahkan kolom umur (age) ke dalam table hr untuk melihat umur pada setiap data yang ada pada table hr
ALTER TABLE hr ADD COLUMN age INT;

-- Menghitung umur dari data kolom birthdate ke dalam age
UPDATE hr
SET age = timestampdiff(YEAR, birthdate, CURDATE());

SELECT birthdate, age FROM hr;

-- Memeriksa umur paling termuda dan umur tertua pada kolom age
SELECT 
	MIN(age) AS TERMUDA,
    MAX(age) AS TERTUA
FROM hr;









