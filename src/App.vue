<script setup lang="ts">
import Header from './components/Header.vue';
import Footer from './components/Footer.vue';
</script>

<template>
  <div class="min-h-screen bg-black text-white selection:bg-blue-500 selection:text-white overflow-x-hidden font-sans">
    <Header />

    <main>
      <router-view />
    </main>

    <Footer />
  </div>
</template>
