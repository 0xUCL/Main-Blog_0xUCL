---
title: "W1-F1 Warmup: Selamat Datang"
author: azizul-manal-gaumalanga
tags: [warmup, encoding, zero-day-2026]
image: images/oxucl-logo.jpg
---

## Detail Soal

| Field | Detail |
|---|---|
| Nama Challenge | W1-F1 Warmup: Selamat Datang |
| Kategori | Warm up / Encoding |
| Event | ZERO DAY Mini Games 2026 |
| Poin | 50 |
| Difficulty | Easy |
| File | `WELCOME.txt` |

## Deskripsi Singkat

Challenge ini merupakan pemanasan dari ZERO DAY Mini Games 2026. Berdasarkan instruksi, peserta diminta untuk membuka file yang disediakan dan membaca isinya.

> "Setiap investigasi dimulai dari langkah yang paling sederhana."

Dari petunjuk tersebut, langkah awal yang dilakukan adalah memeriksa file `WELCOME.txt`.

![Tampilan soal](/images/wu/warmup-1.png)

## Analisis Awal

File `WELCOME.txt` berisi string berikut:

```
53656c616d617420646174616e67206469205a45524f20444159204d696e692047616d657320323032362120466c61673a20666c61677b73656c616d61745f646174616e675f64695f7a65726f5f6461795f323032367d
```

String tersebut terlihat seperti data dalam format heksadesimal karena hanya terdiri dari karakter `0-9` dan `a-f`. Selain itu, jumlah karakternya juga genap — setiap 2 digit hex mewakili 1 byte karakter ASCII.

## Langkah Penyelesaian

Untuk melakukan decoding, digunakan tool `xxd` bawaan Linux:

```bash
echo '53656c616d617420...' | xxd -r -p
```

> `-r` = reverse (hex → teks)
> `-p` = plain (format hex tanpa spasi atau header)

Output yang dihasilkan:

```
Selamat datang di ZERO DAY Mini Games 2026!
Flag: flag{selamat_datang_di_zero_day_2026}
```

![Output terminal](/images/wu/warmup-2.png)

## Flag

```
flag{selamat_datang_di_zero_day_2026}
```
