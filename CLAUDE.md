# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Fluxo is a landing page for a macOS network monitor application. The project is a React-based single-page application built with Vite, TypeScript, and Tailwind CSS. The site showcases the Fluxo app features and provides links to download from the App Store.

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

The app uses a simple component-based architecture with client-side routing handled through custom events:

- **App.tsx**: Root component managing routing state via `window.location.pathname` and custom `navigate` events
- **components/**: All presentational components
  - **Header.tsx**: Fixed header with navigation, dispatches custom `navigate` events
  - **Hero.tsx**: Landing page hero section with CTA
  - **MenuBarPreview.tsx**: Visual mockup of the Fluxo app interface
  - **Features.tsx**: Feature highlights section
  - **Footer.tsx**: Footer with links
  - **PrivacyPolicy.tsx**: Privacy policy page (separate route)

### Routing System

This app implements a custom client-side routing system without a routing library:

1. **App.tsx** tracks `currentPath` via `useState(window.location.pathname)`
2. Components dispatch custom `navigate` events: `window.dispatchEvent(new CustomEvent('navigate', { detail: '/' }))`
3. **App.tsx** listens for `navigate` events and:
   - Updates UI state immediately via `setCurrentPath()`
   - Attempts to update browser URL via `window.history.pushState()` (wrapped in try-catch for sandboxed environments)
4. Browser back/forward handled via `popstate` event listener

This pattern allows navigation without full page reloads while maintaining URL state.

### Configuration Files

- **vite.config.ts**: Vite configuration with React plugin, path aliases (`@/`), and environment variable handling for GEMINI_API_KEY
- **tsconfig.json**: TypeScript configuration with React JSX, path aliases, and ES2022 target
- **index.html**: Uses Tailwind CDN and aistudiocdn.com for React imports via import maps

### Shared Constants

- **constants.tsx**: Exports `LINKS` (GitHub, App Store, Author) and `ICONS` (SVG icon components) used across components
- **types.ts**: Shared TypeScript interfaces for `FeatureItem` and `LinkItem`

## Important Notes

### Styling Approach
- Uses Tailwind CSS via CDN (configured in index.html)
- Custom colors defined in Tailwind config: `primary` (#007AFF), `dark` (#1c1c1e), `darker` (#000000)
- Font: Inter from Google Fonts
- Global styles in index.html include custom scrollbar hiding

### External Dependencies
- React 19.2.0 served from aistudiocdn.com via import maps (not npm)
- Tailwind CSS served from CDN
- No router library (custom routing implementation)

### Build Considerations
- Dev server runs on port 3000 with host '0.0.0.0'
- Base path is '/' (configured in vite.config.ts)
- Environment variables: GEMINI_API_KEY (though not actively used in current codebase)

### Navigation Implementation
When adding new routes or navigation links:
1. Add route check in App.tsx (e.g., `currentPath === '/new-route'`)
2. Create corresponding component
3. Use custom event dispatch for navigation: `window.dispatchEvent(new CustomEvent('navigate', { detail: '/new-route' }))`
4. Never use standard `<a>` tags without preventDefault and custom event dispatch

### Direct URL Access Support

The app supports direct URL access to routes (e.g., `/privacy-policy`) through:

1. **Development/Preview**: `historyApiFallback: true` in vite.config.ts ensures all routes return index.html
2. **Production (Static Hosting)**: `public/404.html` redirects to index.html with path preserved
   - Works with GitHub Pages and other static hosts
   - Path is encoded in query string and decoded by script in index.html
3. **index.html**: Contains redirect handling script that restores original URL from query parameters
