<script setup lang="ts">
import { LINKS, ICONS } from '../constants';
</script>

<template>
  <section class="pt-40 pb-12 px-6 relative overflow-hidden">
    <div class="max-w-4xl mx-auto text-center relative z-10">
      <div class="inline-block mb-4 px-3 py-1 rounded-full bg-white/5 border border-white/10 text-blue-400 text-xs font-medium tracking-wider uppercase">
        macOS Native Utility
      </div>

      <h1 class="text-5xl md:text-7xl font-bold tracking-tight mb-6 bg-clip-text text-transparent bg-gradient-to-b from-white via-white to-white/60">
        極簡，但強大。<br/>
        即時網路監控。
      </h1>

      <p class="text-lg md:text-xl text-gray-400 mb-10 max-w-2xl mx-auto leading-relaxed">
        Fluxo 是一個輕量級的 macOS 選單列應用程式，讓您隨時掌握即時的上傳與下載速度。開源、無廣告。
      </p>

      <div class="flex flex-col sm:flex-row items-center justify-center gap-4">
        <a
          :href="LINKS.APP_STORE"
          target="_blank"
          rel="noopener noreferrer"
          class="w-full sm:w-auto flex items-center justify-center gap-2 bg-blue-600 hover:bg-blue-500 text-white px-8 py-4 rounded-2xl font-semibold transition-all transform hover:-translate-y-1 shadow-lg shadow-blue-900/30"
        >
          <span v-html="ICONS.Download"></span>
          <span>App Store 下載</span>
        </a>

        <a
          :href="LINKS.GITHUB"
          target="_blank"
          rel="noopener noreferrer"
          class="w-full sm:w-auto flex items-center justify-center gap-2 bg-[#1c1c1e] hover:bg-[#2c2c2e] text-white px-8 py-4 rounded-2xl font-semibold border border-white/10 transition-all"
        >
          <span v-html="ICONS.Github"></span>
          <span>查看原始碼</span>
        </a>
      </div>
    </div>
  </section>
</template>
