<script setup lang="ts">
import { ref, onMounted, onUnmounted } from 'vue';
import { useRouter } from 'vue-router';
import { LINKS, ICONS } from '../constants';

const router = useRouter();
const scrolled = ref(false);

const handleScroll = () => {
  scrolled.value = window.scrollY > 20;
};

const handleHomeClick = (e: Event) => {
  e.preventDefault();
  router.push('/');
};

onMounted(() => {
  window.addEventListener('scroll', handleScroll);
});

onUnmounted(() => {
  window.removeEventListener('scroll', handleScroll);
});
</script>

<template>
  <header
    :class="[
      'fixed top-0 left-0 right-0 z-50 transition-all duration-300 border-b',
      scrolled
        ? 'bg-black/70 backdrop-blur-xl border-white/10 py-4'
        : 'bg-transparent border-transparent py-6'
    ]"
  >
    <div class="max-w-6xl mx-auto px-6 flex items-center justify-between">
      <a
        href="/"
        @click="handleHomeClick"
        class="flex items-center gap-2 text-white font-bold text-xl tracking-tight hover:opacity-80 transition-opacity"
      >
        <div class="text-blue-500" v-html="ICONS.Activity"></div>
        <span>Fluxo</span>
      </a>

      <nav class="flex items-center gap-8">
        <a
          :href="LINKS.GITHUB"
          target="_blank"
          rel="noopener noreferrer"
          class="text-sm font-medium text-gray-300 hover:text-white transition-colors"
        >
          GitHub
        </a>
      </nav>
    </div>
  </header>
</template>
