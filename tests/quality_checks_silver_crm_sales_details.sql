/*
	CHECKS FOR SLS_ORD_NUM COLUMN:
		1. CHECK FOR UNWANTED SPACES
		2. CHECK FOR NULL VALUES
		3. PATTERN AND LENGTH CHECK
*/
SELECT 
    sls_ord_num
FROM 
    silver.crm_sales_details
WHERE 
    sls_ord_num != TRIM(sls_ord_num)
    OR sls_ord_num IS NULL 
    OR sls_ord_num = ''
    OR sls_ord_num NOT LIKE 'SO%' 
    OR LEN(sls_ord_num) != 7;

/*
	CHECKS FOR SLS_PRD_KEY COLUMN:
		1. CHECK FOR UNWANTED SPACES
		2. CHECK FOR NULL VALUES
		3. REFERENTIAL INTEGRITY CHECK WITH CRM_PRD_INFO
*/
SELECT 
    s.sls_prd_key
FROM 
    silver.crm_sales_details s
LEFT JOIN 
    silver.crm_prd_info p ON s.sls_prd_key = p.prd_key
WHERE 
    s.sls_prd_key != TRIM(s.sls_prd_key)
    OR s.sls_prd_key IS NULL 
    OR s.sls_prd_key = ''
    OR p.prd_key IS NULL;

/*
	CHECKS FOR SLS_CUST_ID COLUMN:
		1. CHECK FOR NULL VALUES OR INVALID IDS
		2. REFERENTIAL INTEGRITY CHECK WITH CRM_CUST_INFO
*/
SELECT 
    s.sls_cust_id
FROM 
    silver.crm_sales_details s
LEFT JOIN 
    silver.crm_cust_info c ON s.sls_cust_id = c.cst_id
WHERE 
    s.sls_cust_id IS NULL 
    OR s.sls_cust_id <= 0 
    OR c.cst_id IS NULL;


/*
	CHECKS FOR SLS_ORDER_DT COLUMN:
		1. CHECK FOR NULL VALUES
		2. CHECK FOR INVALID LENGTH OR FORMAT (EXPECTING 8 DIGITS)
*/
SELECT 
    sls_order_dt
FROM 
    silver.crm_sales_details
WHERE 
    sls_order_dt IS NULL 
    OR sls_order_dt <= 0 
    OR LEN(CAST(sls_order_dt AS VARCHAR)) != 8;

/*
	CHECKS FOR SLS_SHIP_DT COLUMN:
		1. CHECK FOR NULL VALUES
		2. LOGICAL CHECK (SHIPPING DATE CANNOT BE BEFORE ORDER DATE)
*/
SELECT 
    sls_ord_num,
    sls_order_dt,
    sls_ship_dt
FROM 
    silver.crm_sales_details
WHERE 
    sls_ship_dt IS NULL 
    OR sls_ship_dt < sls_order_dt;

/*
	CHECKS FOR SLS_DUE_DT COLUMN:
		1. CHECK FOR NULL VALUES
		2. LOGICAL CHECK (DUE DATE CANNOT BE BEFORE ORDER DATE)
*/
SELECT 
    sls_ord_num,
    sls_order_dt,
    sls_due_dt
FROM 
    silver.crm_sales_details
WHERE 
    sls_due_dt IS NULL 
    OR sls_due_dt < sls_order_dt;

/*
	CHECKS FOR SLS_SALES COLUMN:
		1. CHECK FOR NULL VALUES
		2. CHECK FOR NEGATIVE OR ZERO VALUES
		3. LOGICAL CHECK (SALES MUST MATCH QUANTITY * PRICE)
*/
SELECT 
    sls_sales,
    sls_quantity,
    sls_price
FROM 
    silver.crm_sales_details
WHERE 
    sls_sales IS NULL 
    OR sls_sales <= 0 
    OR sls_sales != sls_quantity * sls_price;

/*
	CHECKS FOR SLS_QUANTITY COLUMN:
		1. CHECK FOR NULL VALUES
		2. CHECK FOR NEGATIVE OR ZERO VALUES
*/
SELECT 
    sls_quantity
FROM 
    silver.crm_sales_details
WHERE 
    sls_quantity IS NULL 
    OR sls_quantity <= 0;

/*
	CHECKS FOR SLS_PRICE COLUMN:
		1. CHECK FOR NULL VALUES
		2. CHECK FOR NEGATIVE OR ZERO VALUES
*/
SELECT 
    sls_price
FROM 
    silver.crm_sales_details
WHERE 
    sls_price IS NULL 
    OR sls_price <= 0;
