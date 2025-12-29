<script setup lang="ts">
import Hero from '../components/Hero.vue';
import MenuBarPreview from '../components/MenuBarPreview.vue';
import Features from '../components/Features.vue';
</script>

<template>
  <div>
    <Hero />

    <!-- Preview Section ID for Navigation -->
    <div id="preview" class="preview-section-wrapper">
      <MenuBarPreview />
    </div>

    <Features />

    <!-- Call to Action Strip -->
    <section class="cta-section">
      <div class="cta-container">
        <h2 class="cta-title">準備好提升您的 macOS 體驗了嗎？</h2>
        <p class="cta-description">立即下載，開始享受輕量級的網路監控體驗。</p>
        <a
          href="https://apps.apple.com/tw/app/fluxo-network-monitor/id6753338351?mt=12"
          target="_blank"
          rel="noopener noreferrer"
          class="cta-button"
        >
          前往 App Store 下載
        </a>
      </div>
    </section>
  </div>
</template>
