---
title: "W1-A3 Konfigurasi Terenkripsi"
author: azizul-manal-gaumalanga
tags: [crypto, puzzle, zero-day-2026]
image: images/oxucl-logo.jpg
---

## Detail Soal

| Field | Value |
|-------|-------|
| Nama Challenge | W1-A3 Konfigurasi Terenkripsi |
| Kategori | Crypto & Puzzle |
| Event | ZERO DAY Mini Games 2026 |
| Poin | 200 |
| Difficulty | Beginner |
| File | `config.bin`, `key_hint.txt`, dan `partial_source.c` |

## Deskripsi Singkat

Pada challenge ini diberikan sebuah file binary blob konfigurasi dari perangkat IoT yang diduga telah dikompromikan. Bersama file tersebut, terdapat catatan analis dan potongan source code yang menjelaskan cara data konfigurasi diproses. Tujuan dari challenge ini adalah memahami struktur file binary, menemukan kunci enkripsi, lalu mendecode isi konfigurasi hingga mendapatkan flag.

## Analisis Awal

Langkah pertama yang saya lakukan adalah membaca file `key_hint.txt`. Dari catatan tersebut diketahui bahwa 4 byte pertama pada file `config.bin` merupakan XOR key. Nilai pada offset `0x00-0x03` adalah:

```text
4B 33 61 5F
```

Jika dikonversi dari hexadecimal ke ASCII, nilai tersebut menjadi:

```text
K3a_
```

Selanjutnya, saya membaca file `partial_source.c`. Dari potongan source code tersebut terlihat bahwa program membaca 4 byte pertama sebagai key, lalu melewati 4 byte awal file sebelum melakukan proses decode. Data setelah offset `0x04` di-XOR menggunakan key 4-byte secara berulang atau siklik.

Catatan pada soal berbunyi:

```text
"Dalam analisis biner, yang tampak jelas seringkali adalah pengalih perhatian."
```

Petunjuk ini menunjukkan bahwa tidak cukup hanya melihat string yang tampak langsung dari file binary. Isi sebenarnya perlu didecode terlebih dahulu menggunakan algoritma yang sesuai dengan source code yang diberikan.

## Langkah Penyelesaian

Pertama, saya membuka file petunjuk untuk mengetahui struktur `config.bin`. Struktur file tersebut adalah:

```text
[0x00-0x03] : 4-byte XOR key
[0x04-EOF ] : XOR-encoded strings
```

Dari struktur tersebut, saya mengambil 4 byte pertama sebagai key, yaitu:

```text
4B 33 61 5F
```

Kemudian, saya membuat script Python sederhana untuk membaca file `config.bin`, mengambil key dari 4 byte pertama, lalu mendecode seluruh data setelah offset `0x04` dengan operasi XOR.

Script yang digunakan:

```python
from pathlib import Path

data = Path("config.bin").read_bytes()

key = data[:4]
enc = data[4:]

dec = bytes(b ^ key[i % 4] for i, b in enumerate(enc))

for s in dec.split(b"\x00"):
    if s:
        print(s.decode())
```

Script tersebut bekerja dengan cara:

1. Membaca seluruh isi `config.bin`.
2. Mengambil 4 byte pertama sebagai XOR key.
3. Mengambil data setelah 4 byte pertama sebagai data terenkripsi.
4. Melakukan XOR setiap byte data dengan key secara berulang.
5. Memisahkan hasil decode berdasarkan null byte `0x00`, karena setiap string diakhiri dengan null terminator.

Setelah script dijalankan, muncul beberapa string konfigurasi seperti alamat server, endpoint internal, dan satu string flag.

Hasil decode yang ditemukan:

```text
192.168.47.23:8080
http://update.telematika-nusantara.internal/api/v1/beacon
vpn-gw.telematika-nusantara.internal
L2FwaS92Mi9iZWFjb24vdXBkYXRl
c2-backup.telematika.net:443
flag{xor_k3y_K33l_3xtr4ct3d}
```

Dari hasil tersebut, string terakhir merupakan flag challenge.

## Flag

```text
flag{xor_k3y_K33l_3xtr4ct3d}
```

## Kesimpulan / Hal yang Dipelajari

Pada challenge ini saya mempelajari bahwa file binary tidak selalu dapat dianalisis hanya dengan melihat string yang tampak secara langsung. Informasi penting bisa disimpan dalam bentuk encoded atau encrypted. Dengan membaca catatan analis dan memahami potongan source code, dapat diketahui bahwa file `config.bin` menggunakan XOR encryption sederhana dengan key yang disimpan pada 4 byte pertama file. Setelah key ditemukan dan proses XOR dilakukan secara benar, isi konfigurasi berhasil didecode dan flag dapat ditemukan.
