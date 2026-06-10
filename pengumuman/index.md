---
title: Pengumuman
nav:
  order: 5
  tooltip: Pengumuman dan agenda 0xUCL
---

# {% include icon.html icon="fa-solid fa-bullhorn" %}Pengumuman

<div class="announcement-hero">
  <div class="announcement-hero-copy">
    <span class="announcement-kicker">OxUCL Announcement Board</span>
    <h2>Info kegiatan, agenda, dan update komunitas</h2>
    <p>
      Halaman ini berisi pengumuman resmi 0xUCL, mulai dari gathering,
      sharing session, latihan CTF, open recruitment, sampai update komunitas.
    </p>
  </div>
</div>

{% assign announcements = site.announcements | sort: "date" | reverse %}
{% assign pinned_announcements = announcements | where: "pinned", true %}

{% include section.html %}

{% if pinned_announcements.size > 0 %}
## Pengumuman Utama

<div class="announcement-featured-grid">
  {% for announcement in pinned_announcements limit: 2 %}
    {% include announcement-card.html announcement=announcement featured=true %}
  {% endfor %}
</div>

{% include section.html %}
{% endif %}

## Daftar Pengumuman

<div class="announcement-list">
  {% for announcement in announcements %}
    {% include announcement-card.html announcement=announcement %}
  {% endfor %}
</div>
