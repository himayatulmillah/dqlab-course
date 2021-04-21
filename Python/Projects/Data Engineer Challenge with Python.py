# -*- coding: utf-8 -*-
"""
Created on Fri Apr  2 22:18:42 2021

@author: Asus
"""
"""
Web Scraping
"""
# import library yang dibutuhkan
import pandas as pd
import requests
from bs4 import BeautifulSoup

# buatlah request ke website
resp = requests.get('https://id.wikipedia.org/wiki/Demografi_Indonesia').text

# ambil table dengan class 'wikitable sortable'
soup = BeautifulSoup(resp, 'lxml')
table = soup.find('table', 'wikitable sortable')

# cari data dengan tag 'td'
rows = table.find_all('td')

# buatlah list kosong
kode_bps = []
nama = []
ibu_kota = []
populasi = []
luas_km = []
pulau = []

# memasukkan data ke dalam list berdasarkan pola HTML
for idx, val in enumerate(rows):
    if idx in range(0, len(rows), 9):
        kode_bps.append(val.get_text())
    elif idx in range(2, len(rows), 9):
        nama.append(val.get_text())
    elif idx in range(4, len(rows), 9):
        ibu_kota.append(val.get_text())
    elif idx in range(5, len(rows), 9):
        populasi.append(val.get_text())
    elif idx in range(6, len(rows), 9):
        luas_km.append(val.get_text())
    elif idx in range(8, len(rows), 9):
        pulau.append(val.get_text()[:-1])

# buatlah DataFrame dan masukkan ke CSV
df = pd.DataFrame({'Kode BPS': kode_bps, 
                   'Nama': nama, 
                   'Ibu Kota': ibu_kota, 
                   'Populasi': populasi, 
                   'Luas km': luas_km, 
                   'Pulau': pulau})
df.to_csv('Indonesia_Demography_by_Province.csv', index=False, encoding='utf-8', quoting=1)

"""
Function and Regular Expression
"""
# import library yang dibutuhkan
import re

# function email_check
def email_check(input):
    match = re.search('(?=^((?!-).)*$)(?=[^0-9])((?=^((?!\.\d).)*$)|(?=.*_))', input)
    if match:
  	    print('Pass')
    else:
  	    print('Not Pass')
    
# masukkan data email ke dalam list
emails = ['my-name@someemail.com', 
          'myname@someemail.com', 
          'my.name@someemail.com', 
          'my.name2019@someemail.com', 
          'my.name.2019@someemail.com', 
          'somename.201903@someemail.com', 
          'my_name.201903@someemail.com', 
          '201903myname@someemail.com', 
          '201903.myname@someemail.com']

# looping untuk pengecekan Pass atau Not Pass
for email in emails:
    email_check(email)
