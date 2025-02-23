-- Check for unwanted Spaces
-- Expectation: No Results
SELECT cst_ lastname
FROM bronze. crm_cust_info
WHERE cst_lastname != TRIM(cst_lastname )


--String Transformarion

SELECT
cst_id,
cst_key,
TRIM(cst_firstname) AS cst_firstname,
TRIM(cst_lastname) AS cst_lastname,
est marital status,
CASE WHEN UPPER(TRIM(cst_gndr)) = 'F' THEN 'Female'
WHEN UPPER(TRIM(cst_gndr)) = 'M' THEN 'Male'
ELSE 'n/a'
END cst_gndr
FROM bronze. crm_cust_info