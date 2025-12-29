# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Fluxo is a landing page for a macOS network monitor application. The project is a Vue 3-based single-page application built with Vite, TypeScript, and traditional CSS with a semantic class naming system. The site showcases the Fluxo app features and provides links to download from the App Store.

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
- **src/main.ts**: Application entry point, creates Vue app, configures router, and imports all CSS styles
- **src/views/**: View components for routes
  - **Home.vue**: Home page view combining Hero, MenuBarPreview, and Features
- **src/components/**: All presentational components
  - **Header.vue**: Fixed header with navigation, uses Vue Router for navigation
  - **Hero.vue**: Landing page hero section with CTA
  - **MenuBarPreview.vue**: Visual mockup of the Fluxo app interface
  - **Features.vue**: Feature highlights section
  - **Footer.vue**: Footer with links
  - **PrivacyPolicy.vue**: Privacy policy page (separate route)

### CSS Architecture

The project uses traditional CSS with a semantic class naming system and CSS custom properties:

- **src/styles/**: CSS style files
  - **variables.css**: 100+ CSS custom properties (design tokens) for colors, spacing, typography, shadows, transitions, etc.
  - **global.css**: CSS reset and global base styles
  - **layout.css**: Layout utility classes (flexbox, grid, positioning)
  - **responsive.css**: Media query breakpoints (640px, 768px, 1024px, 1280px)
  - **components/**: Component-specific styles
    - **app.css**: App root styles
    - **header.css**: Header component with glassmorphism effect
    - **hero.css**: Hero section with gradient text
    - **menu-bar-preview.css**: Complex macOS window mockup
    - **features.css**: Feature cards with decorative blur background
    - **footer.css**: Footer styles
    - **privacy-policy.css**: Privacy policy page typography
    - **home.css**: Home view CTA section

#### CSS Variables System

The project uses CSS custom properties for design tokens:

```css
:root {
  /* Colors */
  --color-primary: #007AFF;
  --color-dark: #1c1c1e;
  --color-darker: #000000;

  /* Spacing */
  --spacing-xs: 0.5rem;
  --spacing-sm: 0.75rem;
  --spacing-md: 1rem;
  --spacing-lg: 1.5rem;

  /* Typography */
  --font-sans: 'Inter', system-ui, sans-serif;
  --text-sm: 0.875rem;
  --text-base: 1rem;

  /* Effects */
  --radius-xl: 1rem;
  --shadow-lg: 0 10px 15px -3px rgba(0, 0, 0, 0.1);
  --transition-base: 300ms cubic-bezier(0.4, 0, 0.2, 1);
}
```

#### Semantic Class Naming

The project follows BEM-inspired naming conventions:

```css
/* Component classes */
.site-header { }
.site-header--scrolled { }    /* Modifier */
.header-container { }
.header-logo { }
.header-logo-icon { }         /* Child element */

/* Feature classes */
.hero-section { }
.hero-title { }
.hero-cta-primary { }
.hero-cta-secondary { }

.feature-card { }
.feature-icon { }
.feature-title { }
```

#### Advanced CSS Effects

The project preserves all advanced visual effects:
- **Glassmorphism**: `backdrop-filter: blur(24px)` on header when scrolled
- **Gradient text**: `background-clip: text` for hero title
- **Decorative blur backgrounds**: `filter: blur(100px)` for soft glows
- **Hover animations**: `transform`, `scale`, `translateY` on interactive elements

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
- **index.html**: HTML entry point that loads the Vue app from `/src/main.ts`

### Shared Constants

- **src/constants.ts**: Exports `LINKS` (GitHub, App Store, Author) and `ICONS` (SVG string icons) used across components
- **src/types.ts**: Shared TypeScript interfaces for `FeatureItem` and `LinkItem`

## Important Notes

### Styling Approach
- Uses traditional CSS with semantic class names
- CSS custom properties (CSS Variables) for design tokens
- BEM-inspired naming convention for maintainability
- Component-based CSS organization (one file per component)
- Mobile-first responsive design with media queries
- Font: Inter from Google Fonts
- Production CSS bundle: ~24KB (~5KB gzipped)

### Adding New Styles

When adding new component styles:

1. Create a new CSS file in `src/styles/components/[component-name].css`
2. Use semantic class names following BEM conventions
3. Use CSS variables instead of hardcoded values
4. Import the CSS file in `src/main.ts`

Example:

```css
/* src/styles/components/my-component.css */
.my-component {
  padding: var(--spacing-lg);
  background-color: var(--color-dark);
  border-radius: var(--radius-xl);
  transition: var(--transition-base);
}

.my-component:hover {
  background-color: var(--color-dark-hover);
}

.my-component__title {
  font-size: var(--text-2xl);
  font-weight: var(--font-bold);
  color: var(--color-text-primary);
}
```

### Modifying Design Tokens

To change design system values, edit `src/styles/variables.css`:

```css
:root {
  /* Modify existing token */
  --color-primary: #your-color;

  /* Add new token */
  --spacing-custom: 2.5rem;
}
```

### Dependencies
- Vue 3.4.0 and Vue Router 4.3.0 installed via npm
- Vite 6.2.0 for build tooling
- TypeScript 5.8.2 and vue-tsc 2.0.0 for type checking
- No CSS frameworks or preprocessors

### Build Considerations
- Dev server runs on port 3000 with host '0.0.0.0'
- Base path is '/' (configured in vite.config.ts)
- Environment variables: GEMINI_API_KEY (though not actively used in current codebase)
- Production build generates optimized CSS and JS bundles
- Type checking available via `vue-tsc --noEmit`
- All CSS is bundled into a single optimized file

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
  <div class="my-component">
    <span class="my-component__count">{{ count }}</span>
  </div>
</template>
```

#### Using Icons
Icons are stored as SVG strings in `src/constants.ts`. Use `v-html` to render them:

```vue
<script setup lang="ts">
import { ICONS } from '@/constants';
</script>

<template>
  <div class="icon-wrapper" v-html="ICONS.Github"></div>
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

### Responsive Design

The project uses mobile-first responsive design with these breakpoints:

```css
/* Breakpoints match common device sizes */
@media (min-width: 640px)  { /* sm: Mobile landscape / small tablets */ }
@media (min-width: 768px)  { /* md: Tablets / small laptops */ }
@media (min-width: 1024px) { /* lg: Laptops */ }
@media (min-width: 1280px) { /* xl: Desktops */ }
```

When writing responsive styles, use these breakpoints consistently across components.

### Development Tips

1. **Hot Module Replacement (HMR)**: Vite provides fast HMR for both Vue SFCs and CSS files
2. **Type Checking**: Run `vue-tsc --noEmit` before committing
3. **CSS Organization**: Keep component styles in separate files for better maintainability
4. **Design Tokens**: Always use CSS variables from `variables.css` instead of hardcoded values
5. **Class Naming**: Follow BEM-inspired conventions for consistency
6. **DevTools**: Use Vue DevTools browser extension for debugging
7. **Path Aliases**: Use `@/` to import from project root (configured in vite.config.ts)

### Performance Considerations

- CSS is bundled and minified in production (~5KB gzipped)
- All CSS variables are resolved at runtime by the browser
- No unused CSS since all styles are component-specific
- Images and assets should be optimized before committing
- Use lazy loading for routes if the app grows larger
