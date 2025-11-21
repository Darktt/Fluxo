import React, { useState, useEffect } from 'react';
import Header from './components/Header';
import Hero from './components/Hero';
import MenuBarPreview from './components/MenuBarPreview';
import Features from './components/Features';
import Footer from './components/Footer';
import PrivacyPolicy from './components/PrivacyPolicy';

const App: React.FC = () => {
  // Use local state to track path, defaulting to current location
  const [currentPath, setCurrentPath] = useState(window.location.pathname);

  useEffect(() => {
    // Handle browser back/forward buttons
    const handlePopState = () => {
      setCurrentPath(window.location.pathname);
    };
    
    // Handle custom navigation events from components
    const handleNavigate = (e: Event) => {
      const customEvent = e as CustomEvent<string>;
      const newPath = customEvent.detail;
      
      // 1. Update UI state immediately
      setCurrentPath(newPath);
      window.scrollTo(0, 0);
      
      // 2. Attempt to update URL (wrapped in try-catch for environments blocking pushState)
      try {
        if (window.location.pathname !== newPath) {
          window.history.pushState({}, '', newPath);
        }
      } catch (err) {
        // Silently ignore SecurityError in sandboxed environments
        console.debug('Navigation URL update suppressed in this environment.');
      }
    };
    
    window.addEventListener('popstate', handlePopState);
    window.addEventListener('navigate', handleNavigate);
    
    return () => {
      window.removeEventListener('popstate', handlePopState);
      window.removeEventListener('navigate', handleNavigate);
    };
  }, []);

  const isPrivacyPolicy = currentPath === '/privacy-policy';

  return (
    <div className="min-h-screen bg-black text-white selection:bg-blue-500 selection:text-white overflow-x-hidden font-sans">
      <Header />
      
      <main>
        {isPrivacyPolicy ? (
          <PrivacyPolicy />
        ) : (
          <>
            <Hero />
            
            {/* Preview Section ID for Navigation */}
            <div id="preview" className="px-6">
               <MenuBarPreview />
            </div>
            
            <Features />

            {/* Call to Action Strip */}
            <section className="py-20 border-t border-white/5 bg-gradient-to-b from-black to-[#0a0a0a]">
              <div className="max-w-4xl mx-auto px-6 text-center">
                 <h2 className="text-3xl font-bold mb-6">準備好提升您的 macOS 體驗了嗎？</h2>
                 <p className="text-gray-400 mb-8">立即下載，開始享受輕量級的網路監控體驗。</p>
                 <a 
                    href="https://apps.apple.com/tw/app/fluxo-network-monitor/id6753338351?mt=12"
                    target="_blank"
                    rel="noopener noreferrer"
                    className="inline-flex items-center gap-2 bg-white text-black px-8 py-3 rounded-full font-bold hover:bg-gray-200 transition-colors"
                 >
                   前往 App Store 下載
                 </a>
              </div>
            </section>
          </>
        )}
      </main>

      <Footer />
    </div>
  );
};

export default App;