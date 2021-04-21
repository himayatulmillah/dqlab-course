/* 
------------------------------------------------------------------
| MODUL : Fundamental SQL with SELECT Statement                  |
| SOURCE: https://academy.dqlab.id/main/package/practice/91?pf=0 |
------------------------------------------------------------------
*/

--------------------------------
-- 1. SQL dan Perintah SELECT --
--------------------------------

/* Perintah SELECT
   -------------------------------
   Menampilkan seluruh data dari tabel ms_produk.*/
SELECT 
    * 
FROM 
    ms_produk
;


-----------------------------------------------------------
-- 2. Menentukan Kolom dan Jumlah Baris yang Ditampilkan --
-----------------------------------------------------------

/* Mengambil Satu Kolom dari Table
   -------------------------------
   Menampilkan kolom nama_produk dari tabel ms_produk.*/
SELECT 
    nama_produk 
FROM 
    ms_produk
;

/* Mengambil Lebih dari Satu Kolom dari Table
   -------------------------------
   Menampilkan kolom nama_produk dari tabel ms_produk.*/
SELECT 
    nama_produk, 
    harga 
FROM 
    ms_produk
;

/* Membatasi Pengambilan Jumlah Row Data
   -------------------------------
   Menampilkan 3 baris nama_produk dari tabel ms_produk.*/
SELECT 
    nama_produk 
FROM 
    ms_produk 
LIMIT 
    3
;


-------------------------
-- 3. Prefix dan Alias --
-------------------------

/* Menggunakan Prefix pada Nama Kolom
   -------------------------------
   Menampilkan kode_produk dengan prefix dari tabel ms_produk.*/
SELECT 
    ms_produk.kode_produk 
FROM 
    ms_produk
;

/* Menggunakan Alias pada Kolom
   -------------------------------
   Menampilkan no_urut dan nama_produk dengan alias dari tabel ms_produk.*/
SELECT
    no_urut AS nomor,
    nama_produk AS nama
FROM
    ms_produk
;

/* Menghilangkan Keyword 'AS'
   -------------------------------
   Menampilkan no_urut dan nama_produk dengan alias (tanpa AS) dari tabel ms_produk.*/
SELECT
    no_urut nomor,
    nama_produk nama
FROM
    ms_produk
;

/* Menggabungkan Prefix dan Alias
   -------------------------------
   Menampilkan harga dengan prefix dan alias dari tabel ms_produk.*/
SELECT 
    ms_produk.harga AS harga_jual 
FROM 
    ms_produk
;

/* Menggunakan Alias pada Tabel
   -------------------------------
   Menampilkan semua data dari tabel ms_produk dengan alias.*/
SELECT 
    * 
FROM 
    ms_produk t1
;

/* Prefix dan Alias Tabel
   -------------------------------
   Menampilkan nama_produk dan harga dari tabel ms_produk dengan prefix dan alias.*/
SELECT
    t2.nama_produk,
    t2.harga
FROM
    ms_produk t2
;


---------------------------
-- 4. Menggunakan Filter --
---------------------------

/* Menggunakan WHERE
   -------------------------------
   Menampilkan data dari tabel ms_produk yang memiliki 
   nama_produk 'Tas Travel Organizer DQLab'.*/
SELECT
    *
FROM
    ms_produk
WHERE
    nama_produk = 'Tas Travel Organizer DQLab'
;

/* Menggunakan Operand OR
   -------------------------------
   Menampilkan data dari tabel ms_produk yang memiliki 
   nama_produk 'Tas Travel Organizer DQLab' atau 'Flashdisk DQLab 64 GB'.*/
SELECT
    *
FROM
    ms_produk
WHERE
    nama_produk = 'Tas Travel Organizer DQLab' OR
    nama_produk = 'Flashdisk DQLab 64 GB'
;

/* Filter untuk Angka
   -------------------------------
   Menampilkan data dari tabel ms_produk yang memiliki 
   harga lebih dari 50.000.*/
SELECT
    *
FROM
    ms_produk
WHERE
    harga > 50000
;

/* Menggunakan Operand AND
   -------------------------------
   Menampilkan data dari tabel ms_produk yang memiliki 
   nama_produk 'Gantungan Kunci DQLab' dan harga kurang dari 50.000.*/
SELECT
    *
FROM
    ms_produk
WHERE
    nama_produk = 'Gantungan Kunci DQLab' AND
    harga < 50000
;