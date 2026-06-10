---
title: "W1-A1 Pesan Tersembunyi"
author: azizul-manal-gaumalanga
tags: [crypto, puzzle, zero-day-2026]
image: images/oxucl-logo.jpg
---

## Detail Soal

| Field | Value |
|-------|-------|
| Nama Challenge | W1-A1 Pesan Tersembunyi |
| Kategori | Crypto & Puzzle |
| Event | ZERO DAY Mini Games 2026 |
| Poin | 100 |
| Difficulty | Easy |
| File | `ANALYST_NOTE.txt` `ENCODE_MEMO.txt` `SERVER_LOG.txt` |

![](/images/wu/pesan-1.png)

## Deskripsi Singkat

Challange ini termasuk ke dalam kategori crypto dan puzzle, berdasarkan instruksi yang diberikan, peserta diminta untuk membuka file yang disediakan dan membaca isinya. Catatan pada soal memberikan petunjuk bahwa data mengandung pola.

```
"Data yang tampak acak selalu menyimpan pola - tugas analis adalah menemukannya."
```

![](/images/wu/pesan-2.png)

## Analisis Awal

Pada challenge ini terdapat tiga file yang diberikan, yaitu `ANALYST_NOTE.txt`, `ENCODE_MEMO.txt`, dan `SERVER_LOG.txt`.
Langkah pertama yang saya lakukan adalah membaca dan menganalisis masing-masing file untuk mencari petunjuk awal, hal ini sesuai dengan catatan pada challenge.
File `ANALYST_NOTE.txt` berfungsi sebagai petunjuk utama. Dari catatan tersebut, saya memahami bahwa data yang dicari telah disamarkan dengan menggunakan dua lapisan encoding, dan target utama pemeriksaan adalah file `ENCODE_MEMO.txt`.

File `ENCODE_MEMO.txt` berisi:

```
WlJaQiBWQUdSRUFOWSDigJQgRU5VTkZWTgpYcmNucW4gIDogR3Z6IFpuYW53cnpyYSBDRyBBaGZuYWduZW4gUXZ0dmdueQpRbmV2ICAgIDogUXJjbmVncnpyYSBYcm56bmFuYSBWYXNiZXpuZnYKQ3JldnVueSA6IFZhZnZxcmEgWHJvYnBiZW5hIFFuZ24g4oCUIEd2YXFueCBZbmF3aGcgRnJ0cmVuCgpDbnFuIGduYXR0bnkgMTUgWnJ2IDIwMjYsIGZ2ZmdyeiB4bnp2IHpyYXFyZ3J4ZnYgbnhndml2Z25mIGd2cW54IGZudSBsbmF0CnpyYXRueHZvbmd4bmEgeHJvYnBiZW5hIHFuZ24gcW5ldiBmcmVpcmUgY2VicWh4ZnYuIENyeW54aCBxdnFodG4genJhdHRoYW54bmEKbnluZyBiZ2J6bmd2ZiBoYWdoeCB6cmF0cnhmZ2VueCBxbmduIHhiYXN2dGhlbmZ2IGZyYWZ2Z3ZzIHFuZXYgcXZlcnhnYmV2IGxuYXQKZnJ1bmVoZmFsbiBxdm9uZ25mdiBueGZyZmFsbi4KCk9yZXFuZm5leG5hIG5hbnl2ZnZmIHlidCBuam55LCBxdmdyemh4bmEgb251am4gZnJ3aHp5bnUgc3Z5ciB4YmFzdnRoZW5mdiBncnludQpxdnJ4ZnN2eWdlbmZ2LiBDcnlueGggcXZjcmV4dmVueG5hIGdyeW51IHpyYWxuem5leG5hIHFuZ24gZ3JlZnJvaGcgenJhdHRoYW54bmEKZ3J4YXZ4IHJhcGJxdmF0IGZyb3J5aHogenJhdHZldnp4bmFhbG4geHIgZnJlaXJlIHJ4ZmdyZWFueS4gVmFpcmZndnRuZnYgeXJvdnUKeW5hd2hnIHpuZnZ1IG9yZXluYXRmaGF0IG9yZWZuem4gZ3Z6IFBGVkVHLgoKWGJxciBxbmVoZW5nIGxuYXQgcXZncmduY3huYTogc3ludHtxMGhveTNfeTRsM2VfejN6MF9xM3AwcTNxfS4gWGJxciB2YXYgdW5hbG4gcXZjcmVoYWdoeHhuYSBvbnR2Cmd2eiB2YWZ2cXJhIHFuYSB1bmVoZiBxdndudG4geHJlbnVuZnZubmFhbG4uIFduYXRuYSBxdmZyb25leG5hIHpyeW55aHYgeG5hbnkKeGJ6aGF2eG5mdiBsbmF0IGd2cW54IG56bmEgZ25hY24gcmF4ZXZjZnYgcmFxLWdiLXJhcS4KCkZydHJlbiB5bmNiZXhuYSBncnpobmEgZ256b251bmEgeHJjbnFuIHhiYmVxdmFuZ2JlIHZhZnZxcmEuIEVuY25nIGZ2Z2huZnYgbnhuYQpxdmZyeXJhdHRuZW54bmEgY25xbiBjaHhoeSAxNC4wMCBKVk8gdW5ldiB2YXYuIFhydW5xdmVuYSBmcnloZWh1IG5hdHRiZ24gZ3Z6Cmpud3ZvIGhhZ2h4IHpyem9udW5mIHluYXR4bnUgenZndnRuZnYgcW5hIGVyZmNiYWYgdmFmdnFyYSB5cm92dSB5bmF3aGcuCgpVYmV6bmcgeG56diwKUXZpdmZ2IFhybnpuYW5hIEZ2b3JlCkNHIEFoZm5hZ25lbiBRdnR2Z255Cg==
```

String ini diakhiri dengan karakter `==` yang merupakan padding khas dari encoding base64. Hal ini menjadi petunjuk kuat bahwa lapisan pertama encoding adalah base64.

Hasil decode-nya adalah:

```
ZRZB VAGREANY — ENUNFVN
Xrcnqn  : GvzАнанwrzra CG Ahfnagnen Qvtvgny
Qnev    : Qrcnegrzra Xrnznana Vasbeznfv
Crevuny : Vafvqra Xrobpbena Qngn — Gvaqnx Ynawhg Frtren
...
```

Output decode menunjukan teks masih tidak terbaca. Pola ini mengindikasikan encoding **ROT13** yang dapat diidentifikasi dari dua ciri:
- Kata-kata pendek seperti `gvz` kemungkinan besar `tim` (pergeseran 13 huruf)
- Struktur kalimat masih terlihat (spasi, tanda baca utuh), menandakan ini encoding substitusi, bukan enkripsi acak

File `SERVER_LOG.txt` berisi log aktivitas server. Setelah diperiksa, file ini tidak mengandung data relevan untuk menemukan flag dan berfungsi sebagai *red herring* — elemen pengecoh yang umum ditemukan dalam challenge CTF.

Berdasarkan seluruh hasil analisis, flag bisa didapatkan dengan mendecode isi dari `ENCODE_MEMO.txt` dengan Base64 kemudian ROT13.

## Langkah Penyelesaian

Tool yang digunakan adalah CyberChef. Tool ini dipilih karena kemampuannya melakukan operasi decode secara bersamaan, tanpa menulis skrip.

1. Paste seluruh isi dari file `ENCODE_MEMO.txt` ke kolom input
2. Pada kolom recipe, tambahkan dua operasi berurutan:
   - Pertama: From Base64
   - Kedua: ROT13
3. Output final akan muncul otomatis di kolom output

```
MEMO INTERNAL — RAHASIA
Kepada  : Tim Manajemen PT Nusantara Digital
Dari    : Departemen Keamanan Informasi
Perihal : Insiden Kebocoran Data — Tindak Lanjut Segera

Pada tanggal 15 Mei 2026, sistem kami mendeteksi aktivitas tidak sah yang
mengakibatkan kebocoran data dari server produksi. Pelaku diduga menggunakan
alat otomatis untuk mengekstrak data konfigurasi sensitif dari direktori yang
seharusnya dibatasi aksesnya.

...

Kode darurat yang ditetapkan: flag{d0ubl3_l4y3r_m3m0_d3c0d3d}. Kode ini hanya diperuntukkan bagi
tim insiden dan harus dijaga kerahasiaannya.
```

Flag ditemukan di paragraf 3, tertulis sebagai kode darurat.

![](/images/wu/pesan-3.png)

## Flag

```
flag{d0ubl3_l4y3r_m3m0_d3c0d3d}
```

## Kesimpulan / Hal yang Dipelajari

Saya mempelajari banyak hal dari tantangan ini. Saya belajar tentang encoding paling umum di CTF yaitu Base64 dan ROT13. Kedua encoding ini ternyata mudah dikenali secara visual tanpa bantuan tool: Base64 bisa dikenali dengan padding `==` atau `=` di akhir string, sedangkan ROT13 bisa dikenali dengan masih terjaganya struktur kalimat.
