<script setup lang="ts">
import Header from './components/Header.vue';
import Footer from './components/Footer.vue';
</script>

<template>
  <div class="app-root">
    <Header />

    <main>
      <router-view />
    </main>

    <Footer />
  </div>
</template>
