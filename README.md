# Fluxo Landing Page

> 極簡但強大的 macOS 網路監控工具的官方網站

這是 [Fluxo](https://github.com/Darktt/Fluxo) 的官方 Landing Page，使用 Vue 3 + TypeScript + Tailwind CSS 構建。

## 🚀 技術棧

- **框架**: [Vue 3.4](https://vuejs.org/) - 使用 Composition API
- **路由**: [Vue Router 4.3](https://router.vuejs.org/) - 官方路由解決方案
- **語言**: [TypeScript 5.8](https://www.typescriptlang.org/) - 完整類型支持
- **構建工具**: [Vite 6.2](https://vitejs.dev/) - 快速的開發體驗
- **樣式**: [Tailwind CSS 3.4](https://tailwindcss.com/) - 實用優先的 CSS 框架
- **後處理**: PostCSS + Autoprefixer

## 📦 項目結構

```
Fluxo-page/
├── src/
│   ├── components/          # Vue 組件
│   │   ├── Header.vue       # 導航欄（帶滾動效果）
│   │   ├── Hero.vue         # 首頁橫幅
│   │   ├── MenuBarPreview.vue  # 應用預覽
│   │   ├── Features.vue     # 功能展示
│   │   ├── Footer.vue       # 頁尾
│   │   └── PrivacyPolicy.vue   # 隱私政策
│   ├── views/               # 視圖組件
│   │   └── Home.vue         # 首頁視圖
│   ├── router/              # 路由配置
│   │   └── index.ts         # Vue Router 設置
│   ├── constants.ts         # 常量（連結、圖標）
│   ├── types.ts             # TypeScript 類型定義
│   ├── index.css            # Tailwind 導入 + 全局樣式
│   ├── App.vue              # 根組件
│   └── main.ts              # 應用入口點
├── public/
│   └── 404.html             # GitHub Pages SPA 重定向
├── index.html               # HTML 入口
├── vite.config.ts           # Vite 配置
├── tailwind.config.js       # Tailwind 配置
├── postcss.config.js        # PostCSS 配置
└── tsconfig.json            # TypeScript 配置
```

## 🛠️ 開發

### 安裝依賴

```bash
npm install
```

### 啟動開發服務器

```bash
npm run dev
```

開發服務器將在 `http://localhost:3000` 上運行。

### 類型檢查

```bash
npx vue-tsc --noEmit
```

### 構建生產版本

```bash
npm run build
```

構建結果將在 `dist/` 目錄中。

### 預覽生產版本

```bash
npm run preview
```

## 📱 功能特性

### 路由

- **首頁** (`/`) - 展示 Fluxo 的主要功能
- **隱私政策** (`/privacy-policy`) - 完整的隱私政策文檔

### 組件功能

- ✅ **響應式設計** - 支持桌面和移動設備
- ✅ **滾動效果** - 導航欄在滾動時變為半透明
- ✅ **客戶端路由** - 使用 Vue Router 實現無刷新導航
- ✅ **直接 URL 訪問** - 支持通過 URL 直接訪問任何頁面（GitHub Pages 兼容）
- ✅ **TypeScript** - 完整的類型安全
- ✅ **優化打包** - 使用 PostCSS 的 Tailwind CSS，大幅減小文件大小

## 📊 性能指標

### 打包大小

```
dist/index.html                1.41 kB │ gzip: 0.74 kB
dist/assets/index-*.css       18.46 kB │ gzip: 4.08 kB  ⚡️
dist/assets/index-*.js       118.50 kB │ gzip: 44.31 kB
```

### 主要優化

- **CSS 優化**: 從 CDN 的 3.5MB 減少到 4.08 kB (壓縮後) - 減少 **99.88%**
- **Tree-shaking**: 僅包含使用的 Tailwind 類
- **代碼分割**: Vue Router 支持懶加載（可選）

## 🎨 設計系統

### 顏色主題

```js
colors: {
  primary: '#007AFF',   // Apple Blue
  dark: '#1c1c1e',      // Apple Dark Grey
  darker: '#000000',    // Pure Black
}
```

### 字體

- **主要字體**: [Inter](https://fonts.google.com/specimen/Inter) - Google Fonts
- **回退字體**: system-ui, sans-serif

## 🚢 部署

### GitHub Pages

項目已配置為在 GitHub Pages 上運行：

1. 構建生產版本: `npm run build`
2. `public/404.html` 會處理 SPA 路由重定向
3. 部署 `dist/` 目錄到 GitHub Pages

### 其他平台

支持任何靜態托管平台：
- Vercel
- Netlify
- Cloudflare Pages
- Firebase Hosting

確保配置重定向規則以支持 SPA 路由。

## 🔧 配置

### Vite

- **開發服務器**: 端口 3000，監聽 0.0.0.0
- **預覽服務器**: 端口 4173
- **History API Fallback**: 啟用（支持客戶端路由）

### TypeScript

- **目標**: ES2022
- **模塊**: ESNext
- **JSX**: preserve（用於 Vue）
- **嚴格模式**: 啟用類型檢查

### Tailwind

- **內容**: 掃描 `src/**/*.{vue,js,ts,jsx,tsx}` 和 `index.html`
- **主題擴展**: 自定義顏色和字體
- **JIT 模式**: 按需生成 CSS

## 📝 開發指南

### 添加新組件

1. 在 `src/components/` 創建 `.vue` 文件
2. 使用 `<script setup lang="ts">` 語法
3. 使用 Composition API
4. 導出類型定義到 `src/types.ts`（如需要）

### 添加新路由

1. 在 `src/router/index.ts` 添加路由配置
2. 創建對應的視圖組件
3. 使用 `router.push()` 進行導航

### 使用圖標

圖標存儲為 SVG 字串在 `src/constants.ts` 中：

```vue
<template>
  <div v-html="ICONS.Github"></div>
</template>

<script setup lang="ts">
import { ICONS } from '@/constants';
</script>
```

## 🆚 從 React 遷移

此項目最初使用 React 構建，現已遷移到 Vue 3。主要變化：

| 方面 | React | Vue 3 |
|------|-------|-------|
| 狀態管理 | `useState` | `ref()` / `reactive()` |
| 生命週期 | `useEffect` | `onMounted` / `onUnmounted` |
| 路由 | 自定義事件系統 | Vue Router |
| 模板 | JSX | Vue Template |
| 包大小 | ~150KB | ~118KB (gzipped: 44KB) |

### 遷移優勢

- ✅ 更小的打包體積
- ✅ 更快的構建速度
- ✅ 更簡潔的路由邏輯
- ✅ 更好的 TypeScript 集成
- ✅ 官方路由解決方案

## 🤝 貢獻

歡迎提交 Issue 和 Pull Request！

## 📄 許可證

開源項目 - 查看 [Fluxo 主倉庫](https://github.com/Darktt/Fluxo) 獲取更多信息。

## 🔗 相關連結

- [Fluxo App Store](https://apps.apple.com/tw/app/fluxo-network-monitor/id6753338351?mt=12)
- [Fluxo GitHub](https://github.com/Darktt/Fluxo)
- [隱私政策](/privacy-policy)
- [問題回報](https://github.com/Darktt/Fluxo/issues)

---

使用 [Vue 3](https://vuejs.org/) 和 ❤️ 構建
