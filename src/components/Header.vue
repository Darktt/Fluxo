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
    :class="['site-header', { 'site-header--scrolled': scrolled }]"
  >
    <div class="header-container">
      <a
        href="/"
        @click="handleHomeClick"
        class="header-logo"
      >
        <div class="header-logo-icon" v-html="ICONS.Activity"></div>
        <span>Fluxo</span>
      </a>

      <nav class="header-nav">
        <a
          :href="LINKS.GITHUB"
          target="_blank"
          rel="noopener noreferrer"
          class="header-link"
        >
          GitHub
        </a>
      </nav>
    </div>
  </header>
</template>
