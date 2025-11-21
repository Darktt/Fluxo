import React, { useState, useEffect } from 'react';
import { LINKS, ICONS } from '../constants';

const Header: React.FC = () => {
  const [scrolled, setScrolled] = useState(false);

  useEffect(() => {
    const handleScroll = () => {
      setScrolled(window.scrollY > 20);
    };
    window.addEventListener('scroll', handleScroll);
    return () => window.removeEventListener('scroll', handleScroll);
  }, []);

  const handleHomeClick = (e: React.MouseEvent) => {
    e.preventDefault();
    // Dispatch custom event to notify App.tsx safely
    const event = new CustomEvent('navigate', { detail: '/' });
    window.dispatchEvent(event);
  };

  return (
    <header className={`fixed top-0 left-0 right-0 z-50 transition-all duration-300 border-b ${scrolled ? 'bg-black/70 backdrop-blur-xl border-white/10 py-4' : 'bg-transparent border-transparent py-6'}`}>
      <div className="max-w-6xl mx-auto px-6 flex items-center justify-between">
        <a href="/" onClick={handleHomeClick} className="flex items-center gap-2 text-white font-bold text-xl tracking-tight hover:opacity-80 transition-opacity">
          <div className="text-blue-500">
            {ICONS.Activity}
          </div>
          <span>Fluxo</span>
        </a>

        <nav className="flex items-center gap-8">
          <a href={LINKS.GITHUB} target="_blank" rel="noopener noreferrer" className="text-sm font-medium text-gray-300 hover:text-white transition-colors">GitHub</a>
        </nav>
      </div>
    </header>
  );
};

export default Header;