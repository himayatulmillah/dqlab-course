/* 
-----------------------------------------------------------------
| MODUL : Data Engineer CHallenge with SQL                      |
| SOURCE: https://academy.dqlab.id/main/package/project/99?pf=0 |
-----------------------------------------------------------------
*/


/* Produk DQLab Mart
   -------------------------------
   Menampilkan daftar produk (semua kolom) dari tabel ms_produk
   yang memiliki harga antara 50.000 - 150.000.*/
SELECT 
    * 
FROM 
    ms_produk 
WHERE 
    harga BETWEEN 50000 AND 150000
;

/* Thumb Drive di DQLab Mart
   -------------------------------
   Menampilkan daftar produk (semua kolom) dari tabel ms_produk
   yang mengandung kata 'Flashdisk'.*/
SELECT 
    * 
FROM 
    ms_produk 
WHERE 
    nama_produk LIKE '%Flashdisk%'
;

/* Pelanggan Bergelar
   -------------------------------
   Menampilkan daftar pelanggan (semua kolom) dari tabel 
   ms_pelanggan yang memiliki gelar.*/
SELECT 
    * 
FROM 
    ms_pelanggan
WHERE 
    nama_pelanggan LIKE '%Ir.%' OR
    nama_pelanggan LIKE '%S.H%' OR
    nama_pelanggan LIKE '%Drs.%'
;

/* Mengurutkan Nama Pelanggan
   -------------------------------
   Menampilkan nama pelanggan dari tabel ms_pelanggan dan 
   urutkan hasilnya berdasarkan huruf terkecil ke terbesar (A-Z).*/
SELECT 
    nama_pelanggan 
FROM 
    ms_pelanggan 
ORDER BY 
    nama_pelanggan
;

/* Mengurutkan Nama Pelanggan Tanpa Gelar
   -------------------------------
   Menampilkan nama pelanggan (tanpa gelar) dari tabel ms_pelanggan dan 
   urutkan hasilnya berdasarkan huruf terkecil ke terbesar (A-Z).*/
SELECT 
    nama_pelanggan 
FROM 
    ms_pelanggan 
ORDER BY 
    SUBSTRING_INDEX(nama_pelanggan, '. ', -1)
;

/* Nama Panggilan yang Paling Panjang
   -------------------------------
   Menampilkan nama pelanggan dari tabel ms_pelanggan yang memiliki 
   nama paling panjang, tampilkan semua jika ada lebih dari 1 orang.*/
SELECT
    nama_pelanggan
FROM
    ms_pelanggan
WHERE
    LENGTH(nama_pelanggan) = (
        SELECT
            MAX(LENGTH(nama_pelanggan))
        FROM
            ms_pelanggan
    )
;

/* Nama Panggilan yang Paling Panjang dan Paling Pendek
   -------------------------------
   Menampilkan nama pelanggan dari tabel ms_pelanggan yang memiliki 
   nama paling panjang (row atas) dan paling pendek (row bawah).*/
SELECT
    nama_pelanggan
FROM
    ms_pelanggan
WHERE
    LENGTH(nama_pelanggan) IN (
        (
            SELECT
                MAX(LENGTH(nama_pelanggan))
            FROM
                ms_pelanggan
        ),
        (
            SELECT
                MIN(LENGTH(nama_pelanggan))
            FROM
                ms_pelanggan
        )
    )
ORDER BY
    LENGTH(nama_pelanggan) DESC
;

/* Kuantitas Produk yang Banyak Terjual
   -------------------------------
   Menampilkan produk dengan qty paling banyak terjual dengan
   menggabungkan tabel ms_produk dan tabel tr_penjualan_detail.*/
SELECT
    ms_produk.kode_produk,
    ms_produk,nama_produk,
    SUM(tr_penjualan_detail.qty) AS total_qty
FROM
    ms_produk
INNER JOIN
    tr_penjualan_detail
ON 
    ms_produk.kode_produk = tr_penjualan_detail.kode_produk
GROUP BY
    ms_produk.kode_produk,
    ms_produk.nama_produk
HAVING
    SUM(tr_penjualan_detail.qty) > 2
;

/* Pelanggan Paling Tinggi Nilai Belanjanya
   -------------------------------
   Menampilkan pelanggan yang paling tinggi nilai belanjanya dengan
   menggabungkan tabel ms_pelanggan, tr_penjualan dan tr_penjualan_detail.*/
SELECT
    tr_penjualan.kode_pelanggan,
    ms_pelanggan.nama_pelanggan,
    SUM(tr_penjualan_detail.qty * tr_penjualan_detail.harga_satuan) AS total_harga
FROM
    ms_pelanggan
INNER JOIN
    tr_penjualan USING (kode_pelanggan)
INNER JOIN
    tr_penjualan_detail USING (kode_transaksi)
GROUP BY
    tr_penjualan.kode_pelanggan,
    ms_pelanggan.nama_pelanggan
ORDER BY
    total_harga DESC
LIMIT
    1
;

/* Pelanggan yang Belum Pernah Belanja
   -------------------------------
   Menampilkan pelanggan yang belum pernah melakukan transaksi
   dengan menggabungkan tabel ms_pelanggan dan tr_penjualan.*/
SELECT
    ms_pelanggan.kode_pelanggan,
    ms_pelanggan.nama_pelanggan,
    ms_pelanggan.alamat
FROM
    ms_pelanggan
LEFT JOIN
    tr_penjualan USING (kode_pelanggan)
WHERE
    tr_penjualan.kode_pelanggan IS NULL
;

/* Transaksi Belanja dengan Daftar Belanja Lebih dari 1
   -------------------------------
   Menampilkan transaksi yang memiliki lebih dari 1 jenis produk dengan
   menggabungkan tabel tr_penjualan, tr_penjualan_detail, dan ms_pelanggan.*/
SELECT
    td.kode_transaksi,
    tr.kode_pelanggan,
    ms.nama_pelanggan,
    tr.tanggal_transaksi,
    COUNT(td.kode_transaksi) AS jumlah_detail
FROM
    tr_penjualan tr
INNER JOIN
    tr_penjualan_detail td USING (kode_transaksi)
INNER JOIN
    ms_pelanggan ms USING (kode_pelanggan)
GROUP BY
    td.kode_transaksi,
    tr.kode_pelanggan,
    ms.nama_pelanggan,
    tr.tanggal_transaksi
HAVING
    jumlah_detail > 1
;