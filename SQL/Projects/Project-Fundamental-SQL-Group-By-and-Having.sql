/* 
--------------------------------------------------------------
| MODUL : Project: Fundamental SQL Group By and Having       |
| SOURCE: https://academy.dqlab.id/main/package/practice/292 |
--------------------------------------------------------------
*/

-----------------------
-- 1. Let's Deep Dive --
-----------------------

/* Mendapatkan Jumlah Nilai Pinalty
   -------------------------------
   Menampilkan customer id dan jumlah pinalty yang dibayarkan.*/
SELECT
    customer_id,
    SUM(pinalty)
FROM
    invoice
GROUP BY
    customer_id
HAVING
    SUM(pinalty) IS NOT NULL
;

/* Mencari Customer yang Mengganti Layanan
   -------------------------------
   Menampilkan customer id dan jumlah pinalty yang dibayarkan.*/
SELECT
    t1.Name AS name,
    GROUP_CONCAT(t3.product_name)
FROM
    customer t1
    JOIN
        subscription t2 ON t1.id = t2.customer_id
    JOIN
        product t3 ON t2.product_id = t3.ID
WHERE 
    t1.id IN
        (
            SELECT
                customer_id
            FROM
                subscription
            GROUP BY
                customer_id
            HAVING
                COUNT(customer_id) > 1
        )
GROUP BY
    1
;