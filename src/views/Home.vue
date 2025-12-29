<script setup lang="ts">
import Hero from '../components/Hero.vue';
import MenuBarPreview from '../components/MenuBarPreview.vue';
import Features from '../components/Features.vue';
</script>

<template>
  <div>
    <Hero />

    <!-- Preview Section ID for Navigation -->
    <div id="preview" class="px-6">
      <MenuBarPreview />
    </div>

    <Features />

    <!-- Call to Action Strip -->
    <section class="py-20 border-t border-white/5 bg-gradient-to-b from-black to-[#0a0a0a]">
      <div class="max-w-4xl mx-auto px-6 text-center">
        <h2 class="text-3xl font-bold mb-6">準備好提升您的 macOS 體驗了嗎？</h2>
        <p class="text-gray-400 mb-8">立即下載，開始享受輕量級的網路監控體驗。</p>
        <a
          href="https://apps.apple.com/tw/app/fluxo-network-monitor/id6753338351?mt=12"
          target="_blank"
          rel="noopener noreferrer"
          class="inline-flex items-center gap-2 bg-white text-black px-8 py-3 rounded-full font-bold hover:bg-gray-200 transition-colors"
        >
          前往 App Store 下載
        </a>
      </div>
    </section>
  </div>
</template>
