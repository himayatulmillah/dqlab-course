/* 
---------------------------------------------------------------------------
| MODUL : Project Data Analysis for B2B Retail: Customer Analytics Report |
| SOURCE: https://academy.dqlab.id/main/package/project/246?pf=0          |
---------------------------------------------------------------------------
*/

-------------------------
-- 1. Pengenalan Table --
-------------------------

/* Memahami Table
   -------------------------------
   Menampilkan 5 baris pertama dari tabel orders_1, orders_2 dan customer.*/
SELECT * FROM orders_1 LIMIT 5;
SELECT * FROM orders_2 LIMIT 5;
SELECT * FROM customer LIMIT 5;


-------------------------------------------------
-- 2. Bagaimana Pertumbuhan Penjualan Saat Ini --
-------------------------------------------------

/* Total Penjualan dan Revenue pada Q1 (Jan-Mar) dan Q2 (Apr-Jun)
   -------------------------------
   Menampilkan total_penjualan dan revenue pada 
   Q1 (orders_1) dan Q2 (orders_2).*/

SELECT
   SUM(quantity) AS total_penjualan,
   SUM(quantity * priceeach) AS revenue 
FROM
   orders_1
WHERE
   status = 'Shipped'
;
SELECT
   SUM(quantity) AS total_penjualan,
   SUM(quantity * priceeach) AS revenue
FROM
   orders_2
WHERE
   status = 'Shipped'
;

/* Menghitung Persentasi Keseluruhan Penjualan
   -------------------------------
   Menampilkan total_penjualan dan revenue dengan 
   menggabungkan Q1 (orders_1) dan Q2 (orders_2).*/
SELECT
   quarter,
   SUM(quantity) AS total_penjualan,
   SUM(quantity*priceeach) AS revenue
FROM
   (
      SELECT
         orderNumber,
         status,
         quantity,
         priceeach,
         '1' AS quarter
      FROM
         orders_1
      UNION
      SELECT
         orderNumber,
         status,
         quantity,
         priceeach,
         '2' AS quarter
      FROM
      orders_2
   ) AS tabel_a
WHERE
   status = 'Shipped'
GROUP BY
   quarter
;


---------------------------
-- 3. Customer Analytics --
---------------------------

/* Apakah Jumlah Customers XYZ.com semakin bertambah?
   -------------------------------
   Menampilkan perbandingan jumlah customer yang registrasi
   untuk setiap periode.*/
SELECT
   quarter,
   COUNT(DISTINCT customerID) AS total_customers
FROM
   (
      SELECT
         customerID,
         createDate,
         QUARTER(createDate) AS quarter
      FROM
         customer
      WHERE
         createDate BETWEEN '2004-01-01' AND '2004-06-30'
   ) AS tabel_b
GROUP BY
   quarter
;

/* Seberapa Banyak Customers Tersebut yang Sudah Melakukan Transaksi?
   -------------------------------
   Menampilkan perbandingan jumlah customer terdaftar yang telah 
   melakukan transaksi untuk setiap periode.*/
SELECT
   quarter,
   COUNT(DISTINCT customerID) AS total_customers
FROM
   (
      SELECT
         customerID,
         createDate,
         QUARTER(createDate) AS quarter
      FROM
         customer
      WHERE
         createDate BETWEEN '2004-01-01' AND '2004-06-30' AND
         customerID IN 
            (
               SELECT
                  DISTINCT customerID
               FROM
                  orders_1
               UNION
               SELECT
                  DISTINCT customerID
               FROM
                  orders_2
            )
   ) AS tabel_b
GROUP BY
   quarter
;

/* Category Produk Apa Saja yang Paling Banyak Diorder oleh Customer di Q2?
   -------------------------------
   Menampilkan perbandingan jumlah customer terdaftar yang telah 
   melakukan transaksi untuk setiap periode.*/
SELECT
   *
FROM
   (
      SELECT
         categoryID,
         COUNT(DISTINCT orderNumber) AS total_order,
         SUM(quantity) AS total_penjualan
      FROM
         (
            SELECT
               productCode,
               orderNumber,
               quantity,
               status,
               LEFT(productCode, 3) AS categoryID
            FROM
               orders_2
            WHERE
               status = 'Shipped'
         ) AS tabel_c
      GROUP BY
         categoryID
   ) AS a
ORDER BY
   total_order DESC
;

/* Seberapa Banyak Customers yang Tetap Aktif Setelah Transaksi Pertamanya?
   -------------------------------
   Menampilkan persentase jumlah customer yang melakukan transkasi pada Q2
   setelah melakukan transaksi pad Q1.*/
SELECT
   '1' AS quarter,
   (
      SELECT
         COUNT(DISTINCT customerID)
      FROM
         orders_1
      WHERE
         customerID IN 
         (
            SELECT
               DISTINCT customerID
            FROM
               orders_2
         )
   ) / COUNT(DISTINCT customerID) * 100 AS Q2
FROM
   orders_1
;