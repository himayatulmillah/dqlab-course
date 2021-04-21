# -*- coding: utf-8 -*-
"""
Created on Fri Apr  2 16:37:57 2021

@author: Asus
"""
def calculateSum(n):
    if n <= 0:
        return 0
    fibo = [0] * (n + 1)
    fibo[1] = 1
    # Initialisasi hasil ke dalam variabel sm
    sm = fibo[0] + fibo[1]
    # Tambahkan suku-suku berikutnya
    for i in range(2, n + 1):
        fibo[i] = fibo[i - 1] + fibo[i - 2]
        sm += fibo[i]
    return sm
# Evaluasi hasil deret untuk n = 7
print(calculateSum(7))

def fibonacci(n):   # or use factorial function from math library
    return n if n <= 1 else fibonacci(n-1) + fibonacci(n-2)
    
print(fibonacci(7))