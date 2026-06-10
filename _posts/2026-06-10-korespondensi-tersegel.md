---
title: "Korespondensi Tersegel"
author: azizul-manal-gaumalanga
tags: [crypto, puzzle, zero-day-2026]
image: images/oxucl-logo.jpg
---

## Detail Soal

| Field | Value |
|-------|-------|
| Nama Challenge | Korespondensi Tersegel |
| Kategori | Crypto & Puzzle |
| Event | ZERO_DAY // Scholar Battle |
| Poin | 25 |
| Difficulty | Easy |
| File | `readme.txt`, `company_logo.jpg`, `cipher_text.txt` |

## Deskripsi Singkat

Pada challenge ini, diberikan sebuah teks terenkripsi yang diduga merupakan korespondensi internal dari PT Arkana Sistem. Tugas utama dari challenge ini adalah menemukan metode enkripsi yang digunakan, mencari kunci dekripsi, lalu mendekripsi pesan untuk mendapatkan flag.

## Analisis Awal

Langkah pertama yang saya lakukan adalah membaca file `readme.txt`. Dari file tersebut diketahui bahwa pesan dienkripsi menggunakan metode klasik, dan kunci dekripsi dapat ditemukan pada salah satu file lain di dalam archive. Readme juga memberikan petunjuk untuk memeriksa data yang tidak terlihat secara visual.

Selanjutnya, saya membuka file `cipher_text.txt`. Isi file tersebut berupa teks acak dengan huruf kapital, tetapi susunannya masih menyerupai format surat atau korespondensi. Di dalam teks tersebut juga terdapat bagian yang terlihat seperti flag, yaitu:

```
SLAX{F1G3A3R3_4RB4X4_D3PRYGD3D}
```

Bagian ini kemungkinan besar merupakan flag yang masih terenkripsi. Karena readme menyebutkan bahwa kunci ada pada file lain dan perlu memeriksa data yang tidak terlihat secara visual, saya kemudian mengecek metadata dari file `company_logo.jpg`.

## Langkah Penyelesaian

1. Membaca file `readme.txt` untuk mencari petunjuk awal.
2. Dari readme, diketahui bahwa:
   - Cipher yang digunakan adalah metode klasik
   - Kunci berada di salah satu file lain
   - Perlu memeriksa data tersembunyi atau metadata
3. Mengecek metadata gambar `company_logo.jpg` menggunakan perintah:

```
exiftool company_logo.jpg
```

4. Dari metadata gambar ditemukan komentar:

```
kunci: ARKANA
```

5. Karena kunci berupa kata, metode klasik yang sesuai adalah **Vigenere Cipher**.
6. Melakukan dekripsi isi `cipher_text.txt` menggunakan **Vigenere Cipher** dengan key:

```
ARKANA
```

7. Setelah didekripsi, teks menjadi terbaca sebagai korespondensi internal. Bagian flag yang awalnya:

```
SLAX{F1G3A3R3_4RB4X4_D3PRYGD3D}
```

berubah menjadi:

```
FLAG{V1G3N3R3_4RK4N4_D3CRYPT3D}
```

8. Karena instruksi challenge meminta submit flag dalam format huruf kecil, maka flag diubah menjadi lowercase.

## Flag

```
flag{v1g3n3r3_4rk4n4_d3crypt3d}
```

## Kesimpulan / Hal yang Dipelajari

Dari challenge ini, saya belajar bahwa pada soal kriptografi, petunjuk tidak selalu berada langsung di file ciphertext. File pendukung seperti gambar juga bisa menyimpan informasi penting melalui metadata. Selain itu, ketika sebuah cipher klasik menggunakan kunci berupa kata, salah satu metode yang perlu dicoba adalah **Vigenere Cipher**. Pada challenge ini, key `ARKANA` berhasil digunakan untuk mendekripsi pesan dan mendapatkan flag.
