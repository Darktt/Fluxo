import React from 'react';
import { ICONS } from '../constants';
import { FeatureItem } from '../types';

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

const Features: React.FC = () => {
  return (
    <section id="features" className="py-24 bg-black relative">
       {/* Background Gradient blob */}
       <div className="absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 w-[500px] h-[500px] bg-blue-900/20 rounded-full blur-[100px] pointer-events-none"></div>

      <div className="max-w-6xl mx-auto px-6 relative z-10">
        <div className="text-center mb-16">
          <h2 className="text-3xl md:text-4xl font-bold mb-4 text-white">為什麼選擇 Fluxo？</h2>
          <p className="text-gray-400 max-w-2xl mx-auto">
            拋棄繁雜的儀表板，回歸最純粹的數據呈現。Fluxo 專注於提供最核心的資訊，不打擾您的工作流程。
          </p>
        </div>

        <div className="grid md:grid-cols-3 gap-8">
          {features.map((feature, index) => (
            <div key={index} className="group p-8 rounded-3xl bg-[#121212] border border-white/5 hover:border-white/10 hover:bg-[#1a1a1a] transition-all duration-300">
              <div className="w-12 h-12 rounded-2xl bg-blue-500/10 flex items-center justify-center text-blue-500 mb-6 group-hover:scale-110 transition-transform duration-300">
                {feature.icon}
              </div>
              <h3 className="text-xl font-semibold text-white mb-3">{feature.title}</h3>
              <p className="text-gray-400 leading-relaxed">{feature.description}</p>
            </div>
          ))}
        </div>
      </div>
    </section>
  );
};

export default Features;