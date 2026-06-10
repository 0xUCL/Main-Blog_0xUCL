---
title: "W1-C1 Portal Pemantauan Server"
author: azizul-manal-gaumalanga
tags: [web, zero-day-2026]
image: images/oxucl-logo.jpg
---

## Detail Soal

| Field | Value |
|-------|-------|
| Nama Challenge | Portal Pemantauan Server |
| Kategori | Web Breach |
| Event | ZERO_DAY // Scholar Battle |
| Poin | 100 |
| Difficulty | Easy |
| File | - |

## Deskripsi Singkat

Challenge **W1-C1: Portal Pemantauan Server** merupakan challenge kategori **Web Breach**. Pada challenge ini diberikan sebuah portal pemantauan server milik PT Infranet Solusi. Panel administrasi portal tersebut menyimpan token keamanan rahasia yang hanya dapat diakses oleh administrator.

Tujuan dari challenge ini adalah mendapatkan akses ke panel admin dan mengambil token atau flag yang tersimpan di dalamnya.

## Analisis Awal

Langkah pertama yang saya lakukan adalah membuka halaman utama portal. Pada halaman tersebut terdapat beberapa informasi status server dan menu **Lupa Password**. Setelah memeriksa source code halaman awal, ditemukan komentar HTML yang menunjukkan lokasi halaman login administrator.

```html
<!-- /auth/login.php -->
```

Dari informasi tersebut, saya membuka halaman `/auth/login.php`. Halaman ini memiliki form login dengan input `username` dan `password`. Berdasarkan catatan challenge yang berbunyi:

> "Akses yang tidak sah seringkali bukan soal kata sandi yang lemah, melainkan logika yang cacat."

Saya menyimpulkan bahwa celah kemungkinan berada pada proses autentikasi, bukan pada brute force password. Karena halaman login menerima input username dan password, saya mencoba menguji kemungkinan adanya **SQL Injection** pada form login.

## Langkah Penyelesaian

Pada halaman login administrator, saya mencoba memasukkan payload SQL Injection sederhana pada field username.

Payload yang digunakan:

```txt
admin' --
```

Kemudian field password dapat diisi dengan nilai bebas, karena bagian pengecekan password akan dikomentari oleh payload SQL Injection tersebut.

Contoh input:

```txt
Username: admin' --
Password: bebas
```

Jika query login di backend dibuat secara tidak aman, kemungkinan bentuk query-nya seperti berikut:

```sql
SELECT * FROM users WHERE username = 'admin' AND password = '...';
```

Setelah payload dimasukkan, query dapat berubah menjadi:

```sql
SELECT * FROM users WHERE username = 'admin' -- ' AND password = '...';
```

Tanda `--` membuat bagian setelahnya dianggap sebagai komentar, sehingga pengecekan password tidak lagi diproses. Dengan begitu, login berhasil dilakukan sebagai user `admin`.

Setelah berhasil masuk, halaman panel admin menampilkan informasi sesi sebagai administrator dan menampilkan token keamanan sistem. Pada bagian **Token Keamanan Sistem**, ditemukan flag challenge.

## Flag

```txt
flag{sql1_byp4ss_4dm1n_p4n3l}
```

## Kesimpulan / Hal yang Dipelajari

Dari challenge ini, saya mempelajari bahwa celah keamanan pada proses login tidak selalu berasal dari password yang lemah, tetapi bisa berasal dari validasi input dan query database yang tidak aman. SQL Injection dapat terjadi ketika input pengguna langsung digabungkan ke dalam query SQL tanpa proses sanitasi atau penggunaan prepared statement.

Challenge ini juga menunjukkan pentingnya memeriksa source code halaman, karena komentar HTML pada halaman awal memberikan petunjuk menuju halaman login administrator. Selain itu, penggunaan query SQL yang aman sangat penting agar autentikasi tidak dapat dilewati hanya dengan memanipulasi input login.
