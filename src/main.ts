import { createApp } from 'vue';
import App from './App.vue';
import router from './router';

// Import CSS styles
import './styles/variables.css';
import './styles/global.css';
import './styles/layout.css';
import './styles/responsive.css';
import './styles/components/app.css';
import './styles/components/header.css';
import './styles/components/hero.css';
import './styles/components/menu-bar-preview.css';
import './styles/components/features.css';
import './styles/components/footer.css';
import './styles/components/privacy-policy.css';
import './styles/components/home.css';

const app = createApp(App);
app.use(router);
app.mount('#app');
