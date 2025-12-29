<script setup lang="ts">
import { ICONS } from '../constants';
import type { FeatureItem } from '../types';

const features: FeatureItem[] = [
  {
    title: "即時監控",
    description: "精確到秒的網路速度更新，讓您即時了解上傳與下載頻寬的使用狀況。",
    icon: ICONS.Speed
  },
  {
    title: "高度客製化",
    description: "支援多種顯示模式，您可以自訂文字顏色、圖示樣式以及數據單位顯示。",
    icon: ICONS.Custom
  },
  {
    title: "macOS 原生體驗",
    description: "專為 macOS 設計，支援深色模式，與您的系統外觀完美融合，佔用極少資源。",
    icon: ICONS.Native
  }
];
</script>

<template>
  <section id="features" class="features-section">
    <!-- Background Gradient blob -->
    <div class="features-bg-blur"></div>

    <div class="features-container">
      <div class="features-header">
        <h2 class="features-title">為什麼選擇 Fluxo？</h2>
        <p class="features-description">
          拋棄繁雜的儀表板，回歸最純粹的數據呈現。Fluxo 專注於提供最核心的資訊，不打擾您的工作流程。
        </p>
      </div>

      <div class="features-grid">
        <div
          v-for="(feature, index) in features"
          :key="index"
          class="feature-card"
        >
          <div class="feature-icon">
            <span v-html="feature.icon"></span>
          </div>
          <h3 class="feature-title">{{ feature.title }}</h3>
          <p class="feature-description">{{ feature.description }}</p>
        </div>
      </div>
    </div>
  </section>
</template>
