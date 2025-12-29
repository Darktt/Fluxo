# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Fluxo is a landing page for a macOS network monitor application. The project is a Vue 3-based single-page application built with Vite, TypeScript, and Tailwind CSS. The site showcases the Fluxo app features and provides links to download from the App Store.

## Development Commands

```bash
# Start development server (runs on http://localhost:3000)
npm run dev

# Build for production
npm run build

# Preview production build
npm run preview
```

## Architecture

### Component Structure

The app uses Vue 3 Composition API with Single File Components (SFC):

- **src/App.vue**: Root component with router-view for page rendering
- **src/main.ts**: Application entry point, creates Vue app and configures router
- **src/views/**: View components for routes
  - **Home.vue**: Home page view combining Hero, MenuBarPreview, and Features
- **src/components/**: All presentational components
  - **Header.vue**: Fixed header with navigation, uses Vue Router for navigation
  - **Hero.vue**: Landing page hero section with CTA
  - **MenuBarPreview.vue**: Visual mockup of the Fluxo app interface
  - **Features.vue**: Feature highlights section
  - **Footer.vue**: Footer with links
  - **PrivacyPolicy.vue**: Privacy policy page (separate route)

### Routing System

This app uses Vue Router 4 (official routing library):

1. **src/router/index.ts** configures routes with Vue Router:
   - `/` route points to Home.vue
   - `/privacy-policy` route points to PrivacyPolicy.vue
   - Catch-all route redirects to home
2. Components use `useRouter()` composable for navigation: `router.push('/path')`
3. **router-view** in App.vue renders the matched component
4. **scrollBehavior** configured to scroll to top on navigation
5. Browser back/forward handled automatically by Vue Router

This official routing solution provides a robust, well-tested navigation system.

### Configuration Files

- **vite.config.ts**: Vite configuration with Vue plugin, path aliases (`@/`), and environment variable handling for GEMINI_API_KEY
- **tsconfig.json**: TypeScript configuration with `jsx: preserve` for Vue, path aliases, and ES2022 target
- **tailwind.config.js**: Tailwind CSS configuration with custom colors and fonts
- **postcss.config.js**: PostCSS configuration with Tailwind and Autoprefixer
- **index.html**: HTML entry point that loads the Vue app from `/src/main.ts`

### Shared Constants

- **src/constants.ts**: Exports `LINKS` (GitHub, App Store, Author) and `ICONS` (SVG string icons) used across components
- **src/types.ts**: Shared TypeScript interfaces for `FeatureItem` and `LinkItem`
- **src/index.css**: Tailwind directives and global styles

## Important Notes

### Styling Approach
- Uses Tailwind CSS via PostCSS (installed as npm package, not CDN)
- Custom colors defined in tailwind.config.js: `primary` (#007AFF), `dark` (#1c1c1e), `darker` (#000000)
- Font: Inter from Google Fonts
- Global styles in src/index.css include Tailwind directives and custom scrollbar hiding
- Production CSS is purged and optimized (~4KB gzipped)

### Dependencies
- Vue 3.4.0 and Vue Router 4.3.0 installed via npm
- Tailwind CSS 3.4.0, PostCSS, and Autoprefixer as dev dependencies
- Vite 6.2.0 for build tooling
- TypeScript 5.8.2 and vue-tsc 2.0.0 for type checking

### Build Considerations
- Dev server runs on port 3000 with host '0.0.0.0'
- Base path is '/' (configured in vite.config.ts)
- Environment variables: GEMINI_API_KEY (though not actively used in current codebase)
- Production build generates optimized CSS and JS bundles
- Type checking available via `vue-tsc --noEmit`

### Navigation Implementation
When adding new routes or navigation links:
1. Add route to `src/router/index.ts` with path and component
2. Create corresponding view component in `src/views/` or `src/components/`
3. Use Vue Router for navigation:
   - In template: `<router-link to="/path">Link</router-link>`
   - In script: `const router = useRouter(); router.push('/path')`
4. Never use standard `<a>` tags for internal navigation without using Vue Router

### Direct URL Access Support

The app supports direct URL access to routes (e.g., `/privacy-policy`) through:

1. **Development/Preview**: `historyApiFallback: true` in vite.config.ts ensures all routes return index.html
2. **Production (Static Hosting)**: `public/404.html` redirects to index.html with path preserved
   - Works with GitHub Pages and other static hosts
   - Path is encoded in query string and decoded by script in index.html
3. **index.html**: Contains redirect handling script that restores original URL from query parameters
4. **Vue Router**: Uses HTML5 History mode (`createWebHistory`) for clean URLs without hash

### Vue 3 Development Patterns

#### Component Structure
All components use Composition API with `<script setup lang="ts">`:

```vue
<script setup lang="ts">
import { ref, onMounted, onUnmounted } from 'vue';

// Reactive state
const count = ref(0);

// Lifecycle hooks
onMounted(() => {
  console.log('Component mounted');
});
</script>

<template>
  <div>{{ count }}</div>
</template>
```

#### Using Icons
Icons are stored as SVG strings in `src/constants.ts`. Use `v-html` to render them:

```vue
<script setup lang="ts">
import { ICONS } from '@/constants';
</script>

<template>
  <div v-html="ICONS.Github"></div>
</template>
```

#### State Management
This project uses local component state with `ref()` and `reactive()`:
- `ref()` for primitive values (numbers, strings, booleans)
- `reactive()` for objects and arrays (though not used in current codebase)

#### Type Safety
- Use `defineProps<PropsType>()` for typed props
- Import types from `src/types.ts`
- Use `type` imports: `import type { FeatureItem } from '@/types'`

### Development Tips

1. **Hot Module Replacement (HMR)**: Vite provides fast HMR for Vue SFCs
2. **Type Checking**: Run `vue-tsc --noEmit` before committing
3. **Linting**: Configure ESLint with Vue plugin for best practices
4. **DevTools**: Use Vue DevTools browser extension for debugging
5. **Path Aliases**: Use `@/` to import from project root (configured in vite.config.ts)
