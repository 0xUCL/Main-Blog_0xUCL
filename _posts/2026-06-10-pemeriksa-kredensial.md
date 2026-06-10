---
title: "W1-D3 Pemeriksa Kredensial"
author: azizul-manal-gaumalanga
tags: [rev, binary, zero-day-2026]
image: images/oxucl-logo.jpg
---

## Detail Soal

| Field | Value |
|-------|-------|
| Nama Challenge | W1-D3: Pemeriksa Kredensial |
| Kategori | Reverse Binary |
| Event | ZERO DAY Mini Games 2026 |
| File | `pemeriksa_kredensial` |

## Deskripsi Singkat

Pada challenge **W1-D3: Pemeriksa Kredensial**, diberikan sebuah binary bernama `pemeriksa_kredensial`. Binary ini meminta input kredensial, lalu menentukan apakah input tersebut benar atau salah. Tujuan dari challenge ini adalah melakukan analisis reverse engineering untuk mengetahui kredensial yang valid.

## Analisis Awal

Pertama, saya menjalankan pengecekan awal terhadap binary menggunakan perintah `file`.

```bash
file pemeriksa_kredensial
```

Hasilnya menunjukkan bahwa file merupakan binary **ELF 64-bit** untuk Linux dan tidak ter-strip, sehingga nama fungsi masih dapat terlihat saat dianalisis.

Selanjutnya, saya menggunakan `strings` untuk melihat string yang tersimpan di dalam binary.

```bash
strings pemeriksa_kredensial
```

Dari hasil tersebut ditemukan beberapa string menarik seperti:

```text
ADMIN-CREDENTIAL-2026
ROOT-ACCESS-TOKEN
fWQza2M0cmNfbjE0aGNfNDYzczRiXzNzcjN2M3J7Z2FsZg==
```

Dua string pertama terlihat seperti kredensial, tetapi kemungkinan hanya decoy atau pengalih perhatian. String ketiga terlihat seperti Base64 karena memiliki pola karakter Base64 dan diakhiri dengan tanda `==`.

## Langkah Penyelesaian

Binary kemudian dianalisis lebih lanjut menggunakan `objdump`.

```bash
objdump -d -Mintel pemeriksa_kredensial
```

Dari fungsi `main`, ditemukan bahwa program melakukan beberapa proses terhadap input pengguna. Alurnya adalah:

1. Program menerima input dari user.
2. Karakter newline dihapus.
3. Input dibalik menggunakan fungsi `reverse_str`.
4. Hasil reverse kemudian di-encode menggunakan fungsi `b64_encode`.
5. Hasil encoding dibandingkan dengan string Base64 yang tersimpan di binary.

String pembanding yang ditemukan adalah:

```text
fWQza2M0cmNfbjE0aGNfNDYzczRiXzNzcjN2M3J7Z2FsZg==
```

Karena program melakukan proses:

```text
input → reverse → base64 encode → compare
```

maka untuk mendapatkan input asli, urutan tersebut harus dibalik:

```text
base64 decode → reverse
```

Saya menggunakan Python untuk melakukan decoding.

```bash
python3 -c 'import base64; s="fWQza2M0cmNfbjE0aGNfNDYzczRiXzNzcjN2M3J7Z2FsZg=="; print(base64.b64decode(s).decode())'
```

Hasil decode Base64:

```text
}d3kc4rc_n14hc_463s4b_3sr3v3r{galf
```

Hasil tersebut masih dalam kondisi terbalik, sehingga perlu dibalik lagi.

```bash
python3 -c 'import base64; s="fWQza2M0cmNfbjE0aGNfNDYzczRiXzNzcjN2M3J7Z2FsZg=="; print(base64.b64decode(s).decode()[::-1])'
```

Hasil akhirnya adalah:

```text
flag{r3v3rs3_b4s364_ch41n_cr4ck3d}
```

Setelah input tersebut dimasukkan ke program, binary menampilkan pesan bahwa kredensial benar dan akses diberikan.

```bash
printf 'flag{r3v3rs3_b4s364_ch41n_cr4ck3d}\n' | ./pemeriksa_kredensial
```

Output:

```text
Kredensial benar! Akses diberikan.
```

## Flag

```text
flag{r3v3rs3_b4s364_ch41n_cr4ck3d}
```

## Kesimpulan / Hal yang Dipelajari

Pada challenge ini, flag tidak langsung tersimpan dalam bentuk plaintext. Binary melakukan beberapa lapisan transformasi, yaitu membalik input lalu melakukan encoding Base64 sebelum membandingkannya dengan nilai yang sudah disimpan. Dari challenge ini dipelajari bahwa saat melakukan reverse engineering, penting untuk memahami urutan transformasi yang dilakukan program. Untuk mendapatkan nilai asli, proses tersebut harus dibalik dengan urutan yang berlawanan.
