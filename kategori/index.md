---
title: Kategori
nav:
  order: 4
  tooltip: Kategori soal CTF
---

# {% include icon.html icon="fa-solid fa-layer-group" %}Kategori CTF

Kategori ini membantu pembaca menemukan write-up berdasarkan jenis soal yang sedang dipelajari.

<div class="category-grid">
  <a class="category-card" href="{{ 'writeups' | relative_url }}?search=&quot;tag: web&quot;"><i class="icon fa-solid fa-globe"></i><h3>Web Exploitation</h3><p>Bug pada aplikasi web, API, session, JWT, upload, SQL, dan access control.</p></a>
  <a class="category-card" href="{{ 'writeups' | relative_url }}?search=&quot;tag: crypto&quot;"><i class="icon fa-solid fa-key"></i><h3>Cryptography</h3><p>Encoding, hashing, classic cipher, stream/block cipher, dan cryptanalysis dasar.</p></a>
  <a class="category-card" href="{{ 'writeups' | relative_url }}?search=&quot;tag: forensics&quot;"><i class="icon fa-solid fa-fingerprint"></i><h3>Forensics</h3><p>Investigasi file, gambar, audio, pcap, memory dump, dan artefak digital.</p></a>
  <a class="category-card" href="{{ 'writeups' | relative_url }}?search=&quot;tag: reverse&quot;"><i class="icon fa-solid fa-microchip"></i><h3>Reverse Engineering</h3><p>Membaca logic binary, string, assembly, obfuscation, dan patching.</p></a>
  <a class="category-card" href="{{ 'writeups' | relative_url }}?search=&quot;tag: pwn&quot;"><i class="icon fa-solid fa-bug"></i><h3>Pwn</h3><p>Eksploitasi binary, stack, heap, format string, dan ROP chain.</p></a>
  <a class="category-card" href="{{ 'writeups' | relative_url }}?search=&quot;tag: osint&quot;"><i class="icon fa-solid fa-location-crosshairs"></i><h3>OSINT</h3><p>Open-source intelligence, geolocation, metadata, dan korelasi informasi publik.</p></a>
</div>

{% include section.html %}

## Semua Tag

{% include tags.html tags=site.tags link="writeups" %}
