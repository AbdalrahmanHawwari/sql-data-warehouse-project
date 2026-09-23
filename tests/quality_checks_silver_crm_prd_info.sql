/*
	CHECKS FOR CRM_PRD_INFO TABLE
*/
/*
	CHECKS FOR prd_id COLUMN:
		1. CHECK FOR DUPLICATES
		2. CHECK FOR NULL VALUES
		3. CHECK FOR DATA TYPE
		4. RANGE AND LOGIC CHECK (CHECK FOR NEGATIVE VALUES AND ZEROS)
*/

-- CHECK FOR DUPLICATES	
SELECT 
	prd_id,
	COUNT(*) AS duplicates
FROM 
	silver.crm_prd_info
GROUP BY 
	prd_id
HAVING
	COUNT(*) > 1;

-- CHECK FOR NULL VALUES
SELECT 
	prd_id
FROM
	silver.crm_prd_info
WHERE
	prd_id IS NULL;



-- CHECK FOR DATA TYPE
SELECT 
	prd_id
FROM
	silver.crm_prd_info
WHERE 
	TRY_CAST(prd_id AS INT) IS NULL AND prd_id IS NOT NULL;


-- RANGE AND LOGIC CHECK (CHECK FOR NEGATIVE VALUES AND ZEROS)
SELECT 
	prd_id
FROM
	silver.crm_prd_info
WHERE 
	prd_id <= 0 ;


/*
	CHECKS FOR prd_key COLUMN:
		1. CHECK FOR UNWANTED SPACES
		2. CHECK FOR NULL VALUES
		3. UNIQUENESS CHECK
		4. CONSISTENCY CHECK WITH OTHER TABLES
*/

-- CHECK FOR UNWANTED SPACES
SELECT 
	prd_key
FROM
	silver.crm_prd_info
WHERE
	prd_key != TRIM(prd_key);


-- CHECK FOR NULL VALUES
SELECT 
	prd_key
FROM
	silver.crm_prd_info
WHERE
	prd_key IS NULL OR prd_key = '';

-- UNIQUENESS CHECK
SELECT 
	prd_key,
	COUNT(prd_key)
FROM
	silver.crm_prd_info
GROUP BY prd_key
HAVING COUNT(prd_key) > 1;

SELECT 
	*
FROM
	silver.crm_prd_info
WHERE
	prd_key = 'AC-HE-HL-U509';


/*
	for the consistincy with other tables we have discovered that the prd_key must be splited into cat_id and prd_key 
*/

/*
	CHECKS FOR prd_nm COLUMN:
		1. CHECK FOR UNWANTED SPACES
		2. NULL / EMPTY CHECK
*/

SELECT 
	prd_nm
FROM
	silver.crm_prd_info
WHERE
	prd_nm != TRIM(prd_nm) OR prd_nm IS NULL OR prd_nm = '';


/*
	CHECKS FOR prd_cost COLUMN:
		1. NULL AND DISTINCT VALUES CHECK
*/

SELECT DISTINCT
	prd_cost
FROM
	silver.crm_prd_info;

SELECT 
	prd_cost
FROM
	silver.crm_prd_info
WHERE
	prd_cost IS NULL;


/*
	CHECKS FOR prd_line COLUMN:
		1. CHECK FOR UNWANTED SPACES
		2. NULL / EMPTY CHECK
		3. DISTINCT VALUES CHECK
*/

-- CHECK FOR UNWANTED SPACES
SELECT
	prd_line
FROM
	silver.crm_prd_info
WHERE
	prd_line != TRIM(prd_line);

-- NULL / EMPTY CHECK
SELECT 
	TRIM(prd_line)
FROM 
	silver.crm_prd_info
where 
	TRIM(prd_line) IS NULL OR TRIM(prd_line) = '';

-- DISTINCT VALUES CHECK
SELECT DISTINCT
	prd_line
FROM
	silver.crm_prd_info



/*
	CHECKS FOR PRODUCT DATE COLUMNS:
		1. CHECK FOR NULL VALUES IN THE START DATE
		2. CHECK IF START_DATE > END_DATE
*/


-- CHECK FOR NULL VALUES IN THE START DATE
SELECT 
    prd_id, prd_key, prd_start_dt
FROM 
    silver.crm_prd_info
WHERE 
    prd_start_dt IS NULL;

-- CHECK IF START_DATE > END_DATE
SELECT 
    prd_id, 
    prd_key, 
    prd_start_dt, 
    prd_end_dt
FROM 
    silver.crm_prd_info
WHERE 
    prd_start_dt > prd_end_dt;
