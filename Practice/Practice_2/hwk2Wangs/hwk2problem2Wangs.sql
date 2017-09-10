-- All questions can be answer in navigator, but I still provide SQL queries here.
-- a. How many databases are created by the script?
SELECT 
    COUNT(*)
FROM
    information_schema.SCHEMATA
WHERE
    schema_name NOT IN ('information_schema' , 'mysql', 'performance_schema');
-- The result is 3

-- b. List the database names and the tables created for each database
SELECT 
    SCHEMA_NAME
FROM
    information_schema.SCHEMATA
WHERE
    schema_name NOT IN ('information_schema' , 'mysql', 'performance_schema');
-- the database names are:
-- ap
-- ex
-- om

SELECT 
    TABLE_SCHEMA, TABLE_NAME
FROM
    information_schema.tables
WHERE
    TABLE_SCHEMA NOT IN ('information_schema' , 'mysql', 'performance_schema');
/*    
the table names are:
database tables
ap	general_ledger_accounts
ap	invoice_archive
ap	invoice_line_items
ap	invoices
ap	terms
ap	vendor_contacts
ap	vendors
ex	active_invoices
ex	color_sample
ex	customers
ex	date_sample
ex	departments
ex	employees
ex	float_sample
ex	null_sample
ex	paid_invoices
ex	projects
ex	string_sample
om	customers
om	items
om	order_details
om	orders
*/

-- c. How many records does the script insert into the om.order_details table?

SELECT 
    COUNT(*)
FROM
    om.order_details;

-- the rasult is 68

-- d. What is the primary key for the om.customers table?
SHOW 
	INDEX 
FROM 
	om.customers 
WHERE 
	Key_name = 'PRIMARY' ;
    
-- it shows the column_name of primary key is customer_id

-- e. Write SQL queries to answer the following questions on the om database. Include a comment that specifies the problem number before each SQL statement i.e. 2.f, 2.g
-- f. Select all fields from the table orders
SELECT 
    *
FROM
    om.orders;

-- g. Select the fields title and artist from the om.items table
SELECT 
    title, artist
FROM
    om.items
	