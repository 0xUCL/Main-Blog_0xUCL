---
title: "W1-D1 Aktivasi Sistem"
author: azizul-manal-gaumalanga
tags: [rev, binary, zero-day-2026]
image: images/oxucl-logo.jpg
---

## Detail Soal

| Field | Value |
|-------|-------|
| Nama Challenge | W1-D1 Aktivasi Sistem |
| Kategori | Reverse Binary |
| Event | ZERO DAY Mini Games 2026 |
| Poin | 100 |
| Difficulty | Beginner |
| File | Binary `aktivasi_sistem` |

## Deskripsi Singkat

Pada challenge ini diberikan sebuah file binary bernama `aktivasi_sistem`. Binary tersebut merupakan modul aktivasi sistem yang meminta kode aktivasi sebelum memberikan akses. Tujuan dari challenge ini adalah menganalisis binary untuk menemukan kode aktivasi yang valid.

## Analisis Awal

Langkah pertama yang saya lakukan adalah mengecek jenis file menggunakan perintah `file`.

```bash
file aktivasi_sistem
```

Hasilnya menunjukkan bahwa file tersebut merupakan ELF 64-bit executable. Selanjutnya, saya menjalankan binary untuk melihat perilakunya.

```bash
./aktivasi_sistem
```

Program menampilkan pesan:

```text
Sistem Aktivasi PT Infrastruktur Digital
Masukkan kode aktivasi:
```

Jika input yang diberikan salah, program akan menampilkan pesan bahwa kode aktivasi tidak valid. Dari sini dapat disimpulkan bahwa program melakukan validasi terhadap input pengguna.

Kemudian saya melakukan pemeriksaan string menggunakan perintah:

```bash
strings aktivasi_sistem
```

Pada hasil `strings`, terdapat beberapa string yang terlihat seperti petunjuk, seperti:

```text
INFRANET-V2
bypass_key_admin
kernel_token
SYS-AUTH-MODULE-v3.1
```

Namun string tersebut bukan kode aktivasi yang valid. Selain itu, terdapat string yang tampak tidak terbaca langsung:

```text
<6;=!)k4=6i
```

Hal ini sesuai dengan catatan challenge bahwa string yang tidak terbaca langsung bukan berarti tidak ada informasi di dalamnya.

## Langkah Penyelesaian

Untuk memahami cara program memvalidasi input, saya melakukan disassembly menggunakan `objdump`.

```bash
objdump -d -Mintel aktivasi_sistem
```

Dari hasil disassembly, ditemukan fungsi bernama `xor_decode`. Fungsi ini melakukan operasi XOR terhadap setiap byte menggunakan nilai `0x5a`.

Potongan logic pentingnya adalah:

```asm
xor eax, 0x5a
```

Program mengambil data terenkripsi dari bagian `.rodata`, kemudian melakukan decode menggunakan XOR `0x5a`. Hasil decode tersebut kemudian dibandingkan dengan input pengguna menggunakan fungsi `strcmp`.

Data terenkripsi yang digunakan sebagai kode aktivasi berada pada bagian `.rodata`:

```text
3c 36 3b 3d 21 29 6b 34 3d 36 69 05 38 23 2e 69
05 22 6a 28 05 6e 39 2e 6b 2c 6e 2e 69 3e 27
```

Setelah mengetahui bahwa algoritmanya adalah single-byte XOR dengan key `0x5a`, saya melakukan decode menggunakan Python.

```python
enc = bytes.fromhex(
    "3c363b3d21296b343d36690538232e6905226a28056e392e6b2c6e2e693e27"
)

print(bytes([b ^ 0x5a for b in enc]).decode())
```

Hasil decode-nya adalah:

```text
flag{s1ngl3_byt3_x0r_4ct1v4t3d}
```

Untuk memastikan kode tersebut benar, saya menjalankan kembali binary dan memasukkan hasil decode tersebut sebagai kode aktivasi.

```bash
./aktivasi_sistem
```

Input:

```text
flag{s1ngl3_byt3_x0r_4ct1v4t3d}
```

Program kemudian menampilkan pesan:

```text
Aktivasi berhasil! Sistem online.
```

## Flag

```text
flag{s1ngl3_byt3_x0r_4ct1v4t3d}
```

## Kesimpulan / Hal yang Dipelajari

Pada challenge ini, kode aktivasi tidak disimpan secara langsung dalam bentuk plaintext. Program menyimpan kode tersebut dalam bentuk data yang telah di-XOR menggunakan key `0x5a`, lalu mendecode-nya saat runtime sebelum dibandingkan dengan input pengguna.

Dari challenge ini, saya belajar bahwa pada reverse binary, hasil `strings` tidak selalu langsung menampilkan flag. String yang terlihat seperti petunjuk bisa saja hanya noise, sedangkan data penting dapat disimpan dalam bentuk terenkripsi atau ter-encode sederhana seperti single-byte XOR.
