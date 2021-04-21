/* 
----------------------------------------------------------------------
| MODUL : Project Data Analysis for Retail: Sales Performance Report |
| SOURCE: https://academy.dqlab.id/main/package/project/182?pf=0     |
----------------------------------------------------------------------
*/

----------------------------------------
-- 1. DQLab Store Overall Performance --
----------------------------------------

/* Overall Performance by Year
   -------------------------------
   Menampilkan total penjualan (sales) dan jumlah order (number_of_order)
   dari tahun (years) 2009 sampai 2012.*/
SELECT
    YEAR(order_date) AS years,
    SUM(sales) AS sales,
    COUNT(DISTINCT order_id) AS number_of_order
FROM
    dqlab_sales_store
WHERE
    YEAR(order_date) BETWEEN 2009 AND 2012 AND
    order_status = 'order finished'
GROUP BY
    YEAR(order_date)
;

/* Overall Performance by Product Sub Category
   -------------------------------
   Menampilkan total penjualan (sales) berdasarkan product_sub_category
   dari tahun (years) 2011 sampai 2012.*/
SELECT
    YEAR(order_date) AS years,
    product_sub_category,
    SUM(sales) AS sales
FROM
    dqlab_sales_store
WHERE
    YEAR(order_date) BETWEEN 2011 AND 2012 AND
	order_status = 'order finished'
GROUP BY
    YEAR(order_date),
    product_sub_category
ORDER BY
	YEAR(order_date),
    sales DESC
;


-----------------------------------------------------------
-- 2. DQLab Store Promotion Effectiveness and Efficiency --
-----------------------------------------------------------

/* Promotion Effectiveness and Efficiency by Years
   -------------------------------
   Menampilkan total penjualan (sales) dan total diskon (promotion_value)
   beserta burn rate total diskon terhadap total penjualan berdasarkan
   tahun dari tahun (years) 2011 sampai 2012.*/
SELECT
    YEAR(order_date) AS years,
    SUM(sales) AS sales,
    SUM(discount_value) AS promotion_value,
    ROUND((SUM(discount_value)/SUM(sales)) * 100, 2) AS burn_rate_percentage
FROM
    dqlab_sales_store
WHERE
    order_status = 'order finished'
GROUP BY
    YEAR(order_date)
;

/* Promotion Effectiveness and Efficiency by Sub Category
   -------------------------------
   Menampilkan total penjualan (sales) dan total diskon (promotion_value)
   beserta burn rate total diskon terhadap total penjualan berdasarkan
   product_sub_category dan product_category untuk tahun (years) 2012.*/
SELECT
    YEAR(order_date) AS years,
    product_sub_category,
    product_category,
    SUM(sales) AS sales,
    SUM(discount_value) AS promotion_value,
    ROUND((SUM(discount_value)/SUM(sales) * 100), 2) AS burn_rate_percentage
FROM
    dqlab_sales_store
WHERE
    YEAR(order_date) = 2012 AND
    order_status = 'order finished'
GROUP BY
    YEAR(order_date),
    product_sub_category,
    product_category
ORDER BY
    sales DESC
;

---------------------------
-- 3. Customer Analytics --
---------------------------

/* Customers Transactions by Year
   -------------------------------
   Menampilkan jumlah customer yang melakukan transaksi 
   berdasarkan tahun dari tahun (years) 2009 sampai 2012.*/
SELECT
    YEAR(order_date) AS years,
    COUNT(DISTINCT customer) AS number_of_customer
FROM
    dqlab_sales_store
WHERE
    order_status = 'order finished'
GROUP BY
    YEAR(order_date)
;