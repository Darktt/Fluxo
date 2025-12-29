# Fluxo Landing Page

> 極簡但強大的 macOS 網路監控工具的官方網站

這是 [Fluxo](https://github.com/Darktt/Fluxo) 的官方 Landing Page，使用 Vue 3 + TypeScript + 傳統 CSS 構建。

## 🚀 技術棧

- **框架**: [Vue 3.4](https://vuejs.org/) - 使用 Composition API
- **路由**: [Vue Router 4.3](https://router.vuejs.org/) - 官方路由解決方案
- **語言**: [TypeScript 5.8](https://www.typescriptlang.org/) - 完整類型支持
- **構建工具**: [Vite 6.2](https://vitejs.dev/) - 快速的開發體驗
- **樣式**: 傳統 CSS - 語義化類名 + CSS 變量系統

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
│   ├── styles/              # CSS 樣式文件
│   │   ├── variables.css    # CSS 變量系統
│   │   ├── global.css       # 全局樣式和重置
│   │   ├── layout.css       # 佈局工具類
│   │   ├── responsive.css   # 響應式媒體查詢
│   │   └── components/      # 組件樣式
│   │       ├── app.css
│   │       ├── header.css
│   │       ├── hero.css
│   │       ├── menu-bar-preview.css
│   │       ├── features.css
│   │       ├── footer.css
│   │       ├── privacy-policy.css
│   │       └── home.css
│   ├── constants.ts         # 常量（連結、圖標）
│   ├── types.ts             # TypeScript 類型定義
│   ├── App.vue              # 根組件
│   └── main.ts              # 應用入口點
├── public/
│   └── 404.html             # GitHub Pages SPA 重定向
├── index.html               # HTML 入口
├── vite.config.ts           # Vite 配置
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
- ✅ **滾動效果** - 導航欄在滾動時變為半透明（玻璃態效果）
- ✅ **客戶端路由** - 使用 Vue Router 實現無刷新導航
- ✅ **直接 URL 訪問** - 支持通過 URL 直接訪問任何頁面（GitHub Pages 兼容）
- ✅ **TypeScript** - 完整的類型安全
- ✅ **語義化 CSS** - 易於維護和理解的類名
- ✅ **CSS 變量系統** - 易於主題化和自定義

## 📊 性能指標

### 打包大小

```
dist/index.html                1.41 kB │ gzip: 0.75 kB
dist/assets/index-*.css       24.68 kB │ gzip: 5.02 kB  ⚡️
dist/assets/index-*.js       115.10 kB │ gzip: 43.29 kB
```

### CSS 架構優勢

- **語義化類名**: 使用 `.site-header`, `.hero-title` 等易讀的類名
- **無未使用樣式**: 所有 CSS 都是為實際組件編寫的
- **更好的可維護性**: 組件樣式獨立，便於修改和擴展
- **CSS 變量系統**: 100+ 設計令牌，統一管理顏色、間距、字體等

## 🎨 設計系統

### CSS 變量架構

項目使用 CSS 自定義屬性（CSS Variables）來管理設計令牌：

```css
:root {
  /* 顏色系統 */
  --color-primary: #007AFF;
  --color-dark: #1c1c1e;
  --color-darker: #000000;

  /* 間距系統 */
  --spacing-xs: 0.5rem;
  --spacing-sm: 0.75rem;
  --spacing-md: 1rem;
  --spacing-lg: 1.5rem;
  /* ... 更多間距 */

  /* 字體系統 */
  --font-sans: 'Inter', system-ui, sans-serif;
  --text-sm: 0.875rem;
  --text-base: 1rem;
  --text-xl: 1.25rem;
  /* ... 更多尺寸 */

  /* 圓角、陰影、過渡等 */
  --radius-xl: 1rem;
  --shadow-lg: 0 10px 15px -3px rgba(0, 0, 0, 0.1);
  --transition-base: 300ms cubic-bezier(0.4, 0, 0.2, 1);
}
```

### 顏色主題

```css
--color-primary: #007AFF;     /* Apple Blue */
--color-dark: #1c1c1e;        /* Apple Dark Grey */
--color-darker: #000000;      /* Pure Black */
--color-blue-500: #3b82f6;    /* Accent Blue */
```

### 字體

- **主要字體**: [Inter](https://fonts.google.com/specimen/Inter) - Google Fonts
- **回退字體**: system-ui, -apple-system, sans-serif

### 特殊效果

項目保留了所有高級 CSS 效果：
- **Glassmorphism（玻璃態）**: `backdrop-filter: blur(24px)`
- **漸變文字**: `background-clip: text`
- **裝飾性模糊背景**: `filter: blur(100px)`
- **Hover 動畫**: `transform`, `scale`, `translate`

## 🏗️ CSS 架構

### 樣式層次結構

1. **variables.css** - 設計令牌（顏色、間距、字體等）
2. **global.css** - 重置樣式和全局基礎樣式
3. **layout.css** - 佈局工具類（flexbox, grid, positioning）
4. **responsive.css** - 響應式斷點配置
5. **components/*.css** - 組件專屬樣式

### 語義化類名規範

```css
/* BEM-inspired naming */
.site-header { }
.site-header--scrolled { }    /* 修飾符 */
.header-container { }
.header-logo { }
.header-logo-icon { }         /* 子元素 */

/* 組件類名 */
.hero-section { }
.hero-title { }
.hero-cta-primary { }
.hero-cta-secondary { }

/* 功能卡片 */
.feature-card { }
.feature-icon { }
.feature-title { }
```

### 響應式斷點

```css
/* Mobile-first approach */
@media (min-width: 640px)  { /* sm: 手機橫屏 / 小平板 */ }
@media (min-width: 768px)  { /* md: 平板 / 小筆電 */ }
@media (min-width: 1024px) { /* lg: 筆電 */ }
@media (min-width: 1280px) { /* xl: 桌面 */ }
```

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

## 📝 開發指南

### 添加新組件

1. 在 `src/components/` 創建 `.vue` 文件
2. 使用 `<script setup lang="ts">` 語法
3. 使用 Composition API
4. 導出類型定義到 `src/types.ts`（如需要）

### 添加組件樣式

1. 在 `src/styles/components/` 創建對應的 `.css` 文件
2. 使用語義化類名（遵循 BEM 規範）
3. 使用 CSS 變量而不是硬編碼值
4. 在 `main.ts` 中導入樣式文件

```css
/* 範例：新組件樣式 */
.my-component {
  padding: var(--spacing-lg);
  background-color: var(--color-dark);
  border-radius: var(--radius-xl);
  transition: var(--transition-base);
}

.my-component:hover {
  background-color: var(--color-dark-hover);
}
```

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

### 自定義設計令牌

編輯 `src/styles/variables.css` 來修改設計系統：

```css
:root {
  /* 修改主色調 */
  --color-primary: #your-color;

  /* 添加新的間距 */
  --spacing-custom: 2.5rem;

  /* 自定義字體 */
  --font-sans: 'Your Font', system-ui, sans-serif;
}
```

## 🔄 項目演進

### 從 React 遷移到 Vue 3

此項目最初使用 React 構建，後遷移到 Vue 3。

| 方面 | React | Vue 3 |
|------|-------|-------|
| 狀態管理 | `useState` | `ref()` / `reactive()` |
| 生命週期 | `useEffect` | `onMounted` / `onUnmounted` |
| 路由 | 自定義事件系統 | Vue Router |
| 模板 | JSX | Vue Template |
| 包大小 | ~150KB | ~118KB (gzipped: 44KB) |

### 從 Tailwind CSS 遷移到傳統 CSS

最近從 Tailwind CSS 轉換為傳統 CSS 架構。

| 方面 | Tailwind CSS | 傳統 CSS |
|------|--------------|----------|
| 類名風格 | `bg-blue-600 px-8 py-4` | `.hero-cta-primary` |
| 配置 | tailwind.config.js | CSS 變量 |
| 打包大小 | 18.46 KB (4.08 KB gzipped) | 24.68 KB (5.02 KB gzipped) |
| 可維護性 | 中等（長類名） | 高（語義化類名） |
| 自定義能力 | 受限於框架 | 完全自由 |
| 學習曲線 | 需學習框架 | 標準 CSS |

### 遷移優勢

**Vue 3 優勢**:
- ✅ 更小的打包體積
- ✅ 更快的構建速度
- ✅ 更簡潔的路由邏輯
- ✅ 更好的 TypeScript 集成

**傳統 CSS 優勢**:
- ✅ 語義化類名，易於理解
- ✅ 無框架依賴，純 CSS
- ✅ 更好的可維護性
- ✅ 完全的樣式控制
- ✅ 統一的設計令牌系統
- ✅ 更小的學習成本

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
