---
title: "W1-E1 Foto Mencurigakan"
author: azizul-manal-gaumalanga
tags: [forensics, zero-day-2026]
image: images/oxucl-logo.jpg
---

## Detail Soal

| Field | Value |
|-------|-------|
| Nama Challenge | W1-E1: Foto Mencurigakan |
| Kategori | Digital Forensics |
| Event | ZERO_DAY Mini Games 2026 |
| Poin | 100 |
| Tingkat | Beginner |
| File | `foto_kantor.jpg` dan `readme_analis.txt` |

## Deskripsi Singkat

Challenge **W1-E1: Foto Mencurigakan** merupakan challenge kategori **Digital Forensics**. Pada soal diberikan sebuah file gambar bernama `foto_kantor.jpg` dan file catatan analis `readme_analis.txt`. Dari catatan analis, diketahui bahwa foto tersebut kemungkinan mengandung file tersembunyi dan perlu diperiksa menggunakan tool forensik standar.

## Analisis Awal

Langkah awal yang saya lakukan adalah membaca file `readme_analis.txt`. Di dalam catatan tersebut terdapat petunjuk bahwa gambar yang diberikan tidak hanya berisi tampilan visual biasa, tetapi kemungkinan menyimpan file lain di dalamnya. Karena challenge ini termasuk digital forensics dan berkaitan dengan gambar, saya mulai memeriksa metadata serta kemungkinan adanya teknik steganografi pada file `foto_kantor.jpg`.

## Langkah Penyelesaian

Pertama, saya memeriksa metadata gambar menggunakan `exiftool`.

```
exiftool foto_kantor.jpg
```

Dari hasil pengecekan metadata, ditemukan komentar yang berisi password:

```
pass: kantor2026
```

Password ini menjadi petunjuk bahwa file gambar kemungkinan menggunakan teknik steganografi dengan password tertentu. Selanjutnya, saya mencoba mengekstrak file tersembunyi menggunakan `steghide`.

```
steghide extract -sf foto_kantor.jpg -p kantor2026
```

Setelah perintah tersebut dijalankan, berhasil diekstrak sebuah file bernama `hidden.txt`.

```
cat hidden.txt
```

Isi file tersebut menampilkan flag challenge.

## Flag

```
flag{st3gh1d3_k4nt0r_2026_f0und}
```

## Kesimpulan / Hal yang Dipelajari

Dari challenge ini, saya belajar bahwa file gambar tidak selalu hanya berisi data visual yang terlihat oleh mata. Informasi penting dapat disembunyikan di dalam metadata maupun menggunakan teknik steganografi. Pada kasus ini, metadata gambar menyimpan password yang kemudian digunakan untuk mengekstrak file tersembunyi menggunakan `steghide`.
