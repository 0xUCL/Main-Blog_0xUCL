---
title: "W1-B3 Perusahaan Bayangan"
author: azizul-manal-gaumalanga
tags: [osint, recon, zero-day-2026]
image: images/oxucl-logo.jpg
---

## Detail Soal

| Field | Value |
|-------|-------|Detail Soal
| Nama Challenge | W1-B3: Perusahaan Bayangan |
| Kategori | Recon / OSINT |
| Poin | 200 |
| Event | ZERO DAY Mini Games 2026 |

## Deskripsi Singkat

Pada challenge ini, diberikan sebuah website milik PT Siluman Teknologi. Berdasarkan narasi soal, data sensitif perusahaan diduga bocor dan tersebar di beberapa lokasi digital. Tujuan dari challenge ini adalah menelusuri jejak-jejak yang tersedia pada website untuk menemukan komponen yang diperlukan dalam proses mendapatkan flag.

## Analisis Awal

Langkah pertama dilakukan dengan membuka halaman utama PT Siluman Teknologi. Pada halaman tersebut terdapat daftar tim teknis unggulan dan sebuah tautan untuk mengunduh direktori karyawan dalam bentuk file `employee_list.csv`.

Dari file CSV tersebut ditemukan beberapa data karyawan seperti nama, divisi, email, status, dan blog pribadi. Salah satu entri yang menarik adalah Ahmad Fauzi, seorang Senior Security Engineer dengan ID karyawan `EMP-3391`, yang memiliki blog pribadi bernama `aftech.html`.

Selain itu, pengecekan terhadap `robots.txt` juga memberikan petunjuk penting karena terdapat beberapa path yang tidak diperbolehkan untuk diindeks, salah satunya adalah `/leaked_env.txt`. File ini menjadi petunjuk kuat karena halaman utama juga menyebutkan adanya potensi kebocoran file konfigurasi.

## Langkah Penyelesaian

Pertama, saya membuka file `employee_list.csv` dari halaman utama. File tersebut berisi data karyawan PT Siluman Teknologi. Dari file ini ditemukan bahwa Ahmad Fauzi memiliki blog pribadi dengan path:

```text
aftech.html
```

Setelah membuka halaman `aftech.html`, terdapat petunjuk bahwa file gambar sering menyimpan informasi lebih dari yang terlihat, khususnya melalui metadata. Pada halaman tersebut juga terdapat gambar profil Ahmad Fauzi dengan nama file:

```text
profile_ahmad.jpg
```

Selanjutnya, saya membuka file `robots.txt` dan menemukan beberapa path tersembunyi:

```text
/internal/
/admin/
/leaked_env.txt
```

Path yang paling relevan adalah `/leaked_env.txt` karena berhubungan dengan kebocoran konfigurasi. Setelah dibuka, file tersebut berisi konfigurasi API dan sebuah token terenkripsi:

```env
API_TOKEN_ENC=VV9YViMEQmkCbEEGKUcuKFxBZlprTi5kQEAKXDpbQjRO
```

Dari petunjuk pada blog Ahmad Fauzi, saya kemudian memeriksa metadata gambar `profile_ahmad.jpg`. Pada metadata gambar ditemukan komentar:

```text
kunci2: X7qP
```

Karena Ahmad Fauzi memiliki ID karyawan `EMP-3391`, maka bagian pertama kunci diambil dari ID tersebut, yaitu:

```text
3391
```

Kemudian kunci kedua dari metadata adalah:

```text
X7qP
```

Sehingga kunci lengkap yang digunakan adalah:

```text
3391X7qP
```

Token `API_TOKEN_ENC` kemudian didecode dari Base64, lalu hasilnya didekripsi menggunakan XOR dengan kunci `3391X7qP`. Dari proses tersebut didapatkan flag:

```text
flag{3391_x7qp_xor_k3y_4ss3mbl3d}
```

## Flag

```text
flag{3391_x7qp_xor_k3y_4ss3mbl3d}
```

## Kesimpulan / Hal yang Dipelajari

Challenge ini mengajarkan bahwa dalam OSINT, informasi penting tidak selalu terlihat langsung pada halaman utama. Petunjuk dapat tersebar di berbagai tempat seperti file CSV, `robots.txt`, file konfigurasi yang bocor, halaman blog pribadi, hingga metadata gambar. Selain itu, challenge ini juga menunjukkan pentingnya menggabungkan beberapa potongan informasi untuk mendapatkan kunci dekripsi yang benar.
