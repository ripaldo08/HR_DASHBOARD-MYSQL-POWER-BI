-- PERTANYAAN

-- 1. Apa pengelompokan gender karyawan di perusahaan?
SELECT gender, count(*) AS jumlah
FROM hr
WHERE age > 20 AND termdate = '0000-00-00'
GROUP BY gender;

-- 2. Apa pembagian ras/etnis karyawan di perusahaan?
SELECT race, count(*) AS jumlah
FROM hr
WHERE age > 20 AND termdate = '0000-00-00'
GROUP BY race
ORDER BY count(*) DESC;



-- 3. Bagaimana pembagian usia karyawan di perusahaan?
SELECT 
	MIN(age) AS TERMUDA,
    MAX(age) AS TERTUA
FROM hr
WHERE age >= 20 AND termdate = '0000-00-00';

SELECT 
	CASE
		WHEN age >=20 AND age <=25 THEN '20-25'
        WHEN age >=26 AND age <=35 THEN '26-35'
        WHEN age >=36 AND age <=45 THEN '36-45'
        WHEN age >=46 AND age <=55 THEN '46-55'
        WHEN age >=56 AND age <=65 THEN '56-65'
        ELSE '66+'
	END AS kelompok_umur,
	count(*) AS jumlah
FROM hr
WHERE age >= 20 AND termdate = '0000-00-00'
GROUP BY kelompok_umur
ORDER BY kelompok_umur;

SELECT 
	CASE
		WHEN age >=20 AND age <=25 THEN '20-25'
        WHEN age >=26 AND age <=35 THEN '26-35'
        WHEN age >=36 AND age <=45 THEN '36-45'
        WHEN age >=46 AND age <=55 THEN '46-55'
        WHEN age >=56 AND age <=65 THEN '56-65'
        ELSE '66+'
	END AS kelompok_umur, gender,
	count(*) AS jumlah
FROM hr
WHERE age >= 20 AND termdate = '0000-00-00'
GROUP BY kelompok_umur, gender
ORDER BY kelompok_umur, gender;

-- 4. Berapa banyak karyawan yang bekerja di kantor pusat dibandingkan dengan lokasi terpencil?
SELECT location, count(*) AS jumlah
FROM hr
WHERE age >= 20 AND termdate = '0000-00-00'
GROUP BY location;

-- 5. Berapa lama rata-rata masa kerja karyawan yang telah di-PHK?
SELECT
	round(avg(datediff(termdate, hire_date))/365,0) AS rata_rata_durasi_kerja
FROM hr
WHERE termdate <= curdate() AND termdate <> '0000-00-00' AND age >= 20;

-- 6. Bagaimana distribusi Gender berbeda-beda di seluruh departemen dan jabatan?
SELECT department, gender, count(*) AS jumlah
FROM hr
WHERE age >= 20 AND termdate = '0000-00-00'
GROUP BY department, gender
ORDER BY department;

-- 7. Bagaimana pembagian jabatan di seluruh perusahaan?
SELECT jobtitle, count(*) AS jumlah
FROM hr
WHERE age >= 20 AND termdate = '0000-00-00'
GROUP BY jobtitle
ORDER BY jobtitle DESC;

-- 8. Departemen mana yang memiliki tingkat pergantian karyawan tertinggi?
SELECT  department,
 total_count,
 Jumlah_dihentikan,
 Jumlah_dihentikan/total_count AS tingkat_pergantian
FROM (
	SELECT department,
    count(*) AS Total_count,
    SUM(CASE WHEN termdate <> '0000-00-00' AND termdate <= curdate() THEN 1 ELSE 0 END) AS Jumlah_dihentikan
    FROM hr
    WHERE age >= 20
    GROUP BY department
    ) AS subquery
ORDER BY tingkat_pergantian DESC;


-- 9. Bagaimana distribusi karyawan di seluruh lokasi berdasarkan kota dan negara bagian?
SELECT location_state, count(*) AS jumlah
FROM hr
WHERE age >= 20 AND termdate = '0000-00-00'
GROUP BY location_state
ORDER BY jumlah DESC;


-- 10. Bagaimana jumlah karyawan perusahaan berubah dari waktu ke waktu berdasarkan perekrutan dan tanggal masa jabatan?
SELECT 
	year,
    perekrutan,
    penghentian,
    perekrutan - penghentian AS perubahan,
    round((perekrutan - penghentian)/perekrutan* 100,2) AS perubahan_persentasi
FROM (
	SELECT 
		YEAR(hire_date) AS year,
        count(*) AS perekrutan,
        SUM(CASE WHEN termdate <> '0000-00-00' AND termdate <= curdate() THEN 1 ELSE 0 END) AS penghentian
        FROM hr
        WHERE age >=20
        GROUP BY YEAR(hire_date)
        ) AS subquery
ORDER BY year ASC;
	
-- 11. Bagaimana pembagian masa kerja untuk setiap departemen?
SELECT department, round(avg(datediff(termdate, hire_date)/365),0) AS rata_rata_masajabatan
FROM hr
WHERE termdate <= curdate() AND termdate <> '0000-00-00' AND age >=20
GROUP BY department;