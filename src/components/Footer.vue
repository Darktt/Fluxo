<script setup lang="ts">
import { useRouter } from 'vue-router';
import { LINKS } from '../constants';

const router = useRouter();
const currentYear = new Date().getFullYear();

const handlePrivacyClick = (e: Event) => {
  e.preventDefault();
  router.push('/privacy-policy');
};
</script>

<template>
  <footer class="py-12 border-t border-white/10 bg-black">
    <div class="max-w-6xl mx-auto px-6 flex flex-col md:flex-row justify-between items-center gap-6">
      <div class="text-gray-500 text-sm">
        © {{ currentYear }} Fluxo Network Monitor. Open Source.
      </div>

      <div class="flex gap-6">
        <a
          href="/privacy-policy"
          @click="handlePrivacyClick"
          class="text-gray-500 hover:text-white transition-colors text-sm"
        >
          Privacy Policy
        </a>
        <a
          :href="LINKS.GITHUB"
          target="_blank"
          rel="noopener noreferrer"
          class="text-gray-500 hover:text-white transition-colors text-sm"
        >
          GitHub
        </a>
        <a
          :href="LINKS.APP_STORE"
          target="_blank"
          rel="noopener noreferrer"
          class="text-gray-500 hover:text-white transition-colors text-sm"
        >
          App Store
        </a>
        <a
          :href="LINKS.GITHUB + '/issues'"
          target="_blank"
          rel="noopener noreferrer"
          class="text-gray-500 hover:text-white transition-colors text-sm"
        >
          Report Issue
        </a>
      </div>
    </div>
  </footer>
</template>
