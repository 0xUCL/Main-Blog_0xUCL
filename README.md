# 0xUCL (Unsri Cyber Lab) - Main Blog & Write-Ups

Repositori ini adalah pusat dokumentasi, publikasi *write-up* CTF, pembelajaran *exploit*, dan arsip penyelesaian soal dari komunitas 0xUCL. Website ini dibangun menggunakan [Jekyll](https://jekyllrb.com/) dan secara otomatis di-deploy ke **GitHub Pages**.

🌍 **Live Website:** [https://0xucl.github.io/Main-Blog_0xUCL/](https://0xucl.github.io/Main-Blog_0xUCL/)

---

## 📝 Panduan Mengunggah Write-Up (WU) Baru

Untuk mengunggah *write-up* atau artikel baru, kamu hanya perlu membuat file Markdown (`.md`) di dalam folder `_posts/`.

### 1. Format Nama File
Nama file **WAJIB** mengikuti format tanggal dan judul yang dipisahkan dengan tanda hubung (`-`), semuanya menggunakan huruf kecil (lowercase).
👉 **Format:** `TAHUN-BULAN-TANGGAL-judul-tulisan-tanpa-spasi.md`
👉 **Contoh:** `_posts/2026-06-12-cara-menyelesaikan-sql-injection.md`

### 2. Struktur Konten (Front Matter)
Setiap file write-up harus diawali dengan pengaturan (Front Matter) di bagian paling atas sebelum teks isi artikel. Gunakan format berikut:

```yaml
---
title: "Judul Write-Up Kamu Di Sini"
author: azizul-manal-gaumalanga   # Ganti dengan username / ID file author kamu
tags: [web, ctf-2026, sqli]       # Tambahkan tag yang relevan
image: images/oxucl-logo.jpg      # Path gambar thumbnail (opsional)
---

Tulisan write-up / artikel kamu dimulai dari sini...
Kamu bisa menggunakan semua sintaks Markdown standar.
```

### 3. Cara Memasukkan Gambar ke Artikel
Jika kamu ingin menambahkan gambar tangkapan layar (screenshot) langkah-langkah CTF:
1. Masukkan file gambar kamu ke dalam folder `images/wu/`.
   *(Contoh: `images/wu/sql-step1.png`)*
2. Di dalam file write-up (`.md`), panggil gambar tersebut dengan sintaks Markdown:
   ```markdown
   ![Deskripsi Gambar](images/wu/sql-step1.png)
   ```

---

## 👤 Panduan Menambahkan Profil Author (Member)

Agar nama kamu bisa dipanggil di kolom `author` pada write-up, kamu harus membuat profil member terlebih dahulu.

1. Buka folder `_members/`.
2. Buat file baru dengan nama kamu, misal: `nama-kamu.md`.
3. Isi dengan format berikut:

```yaml
---
name: Nama Lengkap Kamu
image: images/logo.jpg        # Bisa diganti dengan foto profilmu di folder images/
role: member                  # Posisi (contoh: core, member, alumni)
affiliation: Teknik Informatika (2024)
links:
  github: username_github_mu
  instagram: username_ig_mu
---
```
Setelah file profil ini terbuat, kamu bisa memanggil ID file ini (`nama-kamu`) di kolom `author` saat membuat write-up!

---

## 🚀 Panduan Mempublikasikan Perubahan

Website ini menggunakan sistem **Otomatisasi GitHub Actions**.
Kamu **tidak perlu** mengatur server atau mem-build website secara manual.

Setiap kali kamu melakukan `git push` ke branch `main`, GitHub akan otomatis membaca file baru kamu, mem-build website-nya, dan mengunggahnya ke branch `gh-pages` untuk ditayangkan ke internet dalam waktu ~1-2 menit.

Langkah publikasi standar:
```bash
git pull origin main
git add .
git commit -m "menambah write-up baru"
git push origin main
```

---

## 💻 Menjalankan Website Secara Lokal (Untuk Testing)

Jika kamu ingin melihat tampilan website di laptopmu sebelum di-push ke GitHub:
1. Pastikan **Ruby** dan **Bundler** sudah terinstall.
2. Buka terminal di folder project ini.
3. Jalankan perintah instalasi (hanya dilakukan sekali):
   ```bash
   bundle install
   ```
4. Jalankan server lokal:
   ```bash
   bundle exec jekyll serve
   ```
5. Buka `http://localhost:4000` di browsermu.
