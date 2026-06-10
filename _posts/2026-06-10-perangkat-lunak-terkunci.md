---
title: "W1-D2 Perangkat Lunak Terkunci"
author: azizul-manal-gaumalanga
tags: [rev, binary, zero-day-2026]
image: images/oxucl-logo.jpg
---

## Detail Soal

| Field | Value |
|-------|-------|
| Nama Challenge | W1-D2: Perangkat Lunak Terkunci |
| Kategori | Reverse Binary |
| Event | ZERO DAY Mini Games 2026 |
| Poin | 100 |
| Difficulty | Beginner |
| File | `perangkat_lunak_terkunci` |

## Deskripsi Singkat

Pada challenge ini diberikan sebuah binary bernama `perangkat_lunak_terkunci`. Binary tersebut merupakan program verifikasi lisensi yang meminta input berupa kunci lisensi. Tujuan dari challenge ini adalah menganalisis cara program memvalidasi input, lalu menemukan license key yang benar agar program berhasil diaktifkan.

## Analisis Awal

Pertama, binary dijalankan untuk melihat perilakunya.

```bash
./perangkat_lunak_terkunci
```

Program meminta input lisensi. Jika input salah, program akan menampilkan pesan bahwa lisensi tidak valid. Berdasarkan catatan soal, nilai yang tersimpan di dalam binary kemungkinan tidak disimpan dalam bentuk asli, sehingga perlu dianalisis menggunakan teknik reverse engineering sederhana.

Selanjutnya dilakukan pengecekan string yang ada di dalam binary.

```bash
strings perangkat_lunak_terkunci
```

Dari hasil pengecekan ditemukan sebuah string panjang berbentuk hexadecimal:

```txt
666c61677b6833785f737472316e675f6c3163336e73335f637234636b33647d
```

String tersebut terlihat seperti data yang sudah di-encode, bukan teks biasa.

## Langkah Penyelesaian

Karena string yang ditemukan berbentuk hexadecimal, langkah berikutnya adalah melakukan decode dari hex ke ASCII.

Decode dapat dilakukan menggunakan command berikut:

```bash
echo "666c61677b6833785f737472316e675f6c3163336e73335f637234636b33647d" | xxd -r -p
```

Hasil decode-nya adalah:

```txt
flag{h3x_str1ng_l1c3ns3_cr4ck3d}
```

Setelah itu, hasil decode tersebut dicoba sebagai input lisensi ke program.

```bash
./perangkat_lunak_terkunci
```

Kemudian masukkan:

```txt
flag{h3x_str1ng_l1c3ns3_cr4ck3d}
```

Program memberikan output bahwa lisensi valid dan perangkat lunak berhasil diaktifkan. Ini membuktikan bahwa string hexadecimal di dalam binary adalah license key yang benar setelah didecode.

## Flag

```txt
flag{h3x_str1ng_l1c3ns3_cr4ck3d}
```

## Kesimpulan / Hal yang Dipelajari

Pada challenge ini, validasi lisensi dilakukan dengan membandingkan input pengguna dengan nilai yang sudah disimpan di dalam binary dalam bentuk hexadecimal. Dari challenge ini dapat dipelajari bahwa pada reverse engineering, string penting seperti password, key, atau flag tidak selalu disimpan dalam bentuk plaintext, tetapi bisa disamarkan menggunakan encoding sederhana seperti hex.
