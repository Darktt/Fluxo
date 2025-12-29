<script setup lang="ts">
import { LINKS, ICONS } from '../constants';
</script>

<template>
  <section class="hero-section">
    <div class="hero-container">
      <div class="hero-badge">
        macOS Native Utility
      </div>

      <h1 class="hero-title">
        極簡，但強大。<br/>
        即時網路監控。
      </h1>

      <p class="hero-description">
        Fluxo 是一個輕量級的 macOS 選單列應用程式，讓您隨時掌握即時的上傳與下載速度。開源、無廣告。
      </p>

      <div class="hero-cta-group">
        <a
          :href="LINKS.APP_STORE"
          target="_blank"
          rel="noopener noreferrer"
          class="hero-cta-primary"
        >
          <span v-html="ICONS.Download"></span>
          <span>App Store 下載</span>
        </a>

        <a
          :href="LINKS.GITHUB"
          target="_blank"
          rel="noopener noreferrer"
          class="hero-cta-secondary"
        >
          <span v-html="ICONS.Github"></span>
          <span>查看原始碼</span>
        </a>
      </div>
    </div>
  </section>
</template>
