/*
	CHECKS FOR CRM_CUST_INFO TABLE
*/
/*
	CHECKS FOR cst_id COLUMN:
		1. CHECK FOR DUPLICATES
		2. CHECK FOR NULL VALUES
		3. CHECK FOR DATA TYPE
		4. RANGE AND LOGIC CHECK (CHECK FOR NEGATIVE VALUES AND ZEROS)
*/


-- CHECK FOR DUPLICATES	
SELECT 
	cst_id,
	COUNT(*) AS duplicates
FROM 
	silver.crm_cust_info
GROUP BY 
	cst_id
HAVING
	COUNT(*) > 1;

-- CHECK FOR NULL VALUES
SELECT 
	cst_id
FROM
	silver.crm_cust_info
WHERE
	cst_id IS NULL;



-- CHECK FOR DATA TYPE
SELECT 
	cst_id
FROM
	silver.crm_cust_info
WHERE 
	TRY_CAST(cst_id AS INT) IS NULL AND cst_id IS NOT NULL;


-- RANGE AND LOGIC CHECK (CHECK FOR NEGATIVE VALUES AND ZEROS)
SELECT 
	cst_id
FROM
	silver.crm_cust_info
WHERE 
	cst_id <= 0 ;



/*
	CHECKS FOR cst_key COLUMN:
		1. CHECK FOR UNWANTED SPACES
		2. CHECK FOR NULL VALUES
		3. UNIQUENESS CHECK
		4. PATTERN / FORMAT CHECK
		5. CONSISTENCY CHECK WITH cst_id
*/

-- CHECK FOR UNWANTED SPACES
SELECT	
	cst_key
FROM
	silver.crm_cust_info
WHERE
	cst_key != TRIM(cst_key);

-- CHECK FOR NULL VALUES
SELECT 
	cst_key
FROM
	silver.crm_cust_info
WHERE
	cst_key IS NULL;

-- UNIQUENESS CHECK
SELECT 
	cst_key,
	Count(cst_key) AS unique_values
FROM
	silver.crm_cust_info
GROUP BY
	cst_key
HAVING
	COUNT(cst_key) > 1;

-- Pattern / Format Check
SELECT
	cst_key
FROM
	silver.crm_cust_info
WHERE 
	len(cst_key) != 10 OR cst_key NOT like 'AW%'; 

-- CONSISTENCY CHECK WITH cst_id
SELECT 
	cst_id,
	cst_key
FROM
	silver.crm_cust_info
WHERE
	SUBSTRING(cst_key,6,LEN(cst_key)) != cst_id;

	
/*
	CHECKS FOR cst_firstname COLUMN:
		1. CHECK FOR UNWANTED SPACES
		2. NULL / EMPTY CHECK
		3. SPECIAL CHARACTERS / INVALID CHARACTERS CHECK
*/

-- CHECK FOR UNWANTED SPACES
SELECT 
	cst_firstname
FROM
	silver.crm_cust_info
WHERE
	cst_firstname != TRIM(cst_firstname);

-- NULL / EMPTY CHECK
SELECT 
	cst_firstname
FROM 
	silver.crm_cust_info
WHERE
	cst_firstname IS NULL OR cst_firstname = '';


-- SPECIAL CHARACTERS / INVALID CHARACTERS CHECK 
SELECT
	TRIM(cst_firstname)
FROM
	silver.crm_cust_info
WHERE
	TRIM(cst_firstname) like '%[^a-zA-Z]%';


/*
	CHECKS FOR cst_lastname COLUMN:
		1. CHECK FOR UNWANTED SPACES
		2. NULL / EMPTY CHECK
		3. SPECIAL CHARACTERS / INVALID CHARACTERS CHECK
*/

-- CHECK FOR UNWANTED SPACES
SELECT 
	cst_lastname
FROM
	silver.crm_cust_info
WHERE
	cst_lastname != TRIM(cst_lastname);

-- NULL / EMPTY CHECK
SELECT 
	cst_lastname
FROM 
	silver.crm_cust_info
WHERE
	cst_lastname IS NULL OR cst_lastname = '';


-- SPECIAL CHARACTERS / INVALID CHARACTERS CHECK 
SELECT
	TRIM(cst_lastname)
FROM
	silver.crm_cust_info
WHERE
	TRIM(cst_lastname) like '%[^a-zA-Z]%';


/*
	CHECKS FOR cst_gndr COLUMN:
		1. CHECK FOR UNWANTED SPACES
		2. NULL / EMPTY CHECK
		3. DISTINCT VALUES CHECK
*/

-- CHECK FOR UNWANTED SPACES
SELECT
	cst_gndr
FROM
	silver.crm_cust_info
WHERE
	cst_gndr != TRIM(cst_gndr);

-- NULL / EMPTY CHECK
SELECT 
	TRIM(cst_gndr)
FROM 
	silver.crm_cust_info
where 
	TRIM(cst_gndr) IS NULL OR TRIM(cst_gndr) = '';

-- DISTINCT VALUES CHECK
SELECT DISTINCT
	cst_gndr
FROM
	silver.crm_cust_info;


/*
	CHECKS FOR cst_marital_status COLUMN:
		1. CHECK FOR UNWANTED SPACES
		2. NULL / EMPTY CHECK
		3. DISTINCT VALUES CHECK
*/

SELECT
	cst_marital_status
FROM
	silver.crm_cust_info
WHERE
	cst_gndr != TRIM(cst_gndr);

-- NULL / EMPTY CHECK
SELECT 
	TRIM(cst_marital_status)
FROM 
	silver.crm_cust_info
where 
	TRIM(cst_marital_status) IS NULL OR TRIM(cst_marital_status) = '';

-- DISTINCT VALUES CHECK
SELECT DISTINCT
	cst_marital_status
FROM
	silver.crm_cust_info;


/*
	CHECKS FOR cst_create_date COLUMN:
		1. NULL CHECK
		2. FUTURE DATES CHECK
		3. INVALID DATE FORMAT / OUT OF RANGE CHECK
*/

-- NULL / EMPTY CHECK
SELECT 
	cst_create_date
FROM 
	silver.crm_cust_info
where 
	cst_create_date IS NULL;

-- FUTURE DATES CHECK
SELECT 
	cst_create_date
FROM 
	silver.crm_cust_info
WHERE 
	cst_create_date > GETDATE();

-- INVALID DATE FORMAT / OUT OF RANGE CHECK
SELECT 
	cst_create_date
FROM 
	silver.crm_cust_info
WHERE
	cst_create_date < '1950-01-01';