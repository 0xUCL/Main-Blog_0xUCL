---
title: Home
nav:
  order: 1
  tooltip: Beranda 0xUCL
---

<div class="hero-panel">
  <div class="hero-eyebrow"><i class="fa-solid fa-shield-halved"></i> CTF Write-up Archive</div>
  <h1 class="hero-title">0xUCL</h1>
  <p class="hero-subtitle">
    Portal komunitas <strong>Unsri Cyber Lab</strong> untuk mengarsipkan write-up CTF,
    catatan pembelajaran, dan dokumentasi eksploitasi secara rapi, ringan, dan mudah dibaca.
  </p>
  <div class="hero-actions">
    {% include button.html link="writeups" text="Lihat Write-up" icon="fa-solid fa-arrow-right" flip=true %}
    {% include button.html link="profil" text="Profil Komunitas" icon="fa-solid fa-users" style="bare" %}
  </div>
</div>

{% include section.html %}

## Profil Singkat

<div class="profile-grid">
  <div class="profile-card">
    <i class="icon fa-solid fa-terminal"></i>
    <h3>Belajar Lewat Praktik</h3>
    <p>0xUCL berfokus pada pembelajaran cyber security melalui CTF, analisis kasus, dan dokumentasi solusi yang runtut.</p>
  </div>
  <div class="profile-card">
    <i class="icon fa-solid fa-file-lines"></i>
    <h3>Write-up Terstruktur</h3>
    <p>Setiap write-up diarahkan punya alur jelas: deskripsi challenge, proses analisis, langkah eksploitasi, ringkasan, dan flag.</p>
  </div>
  <div class="profile-card">
    <i class="icon fa-solid fa-people-group"></i>
    <h3>Komunitas Cyber</h3>
    <p>Website ini juga menjadi identitas komunitas dan ruang kontribusi anggota Unsri Cyber Lab.</p>
  </div>
</div>

{% include section.html %}

## Write-up Terbaru

{% include list.html data="posts" component="post-excerpt" %}

{% include section.html %}

## Kategori CTF

<div class="category-grid">
  <a class="category-card" href="writeups/?search=&quot;tag: web&quot;"><i class="icon fa-solid fa-globe"></i><h3>Web Exploitation</h3><p>SQLi, XSS, JWT, LFI, RCE, SSRF, dan bypass logic.</p></a>
  <a class="category-card" href="writeups/?search=&quot;tag: crypto&quot;"><i class="icon fa-solid fa-key"></i><h3>Cryptography</h3><p>Classic cipher, encoding, stream cipher, block cipher, dan kesalahan implementasi.</p></a>
  <a class="category-card" href="writeups/?search=&quot;tag: forensics&quot;"><i class="icon fa-solid fa-magnifying-glass-chart"></i><h3>Forensics</h3><p>Analisis file, metadata, packet capture, memory, dan recovery artefak.</p></a>
  <a class="category-card" href="writeups/?search=&quot;tag: pwn&quot;"><i class="icon fa-solid fa-bug"></i><h3>Pwn</h3><p>Binary exploitation, buffer overflow, ROP, dan analisis memory.</p></a>
  <a class="category-card" href="writeups/?search=&quot;tag: reverse&quot;"><i class="icon fa-solid fa-microchip"></i><h3>Reverse Engineering</h3><p>Analisis binary, deobfuscation, patching, dan rekonstruksi logic program.</p></a>
  <a class="category-card" href="writeups/?search=&quot;tag: osint&quot;"><i class="icon fa-solid fa-map-location-dot"></i><h3>OSINT</h3><p>Pencarian informasi terbuka, geolocation, metadata, dan validasi sumber.</p></a>
</div>
