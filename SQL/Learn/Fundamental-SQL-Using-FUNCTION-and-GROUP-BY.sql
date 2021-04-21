/* 
-------------------------------------------------------------------
| MODUL : Fundamental SQL Using FUNCTION and GROUP BY             |
| SOURCE: https://academy.dqlab.id/main/package/practice/171?pf=0 |
-------------------------------------------------------------------
*/

----------------------
-- 1. Fungsi di SQL --
----------------------

/* Fungsi Skalar Matematika - ABS()
   -------------------------------
   Menampilkan nilai absolute dari MarkGrowth dari tabel students.*/
SELECT
    StudentID,
    FirstName, 
    LastName,
    Semester1, 
    Semester2,
    ABS(MarkGrowth) AS MarkGrowth
FROM
    students
;

/* Fungsi Skalar Matematika - CEILING()
   -------------------------------
   Menampilkan pembulatan nilai (integer terbesar yang terdekat) Semester1 
   dan Semester2 dari tabel students.*/
SELECT
    StudentID,
    FirstName, 
    LastName,
    CEILING(Semester1) AS Semester1,
    CEILING(Semester2) AS Semester2,
    MarkGrowth
FROM
    students
;

/* Fungsi Skalar Matematika - FLOOR()
   -------------------------------
   Menampilkan pembulatan nilai (integer terkecil yang terdekat) Semester1 
   dan Semester2 dari tabel students.*/
SELECT
    StudentID,
    FirstName,
    LastName,
    FLOOR(Semester1) AS Semester1,
    FLOOR(Semester2) AS Semester2,
    MarkGrowth
FROM
    students
;

/* Fungsi Skalar Matematika - ROUND()
   -------------------------------
   Menampilkan pembulatan nilai (decimal) Semester1 dan Semester2 
   dari tabel students.*/
SELECT
    StudentID,
    FirstName,
    LastName,
    ROUND(Semester1, 1) AS Semester1,
    ROUND(Semester2, 0) AS Semester2,
    MarkGrowth
FROM
    students
;

/* Fungsi Skalar Matematika - SQRT()
   -------------------------------
   Menampilkan nilai kuadrat Semester1 dari tabel students.*/
SELECT
    StudentID,
    FirstName,
    LastName,
    SQRT(Semester1) AS Semester1,
    Semester2,
    MarkGrowth
FROM
    students
;

/* Tugas Praktek
   -------------------------------
   Menampilkan nilai sisa (MOD) Semester1 dibagi 2 dan 
   nilai eksponensial MarkGrowth dari tabel students.*/
SELECT
    StudentID,
    FirstName,
    LastName,
    MOD(Semester1, 2) AS Semester1,
    Semester2,
    EXP(MarkGrowth)
FROM
    students
;


---------------------------
-- 2. Fungsi Text di SQL --
---------------------------

/* Fungsi Text - CONCAT()
   -------------------------------
   Menampilkan nama lengkap siswa dengan menggabungkan 
   FirstName dan LastName dari tabel students.*/
SELECT
    StudentID,
    CONCAT(FirstName, LastName) AS Name,
    Semester1,
    Semester2,
    MarkGrowth
FROM
    students
;

/* Fungsi Text - SUBSTRING_INDEX()
   -------------------------------
   Menampilkan nama tanpa domain email dengan pemisah '@' 
   pada kolom Email dari tabel students.*/
SELECT
    StudentID,
    SUBSTRING_INDEX(Email, '@', 1) AS Name
FROM
    students
;

/* Fungsi Text - SUBSTR()
   -------------------------------
   Menampilkan 3 karakter nama pada FirstName dimulai dari 
   karakter urutan kedua dari tabel students.*/
SELECT
    StudentID,
    SUBSTR(FirstName, 2, 3) AS Initial
FROM
    students
;

/* Fungsi Text - LENGTH()
   -------------------------------
   Menampilkan panjang karakter FirstName dari tabel students.*/
SELECT
    StudentID,
    FirstName,
    LENGTH(FirstName) AS Total_Char
FROM
    students
;

/* Fungsi Text - REPLACE()
   -------------------------------
   Mengganti domain Email 'yahoo' dengan 'gmail' dari tabel students.*/
SELECT
    StudentID,
    Email,
    REPLACE(Email, 'yahoo', 'gmail') AS New_Email
FROM
    students
;

/* Tugas Praktek
   -------------------------------
   Menampilkan FirstName dengan huruf besar dan 
   LastName dengan huruf kecil dari tabel students.*/
SELECT
    StudentID,
    UPPER(FirstName) AS FirstName,
    LOWER(LastName) AS LastName
FROM
    students
;


--------------------------------------
-- 3. Fungsi Aggregate dan Group By --
--------------------------------------

/* Fungsi Aggregate - SUM()
   -------------------------------
   Menampilkan jumlah nilai Semester1 dan Semester2 dari tabel students.*/
SELECT
    SUM(Semester1) AS Total_1,
    SUM(Semester2) AS Total_2
FROM
    students
;

/* Fungsi Aggregate - COUNT()
   -------------------------------
   Menampilkan jumlah siswa dari tabel students.*/
SELECT
    COUNT(FirstName) AS Total_Student
FROM
    students
;

/* Fungsi Aggregate - AVG()
   -------------------------------
   Menampilkan nilai rata-rata Semester1 dan Semester2 dari tabel students.*/
SELECT
    AVG(Semester1) AS AVG_1,
    AVG(Semester2) AS AVG_2
FROM
    students
;

/* Tugas Praktek
   -------------------------------
   Menampilkan nilai minimal dan maksimal untuk Semester1 
   dan Semester2 dari tabel students.*/
SELECT
    MIN(Semester1) AS Min1,
    MAX(Semester1) AS Max1,
    MIN(Semester2) AS Min2,
    MAX(Semester2) AS Max2
FROM
    students
;

/* Group By Single Column
   -------------------------------
   Menampilkan total_order dan total_price untuk 
   setiap province pada tabel sales_retail_2019.*/
SELECT
    province,
    COUNT(DISTINCT order_id) AS total_order,
    SUM(item_price) AS total_price
FROM
    sales_retail_2019
GROUP BY
    province
;

/* Group By Multiple Column
   -------------------------------
   Menampilkan total_order dan total_price untuk setiap province 
   dan setiap brand pada tabel sales_retail_2019.*/
SELECT
    province,
    brand,
    COUNT(DISTINCT order_id) AS total_order,
    SUM(item_price) AS total_price
FROM
    sales_retail_2019
GROUP BY
    province,
    brand
;

/* Fungsi Aggregate dengan Grouping
   -------------------------------
   Menampilkan total_unique_order dan revenue untuk 
   setiap province pada tabel sales_retail_2019.*/
SELECT
    province,
    COUNT(DISTINCT order_id) AS total_unique_order,
    SUM(item_price) AS revenue
FROM
    sales_retail_2019
GROUP BY
    province
;

/* Tugas Praktek
   -------------------------------
   Menampilkan total_price untuk setiap order_month, 
   beri label 'Target Achieved' jika total_price >= 30.000.000.000,
   'Less Performed' jika total_price <= 25.000.000.000 dan 
   'Follow Up' jika tidak masuk keduanya.*/
SELECT
    MONTH(order_date) AS order_month,
    SUM(item_price) AS total_price,
    CASE
        WHEN SUM(item_price) >= 30000000000 THEN 'Target Achieved'
        WHEN SUM(item_price) <= 25000000000 THEN 'Less Performed'
        ELSE 'Follow Up'
    END AS remark
FROM
    sales_retail_2019
GROUP BY
    MONTH(order_date)
;

---------------------
-- 4. Mini Project --
---------------------

/* Proyek Pekerjaan - Analisis Penjualan
   -------------------------------.*/
-- 1. Total jumlah seluruh penjualan (total/revenue).
SELECT
    SUM(total) AS total
FROM
    tr_penjualan
;
-- 2. Total quantity seluruh produk yang terjual.
SELECT
    SUM(qty) AS qty
FROM
    tr_penjualan
;
-- 3. Total quantity dan total revenue untuk setiap kode produk.
SELECT
    kode_produk,
    SUM(qty) AS qty,
    SUM(total) AS total
FROM
    tr_penjualan
GROUP BY
    kode_produk
;
-- 4. Rata-rata total belanja per kode pelanggan.
SELECT
    kode_pelanggan,
    AVG(total) AS avg_total
FROM
    tr_penjualan
GROUP BY
    kode_pelanggan
;
-- 5. Kategorikan total/revenue: (High: > 300k), (Medium: 100K - 300K), (Low: < 100k)
SELECT
    kode_transaksi,
    kode_pelanggan,
    no_urut,
    kode_produk,
    nama_produk,
    qty,
    total,
    CASE
        WHEN total > 300000 THEN 'High'
        WHEN total < 100000 THEN 'Low'
        ELSE 'Medium'
    END AS kategori 
FROM
    tr_penjualan
;