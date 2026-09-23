/*
	CHECKS FOR ERP_CUST_AZ12 TBALE
*/

/*
	CHECKS FOR CID COLUMN (Customer ID):
		1. CHECK FOR UNWANTED SPACES
		2. CHECK FOR NULL VALUES
*/
SELECT 
    cid
FROM 
    silver.erp_cust_az12
WHERE 
    cid != TRIM(cid)
    OR cid IS NULL 
    OR cid = '';

/*
	CHECKS FOR BDATE COLUMN (Birth Date):
		1. CHECK FOR NULL VALUES
		2. LOGICAL CHECK (BIRTH DATE CANNOT BE IN THE FUTURE)
*/
SELECT 
    bdate
FROM 
    silver.erp_cust_az12
WHERE 
    bdate IS NULL 
    OR bdate > GETDATE();

/*
	CHECKS FOR GEN COLUMN (Gender):
		1. CHECK FOR UNWANTED SPACES
		2. CHECK FOR INVALID OR UNEXPECTED VALUES (NOT MATCHING M, F, MALE, FEMALE)
*/
SELECT 
    gen
FROM 
    silver.erp_cust_az12
WHERE 
    gen != TRIM(gen)
    OR UPPER(TRIM(gen)) NOT IN ('F', 'FEMALE', 'M', 'MALE') AND gen IS NOT NULL;


/*
	CHECKS FOR ERP_LOC_A101 TBALE
*/


/*
	CHECKS FOR CID COLUMN (Customer ID):
		1. CHECK FOR UNWANTED SPACES
		2. CHECK FOR NULL VALUES
*/
SELECT 
    cid
FROM 
    silver.erp_loc_a101
WHERE 
    cid != TRIM(cid)
    OR cid IS NULL 
    OR cid = '';

/*
	CHECKS FOR CNTRY COLUMN (Country):
		1. CHECK FOR UNWANTED SPACES
		2. CHECK FOR NULL VALUES
		3. STANDARDIZATION & NORMALIZATION CHECK (e.g., handling variations like 'US'/'USA' or blanks)
*/
SELECT 
    cntry
FROM 
    silver.erp_loc_a101
WHERE 
    cntry != TRIM(cntry)
    OR cntry IS NULL 
    OR cntry = '';



/*
	CHECKS FOR ERP_PX_CAT_G1V2 TBALE
*/

/*
	CHECKS FOR ID COLUMN:
		1. CHECK FOR UNWANTED SPACES
		2. CHECK FOR NULL VALUES
*/
SELECT 
    id
FROM 
    silver.erp_px_cat_g1v2
WHERE 
    id != TRIM(id)
    OR id IS NULL 
    OR id = '';

/*
	CHECKS FOR CAT COLUMN (Category):
		1. CHECK FOR UNWANTED SPACES
		2. CHECK FOR NULL VALUES
*/
SELECT 
    cat
FROM 
    silver.erp_px_cat_g1v2
WHERE 
    cat != TRIM(cat)
    OR cat IS NULL 
    OR cat = '';

/*
	CHECKS FOR SUBCAT COLUMN (Subcategory):
		1. CHECK FOR UNWANTED SPACES
		2. CHECK FOR NULL VALUES
*/
SELECT 
    subcat
FROM 
    silver.erp_px_cat_g1v2
WHERE 
    subcat != TRIM(subcat)
    OR subcat IS NULL 
    OR subcat = '';

/*
	CHECKS FOR MAINTENANCE COLUMN:
		1. CHECK FOR UNWANTED SPACES
		2. CHECK FOR INVALID OR UNEXPECTED VALUES (EXPECTING YES/NO)
*/
SELECT 
    maintenance
FROM 
    silver.erp_px_cat_g1v2
WHERE 
    maintenance != TRIM(maintenance)
    OR UPPER(TRIM(maintenance)) NOT IN ('YES', 'NO') 
    AND maintenance IS NOT NULL;