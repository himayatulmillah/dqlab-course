/* 
-------------------------------------------------------------------
| MODUL : Fundamental SQL Using INNER JOIN and UNION              |
| SOURCE: https://academy.dqlab.id/main/package/practice/244?pf=0 |
-------------------------------------------------------------------
*/

---------------------------------------------
-- 1. Penggabungan Tabel dari Relasi Kolom --
---------------------------------------------

/* Tugas Praktek
   -------------------------------
   Menampilkan data dari tabel ms_item_kategori dan ms_item_warna.*/
SELECT
    *
FROM
    ms_item_kategori
;
SELECT
    *
FROM
    ms_item_warna
;

/* Menggabungkan Tabel dengan Key Columns
   -------------------------------
   Menampilkan data dari (1)tabel ms_item_kategori dan (2)ms_item_warna 
   berdasarkan nama_barang yang sama dengan nama_item.*/
SELECT
    *
FROM
    ms_item_kategori,
    ms_item_warna
WHERE
    nama_barang = nama_item
;

/* Bagaimana Jika Urutan Tabel Diubah?
   -------------------------------
   Menampilkan data dari (1)tabel ms_item_warna dan (2)ms_item_kategori
   berdasarkan nama_barang yang sama dengan nama_item.*/
SELECT
    *
FROM
    ms_item_warna,
    ms_item_kategori
WHERE
    nama_barang = nama_item
;

/* Menggunakan Prefix Nama Tabel
   -------------------------------
   Menampilkan data dari (2)tabel ms_item_warna dan (1)ms_item_kategori
   berdasarkan nama_barang yang sama dengan nama_item.*/
SELECT
    ms_item_kategori.*,
    ms_item_warna.*
FROM
    ms_item_warna,
    ms_item_kategori
WHERE
    nama_barang = nama_item
;

/* Penggabungan Tanpa Kondisi
   -------------------------------
   Menampilkan data dari tabel (1)ms_item_kategori dan (2)ms_item_warna tanpa kondisi 
   yang menghasilkan jumlah baris = jumlah baris tabel1 * jumlah baris tabel2
   atau disebut dengan cross join.*/
SELECT
    *
FROM
    ms_item_kategori,
    ms_item_warna
;


-------------------
-- 2. INNER JOIN --
-------------------

/* Tugas Praktek: Menggunakan INNER JOIN (1/3)
   -------------------------------
   Menampilkan data dari tabel ms_item_warna dan ms_item_kategori
   berdasarkan nama_barang yang sama dengan nama_item.*/
SELECT
    *
FROM
    ms_item_warna
INNER JOIN
    ms_item_kategori
ON 
    ms_item_warna.nama_barang = ms_item_kategori.nama_item
;

/* Tabel tr_penjualan dan tabel ms_produk
   -------------------------------
   Menampilkan data dari tabel tr_penjualan dan ms_produk.*/
SELECT
    *
FROM
    tr_penjualan
;
SELECT
    *
FROM
    ms_produk
;

/* Tugas Praktek: Menggunakan INNER JOIN (2/3)
   -------------------------------
   Menampilkan data dari tabel tr_penjualan dan ms_produk
   berdasarkan kode_produk yang sama.*/
SELECT
    *
FROM
    tr_penjualan
INNER JOIN
    ms_produk
ON
    tr_penjualan.kode_produk = ms_produk.kode_produk
;

/* Tugas Praktek: Menggunakan INNER JOIN (3/3)
   -------------------------------
   Menampilkan kode_transaksi, kode_pelanggan, kode_produk dan 
   qty dari tabel tr_penjualan juga tampilkan nama_produk dan 
   harga dari tabel ms_produk berdasarkan kode_produk yang sama.*/
SELECT
    tr_penjualan.kode_transaksi,
    tr_penjualan.kode_pelanggan,
    tr_penjualan.kode_produk,
    ms_produk.nama_produk,
    ms_produk.harga,
    tr_penjualan.qty,
    ms_produk.harga * tr_penjualan.qty AS total
FROM
    tr_penjualan
INNER JOIN
    ms_produk
ON
    tr_penjualan.kode_produk = ms_produk.kode_produk
;


--------------
-- 3. UNION --
--------------

/* Tabel yang Akan Digabungkan
   -------------------------------
   Menampilkan data dari tabel_A dan tabel_B.*/
SELECT
    *
FROM
    tabel_A
;
SELECT
    *
FROM
    tabel_B
;

/* Menggunakan UNION
   -------------------------------
   Menggabungkan (baris) tabel_A dengan tabel_B.*/
SELECT
    *
FROM
    tabel_A
UNION
SELECT
    *
FROM
    tabel_B
;

/* Menggunakan UNION dengan Klausa WHERE
   -------------------------------
   Menggabungkan (baris) tabel_A dengan tabel_B 
   berdasarkan kode_pelanggan = 'dqlabcust03'.*/
SELECT
    *
FROM
    tabel_A
WHERE
    kode_pelanggan = 'dqlabcust03'
UNION
SELECT
    *
FROM
    tabel_B
WHERE
    kode_pelanggan = 'dqlabcust03'
;

/* Menggunakan UNION dan Menyelaraskan Kolom-Kolomnya
   -------------------------------
   Menggabungkan (baris) tabel Customers dengan tabel Suppliers 
   dan menyelaraskan kolom-kolomnya.*/
SELECT
    CustomerName,
    ContactName,
    City,
    PostalCode
FROM
    Customers
UNION
SELECT
    SupplierName,
    ContactName,
    City,
    PostalCode
FROM
    Suppliers
;

---------------------
-- 4. Mini Project --
--------------------

/* Project INNER JOIN
   -------------------------------
   Menampilkan kode_pelanggan, nama_customer dan alamat untuk pelanggan yang
   membeli 'Kotak Pensil DQLab', 'Flashdisk DQLab 32 GB' dan 'Sticky Notes DQLab 500 sheets'
   dengan menggabungkan tabel ms_pelanggan dan tabel tr_penjualan.*/
SELECT
    DISTINCT ms_pelanggan.kode_pelanggan,
    ms_pelanggan.nama_customer,
    ms_pelanggan.alamat
FROM
    ms_pelanggan
INNER JOIN
    tr_penjualan
ON
    ms_pelanggan.kode_pelanggan = tr_penjualan.kode_pelanggan
WHERE
    tr_penjualan.nama_produk = 'Kotak Pensil DQLab' OR
    tr_penjualan.nama_produk = 'Flashdisk DQLab 32 GB' OR
    tr_penjualan.nama_produk = 'Sticky Notes DQLab 500 sheets'
;

/* Project UNION
   -------------------------------
   Menampilkan nama_produk, kode_produk dan harga dengan menggabungkan 
   tabel ms_produk_1 (harga < 100K) dan tabel ms_produk_2 (harga < 50K).*/
SELECT
    nama_produk,
    kode_produk,
    harga
FROM
    ms_produk_1
WHERE
    harga < 100000
UNION
SELECT
    nama_produk,
    kode_produk,
    harga
FROM
    ms_produk_2
WHERE
    harga < 50000
;