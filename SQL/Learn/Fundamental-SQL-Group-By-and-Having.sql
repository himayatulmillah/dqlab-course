/* 
-------------------------------------------------------------------
| MODUL : Fundamental SQL Group By and Having                     |
| SOURCE: https://academy.dqlab.id/main/package/practice/291?pf=0 |
-------------------------------------------------------------------
*/

--------------------
-- 1. Pendahuluan --
--------------------

/* Pengenalan Table - Customer
   -------------------------------
   Menampilkan data dari tabel customer.*/
SELECT
    *
FROM
    customer
;

/* Pengenalan Table - Product
   -------------------------------
   Menampilkan data dari tabel product.*/
SELECT
    *
FROM
    product
;

/* Pengenalan Table - Subscription
   -------------------------------
   Menampilkan data dari tabel subscription.*/
SELECT
    *
FROM
    subscription
;

/* Pengenalan Table - Invoice
   -------------------------------
   Menampilkan data dari tabel invoice.*/
SELECT
    *
FROM
    invoice
;

/* Pengenalan Table - Payment
   -------------------------------
   Menampilkan data dari tabel payment.*/
SELECT
    *
FROM
    payment
;

--------------------------
-- 2. Penggunaan Having --
--------------------------

/* Contoh Penggunaan Having
   -------------------------------
   Menampilkan customer_id yang melakukan perpindahan subscription.*/
SELECT
    customer_id
FROM
    subscription
GROUP BY
    customer_id
HAVING 
    COUNT(customer_id) > 1
;

/* Menampilkan Konsumen yang Berubah Berlangganan
   -------------------------------
   Menampilkan customer_id, product_id dan subscription_date berdasarkan 
   customer_id yang melakukan perpindahan subscription.*/
SELECT
    customer_id, 
    product_id,
    subscription_date
FROM
    subscription
WHERE
    customer_id IN (
        SELECT
            customer_id
        FROM
            subscription
        GROUP BY
            customer_id
        HAVING
            COUNT(customer_id) > 1
    )
ORDER BY
    customer_id ASC
;

/* Menampilkan Detail Konsumen
   -------------------------------
   Menampilkan detail konsumen berdasarkan customer_id 
   yang melakukan perpindahan subscription.*/
SELECT
    b.name,
    b.address,
    b.phone,
    a.product_id,
    a.subscription_date
FROM
    subscription a 
JOIN
    customer b 
ON
    a.customer_id = b.id
WHERE
    b.id IN (
        SELECT
            customer_id
        FROM
            subscription
        GROUP BY
            customer_id
        HAVING
            COUNT(customer_id) > 1
    )
ORDER BY
    b.id ASC
;

-------------------------------------------------
-- 3. Penggunaan MAX, MIN dan AVG Dalam Having --
-------------------------------------------------

/* Penggunaan Fungsi MAX pada Having
   -------------------------------
   Menampilkan maksimal total_price untuk setiap product_id 
   dari tabel invoice */
SELECT
    product_id,
    MAX(total_price) AS total
FROM
    invoice
GROUP BY
    product_id
;
/* Menampilkan maksimal total_harga untuk setiap product_id 
   dari tabel invoice dengan nilai maksimal diatas 100K.*/
SELECT
    product_id,
    MAX(total_price) AS total
FROM
    invoice
GROUP BY
    product_id
HAVING
    MAX(total_price) > 100000
;
/* Menampilkan maksimal pinalty untuk setiap product_id 
   dari tabel invoice dengan nilai maksimal diatas 30K.*/
SELECT
    product_id,
    MAX(pinalty) AS total
FROM
    invoice
GROUP BY
    product_id
HAVING
    MAX(pinalty) > 30000
;

/* Penggunaan Fungsi MIN pada Having
   -------------------------------
   Menampilkan minimal total_price untuk setiap product_id 
   dari tabel invoice */
SELECT
    product_id,
    MIN(total_price) AS total
FROM
    invoice
GROUP BY
    product_id
;
/* Menampilkan minimal total_harga untuk setiap product_id 
   dari tabel invoice dengan nilai minimal dibawah 500K.*/
SELECT
    product_id,
    MIN(total_price) AS total
FROM
    invoice
GROUP BY
    product_id
HAVING
    MIN(total_price) < 500000
;
/* Menampilkan minimal pinalty untuk setiap product_id 
   dari tabel invoice dengan nilai minimal dibawah 50K.*/
SELECT
    product_id,
    MIN(pinalty) AS total
FROM
    invoice
GROUP BY
    product_id
HAVING
    MIN(pinalty) < 50000
;

/* Penggunaan Fungsi AVG pada Having
   -------------------------------
   Menampilkan rata-rata total_price untuk setiap product_id 
   dari tabel invoice */
SELECT
    product_id,
    AVG(total_price) AS total
FROM
    invoice
GROUP BY
    product_id
;
/* Menampilkan rata-rata total_harga untuk setiap product_id 
   dari tabel invoice dengan nilai rata-rata diatas 100K.*/
SELECT
    product_id,
    AVG(total_price) AS total
FROM
    invoice
GROUP BY
    product_id
HAVING
    AVG(total_price) > 100000
;
/* Menampilkan rata-rata pinalty untuk setiap product_id 
   dari tabel invoice dengan nilai rata-rata diatas 30K.*/
SELECT
    product_id,
    AVG(pinalty) AS total
FROM
    invoice
GROUP BY
    product_id
HAVING
    AVG(pinalty) > 30000
;

/* Mini Quiz
   -------------------------------
   Menampilkan product_id, rata-rata pinalty dan jumlah customer_id untuk 
   setiap product_id dari tabel invoice dengan jumlah customer_id > 20*/
SELECT
    product_id,
    AVG(pinalty),
    COUNT(customer_id) AS total
FROM
    invoice
GROUP BY
    product_id
HAVING
    COUNT(customer_id) > 20
;