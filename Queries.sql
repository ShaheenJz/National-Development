/*		Creating table and filling from file

CREATE TABLE statistic (id SERIAL PRIMARY KEY,
							 Country TEXT,
							 Country_Code TEXT,
							 Year INT,
							 EG_ELC_ACCS_ZS DECIMAL(5,2),
							 NY_ADJ_NNTY_PC_KD_ZG DECIMAL(5,2),
							 NY_ADJ_SVNX_GN_ZS DECIMAL(5,2),
							 NY_ADJ_DCO2_GN_ZS DECIMAL(5,2),
							 NY_ADJ_DRES_GN_ZS DECIMAL(5,2),
							 NY_ADJ_DFOR_GN_ZS DECIMAL(5,2),
							 NY_ADJ_DPEM_GN_ZS DECIMAL(5,2),
							 FB_ATM_TOTL_P5 FLOAT,
							 FM_LBL_BMNY_GD_ZS DECIMAL(5,2),
							 SE_PRM_UNER_ZS DECIMAL(5,2),
							 SE_COM_DURS INT,
							 IC_REG_COST_PC_FE_ZS FLOAT,
							 IC_REG_COST_PC_MA_ZS FLOAT,
							 NE_EXP_GNFS_ZS DECIMAL(5,2),
							 NE_CON_TOTL_ZS DECIMAL(5,2),
							 NY_GDP_MKTP_CD FLOAT,
							 NY_GDP_PCAP_CD FLOAT,
							 NE_CON_GOVT_ZS DECIMAL(5,2),
							 NE_DAB_TOTL_ZS DECIMAL(5,2),
							 NY_GNS_ICTR_ZS DECIMAL(5,2),
							 NE_IMP_GNFS_ZS DECIMAL(5,2),
							 FP_CPI_TOTL_ZG DECIMAL(5,2),
							 SE_PRM_CMPT_ZS DECIMAL(5,2),
							 SG_GEN_PARL_ZS DECIMAL(5,2),
							 SE_PRM_ENRL_TC_ZS DECIMAL(6,2),
							 EG_ELC_RNEW_ZS DECIMAL(6,2),
							 EG_FEC_RNEW_ZS DECIMAL(6,2),
							 SE_PRE_ENRR DECIMAL(6,2),
							 SE_PRM_ENRR DECIMAL(6,2),
							 SE_SEC_ENRR DECIMAL(6,2),
							 NE_TRD_GNFS_ZS DECIMAL(6,2),
							 SG_LAW_INDX DECIMAL(6,2),
							 SN_ITK_DEFC DECIMAL(6,2),
							 SI_POV_DAY1 DECIMAL(6,2),
							 IT_MOB_2GNTWK DECIMAL(6,2),
							 IT_MOB_3GNTWK DECIMAL(6,2),
							 SP_ACS_BSRVH2O DECIMAL(6,2),
							 SL_TLF_UEM DECIMAL(6,2),
							 SL_TLF_UEF DECIMAL(6,2),
							 CO2_Emissions_MT FLOAT,
							 Continent TEXT,
							 SI_POV_GINI DECIMAL(6,2),
							 Income_Classification TEXT,
							 IT_NET_USER_ZS DECIMAL(6,2),
							 SP_DYN_LE00_IN DECIMAL(4,2),
							 Population INT,
							 Regime_Type TEXT,
							 Rural_population DECIMAL(6,2),
							 NY_GDP_TOTL_RT_ZS DECIMAL(6,2),
							 Urban_population DECIMAL(6,2),
							 World_Regions TEXT);




COPY statistic (Country, Country_Code, Year, EG_ELC_ACCS_ZS, NY_ADJ_NNTY_PC_KD_ZG, NY_ADJ_SVNX_GN_ZS, NY_ADJ_DCO2_GN_ZS,
	NY_ADJ_DRES_GN_ZS, NY_ADJ_DFOR_GN_ZS, NY_ADJ_DPEM_GN_ZS, FB_ATM_TOTL_P5, FM_LBL_BMNY_GD_ZS, SE_PRM_UNER_ZS, SE_COM_DURS,
	IC_REG_COST_PC_FE_ZS, IC_REG_COST_PC_MA_ZS, NE_EXP_GNFS_ZS, NE_CON_TOTL_ZS, NY_GDP_MKTP_CD, NY_GDP_PCAP_CD, NE_CON_GOVT_ZS,
	NE_DAB_TOTL_ZS, NY_GNS_ICTR_ZS, NE_IMP_GNFS_ZS, FP_CPI_TOTL_ZG, SE_PRM_CMPT_ZS, SG_GEN_PARL_ZS, SE_PRM_ENRL_TC_ZS, EG_ELC_RNEW_ZS,
	EG_FEC_RNEW_ZS, SE_PRE_ENRR, SE_PRM_ENRR, SE_SEC_ENRR, NE_TRD_GNFS_ZS, SG_LAW_INDX, SN_ITK_DEFC, SI_POV_DAY1, IT_MOB_2GNTWK,
	IT_MOB_3GNTWK, SP_ACS_BSRVH2O, SL_TLF_UEM, SL_TLF_UEF, CO2_Emissions_MT, Continent, SI_POV_GINI, Income_Classification, IT_NET_USER_ZS,
	SP_DYN_LE00_IN, Population, Regime_Type, Rural_population, NY_GDP_TOTL_RT_ZS, Urban_population, World_Regions)
FROM 'Z:\Docs\HDD Documents\SQL Project\Sustainability\WorldSustainabilityDataset.csv'
DELIMITER ','
CSV HEADER;
*/

--Updating % population values which are over 100% to 100. Errors may be present due to double counting in reported statistics or various other reasons
--Preprimary enrollment
SELECT SE_PRE_ENRR FROM statistic where SE_PRE_ENRR > 100
UPDATE statistic
SET SE_PRE_ENRR = 100
WHERE SE_PRE_ENRR > 100

--Primary enrollment
SELECT SE_PRM_ENRR FROM statistic where SE_PRM_ENRR > 100
UPDATE statistic
SET SE_PRM_ENRR = 100
WHERE SE_PRM_ENRR > 100

--Secondary enrollment
SELECT SE_SEC_ENRR FROM statistic where SE_SEC_ENRR > 100
UPDATE statistic
SET SE_SEC_ENRR = 100
WHERE SE_SEC_ENRR > 100

--Secondary enrollment
SELECT SE_PRM_CMPT_ZS FROM statistic where SE_PRM_CMPT_ZS > 100
UPDATE statistic
SET SE_PRM_CMPT_ZS = 100
WHERE SE_PRM_CMPT_ZS > 100

------------------------------------------------------------------------------------------------------------------------------
--Counting null values in columns by country
SELECT 
    country,
    SUM(CASE WHEN SE_COM_DURS IS NULL THEN 1 ELSE 0 END) AS null_count_edu_compulsary,
    SUM(CASE WHEN SE_PRM_UNER_ZS IS NULL THEN 1 ELSE 0 END) AS null_count_children_not_in_edu,
    SUM(CASE WHEN SE_PRM_ENRL_TC_ZS IS NULL THEN 1 ELSE 0 END) AS null_count_P_T_ratio,
    SUM(CASE WHEN SE_PRE_ENRR IS NULL THEN 1 ELSE 0 END) AS null_count_pre_school_enroll,
    SUM(CASE WHEN SE_PRM_ENRR IS NULL THEN 1 ELSE 0 END) AS null_count_prm_school_enroll,
    SUM(CASE WHEN SE_SEC_ENRR IS NULL THEN 1 ELSE 0 END) AS null_count_SE_sec_school_enroll
FROM statistic
WHERE year > 2000 AND year < 2016
GROUP BY country
ORDER BY 5,6 desc
 
--Updating compulsary years in education for countries with no information as the loop will not be able to fill them
UPDATE statistic
SET SE_COM_DURS = 9
WHERE country = 'Niger'

SELECT
	country,
	COUNT(*)
FROM statistic
WHERE year > 2000 AND year < 2016
AND SE_COM_DURS IS NULL
GROUP BY country
ORDER BY 1,2

-- Temporary table to find min and max values of compulsory education years.
CREATE TEMPORARY TABLE temp_education AS
SELECT
	country,
	MAX(SE_COM_DURS) as max_years,
	MIN(SE_COM_DURS) as min_years
FROM statistic
WHERE year > 2000 AND year < 2016
GROUP BY country;

-- Loop to use min years to replace null values if earlier chronological values are missing and max years to replace later values if missing
DO $$ 
DECLARE 
    null_count INT;
BEGIN
	LOOP
		
		UPDATE statistic
		SET SE_COM_DURS = temp_education.max_years
		FROM temp_education
		WHERE statistic.country = temp_education.country
		AND statistic.SE_COM_DURS IS NULL
		AND statistic.year = (
		SELECT MAX(year)
			FROM statistic 
			WHERE statistic.country = temp_education.country
			AND statistic.SE_COM_DURS IS NULL
		);
		
		UPDATE statistic
		SET SE_COM_DURS = temp_education.min_years
		FROM temp_education
		WHERE statistic.country = temp_education.country
		AND statistic.SE_COM_DURS IS NULL
		AND statistic.year = (
		SELECT MIN(year)
			FROM statistic 
			WHERE statistic.country = temp_education.country
			AND statistic.SE_COM_DURS IS NULL
		);
		
        SELECT COUNT(*) INTO null_count
        	FROM statistic
			WHERE SE_COM_DURS IS NULL;
		
	EXIT WHEN null_count = 0;
END LOOP;
END $$;


----------------------------------------Creating estimates for nulls in primary school enrollment from ChatGPT----------------------------------------


--Exploring trends between education and poverty
SELECT 
	country,
	continent,
	year,
	SI_POV_DAY1 AS Population_Under_Poverty_Line,
	SE_PRM_ENRR AS Primary_School_Enrollment,
	SE_SEC_ENRR AS Secondary_School_Enrollment
FROM statistic
WHERE year > 2000 AND year < 2016
ORDER BY 1,3

SELECT SE_PRM_UNER_ZS FROM statistic

SELECT country, year, SI_POV_DAY1 FROM statistic WHERE SI_POV_DAY1 IS null
SELECT * FROM statistic

SELECT
	country,
	SUM(CASE WHEN SI_POV_DAY1 IS NULL THEN 1 ELSE 0 END) AS pov_line
FROM statistic
WHERE year > 2000 AND year < 2016
GROUP BY country
ORDER BY country


UPDATE statistic SET SI_POV_DAY1 = 26.1 WHERE country = 'India' AND year = 2001;
UPDATE statistic SET SI_POV_DAY1 = 25.8 WHERE country = 'India' AND year = 2002;
UPDATE statistic SET SI_POV_DAY1 = 25.5 WHERE country = 'India' AND year = 2003;
UPDATE statistic SET SI_POV_DAY1 = 25.7 WHERE country = 'India' AND year = 2004;
UPDATE statistic SET SI_POV_DAY1 = 27.0 WHERE country = 'India' AND year = 2005;
UPDATE statistic SET SI_POV_DAY1 = 24.8 WHERE country = 'India' AND year = 2006;
UPDATE statistic SET SI_POV_DAY1 = 22.6 WHERE country = 'India' AND year = 2007;
UPDATE statistic SET SI_POV_DAY1 = 21.5 WHERE country = 'India' AND year = 2008;
UPDATE statistic SET SI_POV_DAY1 = 25.7 WHERE country = 'India' AND year = 2009;
UPDATE statistic SET SI_POV_DAY1 = 29.8 WHERE country = 'India' AND year = 2010;
UPDATE statistic SET SI_POV_DAY1 = 29.8 WHERE country = 'India' AND year = 2011;
UPDATE statistic SET SI_POV_DAY1 = 22.2 WHERE country = 'India' AND year = 2012;
UPDATE statistic SET SI_POV_DAY1 = 21.2 WHERE country = 'India' AND year = 2013;
UPDATE statistic SET SI_POV_DAY1 = 20.6 WHERE country = 'India' AND year = 2014;
UPDATE statistic SET SI_POV_DAY1 = 19.4 WHERE country = 'India' AND year = 2015;

--CTE to find the closest value to a null which will be used to replace nulls.
WITH closest_percent AS (
	SELECT
		country,
		year,
	
		SI_POV_DAY1 AS pre_school_enrollment,
	
		(SELECT SI_POV_DAY1 
		 	FROM statistic as t2
		 	WHERE t2.country = t1.country
		 	AND t2.year < t1.year
		 	AND t2.SI_POV_DAY1 IS NOT NULL
         	AND t2.year > 2000 AND t2.year < 2016 
		 	ORDER BY t2.year DESC
		LIMIT 1) AS closest_non_null_before_pov,
		(SELECT SI_POV_DAY1 
        	FROM statistic AS t3 
        	WHERE t3.Country = t1.Country 
        	AND t3.year > t1.Year
        	AND t3.SI_POV_DAY1 IS NOT NULL
         	AND t3.year > 2000 AND t3.year < 2016 
        	ORDER BY t3.Year ASC
        LIMIT 1) AS closest_non_null_after_pov,
	
		SE_PRE_ENRR AS pre_school_enrollment,
		(SELECT SE_PRE_ENRR 
		 	FROM statistic as t2
		 	WHERE t2.country = t1.country
		 	AND t2.year < t1.year
		 	AND t2.SE_PRE_ENRR IS NOT NULL
         	AND t2.year > 2000 AND t2.year < 2016 
		 	ORDER BY t2.year DESC
		LIMIT 1) AS closest_non_null_before_pre,
		(SELECT SE_PRE_ENRR 
        	FROM statistic AS t3 
        	WHERE t3.Country = t1.Country 
        	AND t3.year > t1.Year
        	AND t3.SE_PRE_ENRR IS NOT NULL
         	AND t3.year > 2000 AND t3.year < 2016 
        	ORDER BY t3.Year ASC
        LIMIT 1) AS closest_non_null_after_pre,
		
        SE_PRM_ENRR AS prm_school_enrollment,
        (SELECT SE_PRM_ENRR 
         	FROM statistic AS t2
         	WHERE t2.country = t1.country
         	AND t2.year < t1.year
         	AND t2.SE_PRM_ENRR IS NOT NULL 
         	AND t2.year > 2000 AND t2.year < 2016 
		 	ORDER BY t2.year DESC
         LIMIT 1) AS closest_non_null_before_prm,
        -- Find the closest non-null value after the current row
        (SELECT SE_PRM_ENRR 
         FROM statistic AS t3 
         WHERE t3.country = t1.country 
           AND t3.year > t1.year
           AND t3.SE_PRM_ENRR IS NOT NULL  
         AND t3.year > 2000 AND t3.year < 2016 
         ORDER BY t3.year ASC
         LIMIT 1) AS closest_non_null_after_prm,
	

        SE_SEC_ENRR AS SEC_school_enrollment,
        -- Find the closest non-null value before the current row
        (SELECT SE_SEC_ENRR 
         FROM statistic AS t2
         WHERE t2.country = t1.country
         AND t2.year < t1.year
         AND t2.SE_SEC_ENRR IS NOT NULL 
         AND t2.year > 2000 AND t2.year < 2016 
		 ORDER BY t2.year DESC
         LIMIT 1) AS closest_non_null_before_sec,
        -- Find the closest non-null value after the current row
        (SELECT SE_SEC_ENRR 
         FROM statistic AS t3 
         WHERE t3.country = t1.country 
           AND t3.year > t1.year
           AND t3.SE_SEC_ENRR IS NOT NULL  
         AND t3.year > 2000 AND t3.year < 2016 
         ORDER BY t3.year ASC
         LIMIT 1) AS closest_non_null_after_sec

    FROM statistic t1 WHERE 
	t1.year > 2000 AND t1.year < 2016 
)


--Selecting updated projected values from closest_percent CTE
SELECT 
	a.country,
	a.year,
	--Replacing poverty nulls
    (CASE
	 	WHEN a.SI_POV_DAY1 IS NULL THEN
		(CASE
        	WHEN b.closest_non_null_before_pov IS NOT NULL AND b.closest_non_null_after_pov IS NOT NULL 
            	THEN CAST((b.closest_non_null_before_pov + b.closest_non_null_after_pov)/2 AS DECIMAL(6,2))
        	WHEN b.closest_non_null_before_pov IS NULL 
            	THEN b.closest_non_null_after_pov
        	WHEN b.closest_non_null_after_pov IS NULL 
           		THEN b.closest_non_null_before_pov
        	ELSE NULL
    	END)
	 ELSE a.SI_POV_DAY1
	 END) AS updated_pov,
	 
	--Replacing pre-primary education nulls
    (CASE
	 	WHEN a.SE_PRE_ENRR IS NULL THEN
		(CASE
        	WHEN b.closest_non_null_before_pre IS NOT NULL AND b.closest_non_null_after_pre IS NOT NULL 
            	THEN CAST((b.closest_non_null_before_pre + b.closest_non_null_after_pre)/2 AS DECIMAL(6,2))
        	WHEN b.closest_non_null_before_pre IS NULL 
            	THEN b.closest_non_null_after_pre
        	WHEN b.closest_non_null_after_pre IS NULL 
           		THEN b.closest_non_null_before_pre
        	ELSE NULL
    	END)
	 ELSE a.SE_PRE_ENRR
	 END) AS updated_pre,
	 
	--Replacing primary education nulls
    (CASE
	 	WHEN a.SE_PRM_ENRR IS NULL THEN
		(CASE
        	WHEN b.closest_non_null_before_prm IS NOT NULL AND b.closest_non_null_after_prm IS NOT NULL 
            	THEN CAST((b.closest_non_null_before_prm + b.closest_non_null_after_prm)/2 AS DECIMAL(6,2))
        	WHEN b.closest_non_null_before_prm IS NULL 
            	THEN b.closest_non_null_after_prm
        	WHEN b.closest_non_null_after_prm IS NULL 
           		THEN b.closest_non_null_before_prm
        	ELSE NULL
    	END)
	 ELSE a.SE_PRM_ENRR
	 END) AS updated_prm,
	 
	--Replacing secondary education nulls
    (CASE
	 	WHEN a.SE_SEC_ENRR IS NULL THEN
		(CASE
        	WHEN b.closest_non_null_before_sec IS NOT NULL AND b.closest_non_null_after_sec IS NOT NULL 
            	THEN CAST((b.closest_non_null_before_sec + b.closest_non_null_after_sec)/2 AS DECIMAL(6,2))
        	WHEN b.closest_non_null_before_sec IS NULL 
            	THEN b.closest_non_null_after_sec
        	WHEN b.closest_non_null_after_sec IS NULL 
           		THEN b.closest_non_null_before_sec
        	ELSE NULL
    	END)
	 ELSE a.SE_SEC_ENRR
	 END) AS updated_sec,
	 
	--Adding flags for whether a value is projected or not
	CASE WHEN a.SI_POV_DAY1 IS NULL THEN 1 ELSE 0 END AS null_flag_pov,
	CASE WHEN a.SE_PRE_ENRR IS NULL THEN 1 ELSE 0 END AS null_flag_pre,
	CASE WHEN a.SE_PRM_ENRR IS NULL THEN 1 ELSE 0 END AS null_flag_prm,
	CASE WHEN a.SE_SEC_ENRR IS NULL THEN 1 ELSE 0 END AS null_flag_sec

FROM statistic AS a
--Join to compare projected values to original data
JOIN
	closest_percent b
	ON a.country = b.country
	AND a.year = b.year
ORDER BY 1,2






-------------------------------------------------------VISUALISATION 1 - WORLD MAP -------------------------------------------------------------------
--Checking that % population data exists and adds to 100. Eritrea 2012-2018 and Timor-Leste 2001 are missing
SELECT  country,
		continent,
		year,
		Urban_population,
		Rural_population,
		Urban_population + Rural_population as Total_population ,
		Population
FROM statistic 
WHERE year > 2000 AND Urban_population + Rural_population IS NULL OR Population IS NULL AND YEAR > 2000

--Select statement for creating world map visualisation, year > 2000 is because a lot of countries are missing population data from year 2000.

SELECT 		country,
			continent,
			year,
			Population,
			NY_GDP_MKTP_CD AS GDP,
			CAST(NY_GDP_MKTP_CD/Population AS INT) AS GDP_Per_Capita,
			Urban_population,
			Rural_population, 
			Income_Classification,
			SP_DYN_LE00_IN AS Life_Expectancy,
			CO2_Emissions_MT FROM statistic 
WHERE year > 2000 and Population IS NOT NULL and NY_GDP_MKTP_CD IS NOT NULL

--Checking data for Eritrea, a lot is missing since 2012. Lack of data could be due to political reasons. Regime type is "Closed Autocracy".
SELECT * FROM statistic where Country = 'Eritrea'

--Summary of a countries GDP split
SELECT  country,
		continent,
		year,
		NY_GDP_MKTP_CD AS GDP,
		NE_EXP_GNFS_ZS AS Exports,
		NE_IMP_GNFS_ZS AS Imports,
		NE_EXP_GNFS_ZS-NE_IMP_GNFS_ZS AS Exports_Minus_Imports
FROM statistic ORDER BY 1,3

--Countries with dollar values of exports and imports along with "Economy Type" depending on whether imports > exports or not.
--Dollars are converted to millions from exact dollar value
SELECT 
	country,
	continent,
	year,
	CAST(NY_GDP_MKTP_CD/1000000 AS INT) AS GDP_Millions$,
	--NE_EXP_GNFS_ZS AS Exports,
	--NE_IMP_GNFS_ZS AS Imports,
	CAST(NY_GDP_MKTP_CD*NE_EXP_GNFS_ZS/(100*1000000) AS INT) AS Exports_Millions$,
	CAST(NY_GDP_MKTP_CD*NE_IMP_GNFS_ZS/(100*1000000) AS INT) AS Exports_Millions$,
	NE_EXP_GNFS_ZS-NE_IMP_GNFS_ZS AS Exports_Minus_Imports,
	CASE
		WHEN NY_GDP_MKTP_CD*(NE_EXP_GNFS_ZS - NE_IMP_GNFS_ZS)/100 > 0 THEN 'Exporter'
	    WHEN NY_GDP_MKTP_CD*(NE_EXP_GNFS_ZS - NE_IMP_GNFS_ZS)/100 < 0 THEN 'Importer'
 	ELSE 'Balanced'
	END AS Economy_Type
FROM statistic
WHERE year > 2000 AND year < 2016
ORDER BY 1,3

----------------------------------------------------------ELECTRICITY VISUALISATION-----------------------------------------------------------
--Stats for electricity visualisation. No renewable energy production data from 2016-2018 so will be omitting these.
SELECT  country,
		continent,
		year,
		EG_FEC_RNEW_ZS AS Renewable_Consumption,
		EG_ELC_RNEW_ZS AS Renewable_Production,
		EG_ELC_ACCS_ZS AS Electricity_Access
FROM statistic
WHERE year > 2000 AND year < 2016
	AND EG_ELC_ACCS_ZS IS NOT NULL


----------------------------------------------------------INFRASTRUCTURE VISUALISATION-----------------------------------------------------------


--Checking infastructure values 
SELECT  country,
		continent,
		year,
		IT_MOB_2GNTWK as Access_2G,
		IT_MOB_3GNTWK as Access_3G,
		EG_ELC_ACCS_ZS as Internet_Access
FROM statistic
WHERE year > 2000 AND year < 2016
AND IT_MOB_2GNTWK IS NOT NULL
AND IT_MOB_3GNTWK IS NOT NULL
AND EG_ELC_ACCS_ZS IS NOT NULL


--Counting nulls in columns
SELECT
	Country,
	SUM(CASE WHEN Mobile_Network IS NULL THEN 1 ELSE 0 END),
	SUM(CASE WHEN Male_Unemployment IS NULL THEN 1 ELSE 0 END),
	SUM(CASE WHEN Female_Unemployment IS NULL THEN 1 ELSE 0 END),
	SUM(CASE WHEN Electricity_Access IS NULL THEN 1 ELSE 0 END)
FROM cte_infra
GROUP BY Country
ORDER BY 1;


--CTE to combine 2G and 3G access data into one value to remove some nulls. Column is called mobile_network
WITH cte_infra AS (
SELECT
	country,
	year,
	IT_MOB_2GNTWK AS gen2,
	IT_MOB_3GNTWK AS gen3,
	CASE WHEN IT_MOB_2GNTWK IS NULL AND IT_MOB_3GNTWK IS NULL THEN NULL
		 WHEN IT_MOB_2GNTWK + IT_MOB_3GNTWK > 99.999 THEN 100
		 ELSE IT_MOB_2GNTWK + IT_MOB_3GNTWK END AS Mobile_Network,
	SL_TLF_UEM AS Male_Unemployment,
	SL_TLF_UEF AS Female_Unemployment,
	EG_ELC_ACCS_ZS AS Electricity_Access
	FROM statistic
	WHERE year > 2000 AND year < 2016
	)

select
	country,
	year,
	Mobile_Network,
	Male_Unemployment,
	Female_Unemployment,
	Electricity_Access
FROM cte_infra
ORDER BY 1,2




















