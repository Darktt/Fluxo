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
  <footer class="site-footer">
    <div class="footer-container">
      <div class="footer-copyright">
        © {{ currentYear }} Fluxo Network Monitor. Open Source.
      </div>

      <div class="footer-links">
        <a
          href="/privacy-policy"
          @click="handlePrivacyClick"
          class="footer-link"
        >
          Privacy Policy
        </a>
        <a
          :href="LINKS.GITHUB"
          target="_blank"
          rel="noopener noreferrer"
          class="footer-link"
        >
          GitHub
        </a>
        <a
          :href="LINKS.APP_STORE"
          target="_blank"
          rel="noopener noreferrer"
          class="footer-link"
        >
          App Store
        </a>
        <a
          :href="LINKS.GITHUB + '/issues'"
          target="_blank"
          rel="noopener noreferrer"
          class="footer-link"
        >
          Report Issue
        </a>
      </div>
    </div>
  </footer>
</template>
