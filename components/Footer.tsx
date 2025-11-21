import React from 'react';
import { LINKS } from '../constants';

const Footer: React.FC = () => {
  // Handle click to navigate using custom event system
  const handlePrivacyClick = (e: React.MouseEvent) => {
    e.preventDefault();
    const event = new CustomEvent('navigate', { detail: '/privacy-policy' });
    window.dispatchEvent(event);
  };

  return (
    <footer className="py-12 border-t border-white/10 bg-black">
      <div className="max-w-6xl mx-auto px-6 flex flex-col md:flex-row justify-between items-center gap-6">
        <div className="text-gray-500 text-sm">
          © {new Date().getFullYear()} Fluxo Network Monitor. Open Source.
        </div>
        
        <div className="flex gap-6">
          <a 
            href="/privacy-policy" 
            onClick={handlePrivacyClick}
            className="text-gray-500 hover:text-white transition-colors text-sm"
          >
            Privacy Policy
          </a>
          <a href={LINKS.GITHUB} target="_blank" rel="noopener noreferrer" className="text-gray-500 hover:text-white transition-colors text-sm">
            GitHub
          </a>
          <a href={LINKS.APP_STORE} target="_blank" rel="noopener noreferrer" className="text-gray-500 hover:text-white transition-colors text-sm">
            App Store
          </a>
          <a href={LINKS.GITHUB + "/issues"} target="_blank" rel="noopener noreferrer" className="text-gray-500 hover:text-white transition-colors text-sm">
            Report Issue
          </a>
        </div>
      </div>
    </footer>
  );
};

export default Footer;