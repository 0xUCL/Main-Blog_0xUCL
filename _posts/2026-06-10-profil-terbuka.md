---
title: "W1-B2 Profil Terbuka"
author: azizul-manal-gaumalanga
tags: [osint, recon, zero-day-2026]
image: images/oxucl-logo.jpg
---

## Detail Soal

| Field | Value |
|-------|-------|
| Nama Challenge | Profil Terbuka |
| Kategori | Recon / OSINT |
| Event | ZERO_DAY // Scholar Battle |
| Poin | 100 |
| Difficulty | Easy |
| File | - |

## Deskripsi Singkat

Challenge **W1-B2: Profil Terbuka** merupakan soal kategori **Recon / OSINT**. Pada challenge ini, peserta diminta menelusuri profil publik Sari Dewi, seorang IT Security Analyst yang dikenal dengan julukan berkaitan dengan "cermin". Informasi sensitif disembunyikan di beberapa bagian profilnya dalam bentuk yang tidak langsung terbaca. Peserta perlu mengikuti jejak yang tersedia, melakukan proses decoding, lalu mengubah hasil flag ke format huruf kecil `flag{...}` sebelum disubmit.

## Analisis Awal

Pada tahap awal, saya membuka halaman utama **Direktori Profil Publik Sari Dewi**. Di halaman tersebut terdapat beberapa tautan yang mengarah ke arsip profil publik, yaitu **Twitter Archive** dan **LinkedIn Export**. Karena challenge ini termasuk kategori Recon / OSINT, saya mulai menelusuri setiap informasi yang tersedia pada halaman tersebut.

Dari halaman **Twitter Archive**, ditemukan sebuah petunjuk bahwa Sari Dewi memiliki blog lama dengan nama file `sari_blog.html`. Selain itu, terdapat tweet yang menyebutkan bahwa ia menyukai **"kode cermin"** dan sebuah cipher klasik yang memiliki sifat encode dan decode dengan cara yang sama. Petunjuk ini penting karena istilah "cermin" mengarah pada konsep pertukaran huruf secara berlawanan dalam alfabet.

Cipher klasik yang sesuai dengan petunjuk tersebut adalah **Atbash Cipher**. Pada Atbash, huruf alfabet dicerminkan dari depan ke belakang, misalnya `A` menjadi `Z`, `B` menjadi `Y`, `C` menjadi `X`, dan seterusnya. Karena prosesnya hanya mencerminkan huruf, metode yang sama dapat digunakan untuk encode maupun decode.

Saya kemudian membuka halaman `sari_blog.html`. Pada halaman blog tersebut terdapat bagian **Catatan Rahasia** yang mengarahkan pengguna untuk membaca halaman `about_me.html`. Setelah membuka halaman tersebut, ditemukan informasi yang semakin memperkuat dugaan sebelumnya, yaitu Sari Dewi memiliki alias **"Cermin Dunia"** dan secara langsung menyebut bahwa ia menyukai **Atbash**.

Pada halaman `about_me.html`, ditemukan pesan rahasia berikut:

```
UOZT{4GY4HS_X3IN1M_W3X0W3W}
```

Berdasarkan petunjuk "kode cermin", sifat encode dan decode yang sama, serta penyebutan Atbash pada halaman profil, dapat disimpulkan bahwa pesan tersebut perlu didekode menggunakan **Atbash Cipher**.

## Langkah Penyelesaian

Langkah pertama adalah membuka halaman utama challenge dan membaca seluruh tautan yang tersedia. Dari halaman utama ditemukan dua sumber informasi, yaitu `twitter_archive.html` dan `linkedin_export.txt`.

Selanjutnya, saya membuka `twitter_archive.html` dan menemukan petunjuk bahwa blog lama Sari Dewi berada pada halaman:

```
sari_blog.html
```

Pada arsip Twitter juga terdapat petunjuk mengenai "kode cermin", yang mengarah ke cipher klasik dengan proses encode dan decode yang sama.

Setelah itu, saya membuka halaman `sari_blog.html`. Di dalam source dan isi halaman blog, terdapat petunjuk menuju halaman lain, yaitu:

```
about_me.html
```

Kemudian saya membuka halaman `about_me.html` dan menemukan pesan rahasia berikut:

```
UOZT{4GY4HS_X3IN1M_W3X0W3W}
```

Karena halaman tersebut secara eksplisit menyebut Atbash, maka pesan tersebut didekode menggunakan Atbash Cipher. Proses decoding menghasilkan:

```
FLAG{4TB4SH_C3RM1N_D3C0D3D}
```

Setelah hasil decode didapatkan, isi flag masih menggunakan bentuk leetspeak. Angka pada teks tersebut dapat dibaca sebagai huruf:

| Angka | Huruf |
|-------|-------|
| 4 | A |
| 3 | E |
| 1 | I |
| 0 | O |

Sehingga isi flag menjadi:

```
ATBASH_CERMIN_DECODED
```

Karena format submit challenge menggunakan huruf kecil, maka flag akhir ditulis dalam lowercase.

## Flag

```
flag{atbash_cermin_decoded}
```

## Kesimpulan / Hal yang Dipelajari

Dari challenge ini, saya belajar bahwa pada soal Recon / OSINT, informasi penting tidak selalu langsung terlihat di halaman utama. Peserta perlu mengikuti setiap jejak digital yang tersedia, seperti arsip Twitter, export LinkedIn, blog, komentar HTML, dan halaman tersembunyi.

Selain itu, challenge ini juga menunjukkan bahwa petunjuk narasi seperti "cermin" dapat mengarah pada teknik kriptografi tertentu, yaitu Atbash Cipher. Dengan memahami konteks dan menghubungkan setiap petunjuk, pesan rahasia dapat didekode hingga menghasilkan flag yang benar.
