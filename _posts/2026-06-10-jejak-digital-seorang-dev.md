---
title: "W1-F1 Jejak Digital Seorang Dev"
author: azizul-manal-gaumalanga
tags: [osint, recon, zero-day-2026]
image: images/oxucl-logo.jpg
---

## Detail Soal

| Field | Value |
|-------|-------|
| Nama Challenge | W1-F1 Warmup — Selamat Datang |
| Kategori | Recon / OSINT |
| Event | ZERO DAY Mini Games 2026 |
| Poin | 100 |
| Difficulty | Easy |
| File/Sumber | Website dari lomba |

## Deskripsi Singkat

Pada challange ini diberikan website Portfolio Budi Santoso, dan menurut instruksi ada informasi sensitif yang tersebar. Catatan dari tantangan ini memberitahukan bahwa flag bukan hanya ada di tampilan atau halaman utama.

## Analisis Awal

Saya melakukan analisis pada bagian front end website. Kemudian di halaman `/whois_dump.txt` saya menemukan potongan flag part 2 yang di-encoding dengan base64.

```
=RfYjRzMzY0X2NoNDFufQ==
```

Pemeriksaan secara backend dilakukan. Dari kode halaman utama ditemukan komentar tentang adanya halaman yang disembunyikan.

```html
<!-- halaman pribadi: /catatan.html -->
```

Di halaman `catatan.html` ditemukan bagian 1 dari flag:

![](/images/wu/jejak-1.png)

```
ZmxhZ3t0dzBfZnI0Z20zbn
```

## Langkah Penyelesaian

1. Buka terminal linux
2. Gabungkan part 1 dan 2 dari flag:

```
ZmxhZ3t0dzBfZnI0Z20zbnRfYjRzMzY0X2NoNDFufQ==
```

3. Decode dengan tool base64:

![](/images/wu/jejak-2.png)

## Flag

```
flag{tw0_fr4gm3nt_b4s364_ch41n}
```

## Kesimpulan / Hal yang Dipelajari

Dari challenge ini, saya belajar bahwa informasi penting pada website tidak selalu terlihat di halaman utama. Dengan memeriksa source code, halaman tersembunyi, dan file tambahan seperti `/whois_dump.txt`, saya dapat menemukan dua bagian flag. Kedua bagian tersebut kemudian digabungkan dan didecode menggunakan base64 untuk mendapatkan flag akhir.
