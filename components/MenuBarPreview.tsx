import React from 'react';

const MenuBarPreview: React.FC = () => {
  return (
    <div className="relative mx-auto max-w-5xl mt-16 mb-20 animate-fade-in-up">
      {/* Decorative Glow */}
      <div className="absolute -inset-1 bg-gradient-to-b from-red-900/20 to-transparent rounded-2xl blur-xl opacity-30"></div>
      
      {/* Main Window Container */}
      <div className="relative bg-[#18181a] border border-white/10 rounded-xl shadow-2xl overflow-hidden flex flex-col h-[600px] font-sans text-sm">
        
        {/* Window Title Bar */}
        <div className="h-12 bg-[#202022] flex items-center justify-between px-4 border-b border-white/5 shrink-0">
           <div className="flex items-center gap-4">
              {/* Traffic Lights */}
              <div className="flex gap-2">
                <div className="w-3 h-3 rounded-full bg-[#ff5f56]"></div>
                <div className="w-3 h-3 rounded-full bg-[#ffbd2e]"></div>
                <div className="w-3 h-3 rounded-full bg-[#27c93f]"></div>
              </div>
              <span className="text-white/90 font-medium ml-2">服務運作中...</span>
           </div>
           
           <div className="flex items-center gap-3">
               <button className="flex items-center gap-2 px-3 py-1.5 rounded border border-white/10 text-gray-300 hover:bg-white/5 transition-colors text-xs">
                  <svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><polyline points="3 6 5 6 21 6"></polyline><path d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"></path></svg>
                  清除
               </button>
               <button className="flex items-center gap-2 px-3 py-1.5 rounded border border-white/10 text-gray-300 hover:bg-white/5 transition-colors text-xs">
                  <div className="w-3 h-3 bg-gray-400 rounded-[1px]"></div>
                  停止
               </button>
           </div>
        </div>

        {/* Main Content Area */}
        <div className="flex flex-1 overflow-hidden">
            
            {/* Sidebar: Request List */}
            <div className="w-1/3 border-r border-white/5 bg-[#18181a] flex flex-col">
               {/* Active Item */}
               <div className="p-3 border-b border-white/5 bg-[#2a1e1e] border-l-[3px] border-l-red-500 cursor-pointer">
                  <div className="flex justify-between items-center mb-1">
                     <span className="text-white font-mono truncate">http://localhost:8080</span>
                     <span className="text-xs text-gray-400 font-mono">POST</span>
                  </div>
               </div>
               
               {/* Inactive Items */}
               <div className="p-3 border-b border-white/5 hover:bg-white/5 cursor-pointer opacity-60">
                  <div className="flex justify-between items-center mb-1">
                     <span className="text-white font-mono truncate">http://localhost:8080</span>
                     <span className="text-xs text-gray-400 font-mono">POST</span>
                  </div>
               </div>
               <div className="p-3 border-b border-white/5 hover:bg-white/5 cursor-pointer opacity-60">
                  <div className="flex justify-between items-center mb-1">
                     <span className="text-white font-mono truncate">http://localhost:8080</span>
                     <span className="text-xs text-gray-400 font-mono">POST</span>
                  </div>
               </div>
            </div>

            {/* Right Panel: Details */}
            <div className="w-2/3 bg-[#1c1c1e] flex flex-col overflow-y-auto">
                <div className="p-6 space-y-8">
                    
                    {/* Request Headers Section */}
                    <div>
                        <h4 className="text-white font-bold mb-4 text-base">Request Headers</h4>
                        <div className="space-y-2 font-mono text-xs">
                           <div className="grid grid-cols-[140px_1fr] gap-4 border-b border-white/5 pb-2">
                              <span className="text-gray-400">Accept</span>
                              <span className="text-gray-200">*/*</span>
                           </div>
                           <div className="grid grid-cols-[140px_1fr] gap-4 border-b border-white/5 pb-2">
                              <span className="text-gray-400">Accept-Encoding</span>
                              <span className="text-gray-200">gzip, br, deflate</span>
                           </div>
                           <div className="grid grid-cols-[140px_1fr] gap-4 border-b border-white/5 pb-2">
                              <span className="text-gray-400">Content-Length</span>
                              <span className="text-gray-200">3895950</span>
                           </div>
                           <div className="grid grid-cols-[140px_1fr] gap-4 border-b border-white/5 pb-2">
                              <span className="text-gray-400">Content-Type</span>
                              <span className="text-gray-200 break-all">multipart/form-data; boundary=79d52d378f2295c5-a1b97db5cfdba56a-c9a508873b9d5b10-859541e6b083310e</span>
                           </div>
                           <div className="grid grid-cols-[140px_1fr] gap-4 border-b border-white/5 pb-2">
                              <span className="text-gray-400">Host</span>
                              <span className="text-gray-200">localhost:8080</span>
                           </div>
                           <div className="grid grid-cols-[140px_1fr] gap-4 border-b border-white/5 pb-2">
                              <span className="text-gray-400">User-Agent</span>
                              <span className="text-gray-200">Fluxo-Agent</span>
                           </div>
                        </div>
                    </div>

                    {/* Body Section */}
                    <div>
                        <h4 className="text-white font-bold mb-4 text-base">Body</h4>
                        <div className="space-y-4 font-mono text-xs">
                           <div className="grid grid-cols-[100px_1fr] gap-4">
                              <span className="text-gray-400 pt-1">Header</span>
                              <div className="text-gray-400">
                                 Content-Disposition: form-data; name="image"; filename="桌布1.jpeg"<br/>
                                 Content-Type: image/jpeg
                              </div>
                           </div>
                           <div className="grid grid-cols-[100px_1fr] gap-4 items-center">
                              <span className="text-gray-400">Content</span>
                              <div>
                                 <button className="flex items-center gap-2 px-3 py-1.5 bg-[#333] hover:bg-[#444] rounded text-white transition-colors">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"></path><polyline points="7 10 12 15 17 10"></polyline><line x1="12" y1="15" x2="12" y2="3"></line></svg>
                                    保存檔案
                                 </button>
                              </div>
                           </div>
                           
                           {/* Separator Line similar to screenshot */}
                           <div className="h-px bg-white/10 w-full mt-4"></div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
        
        {/* Bottom Status Bar */}
        <div className="h-8 bg-[#202022] border-t border-white/5 flex items-center px-4 text-xs text-gray-500 font-mono">
           <svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" className="mr-2"><circle cx="12" cy="12" r="10"></circle><line x1="2" y1="12" x2="22" y2="12"></line><path d="M12 2a15.3 15.3 0 0 1 4 10 15.3 15.3 0 0 1-4 10 15.3 15.3 0 0 1-4-10 15.3 15.3 0 0 1 4-10z"></path></svg>
           網址 : http://localhost:8080, http://172.28.20.130:8080
        </div>

      </div>
    </div>
  );
};

export default MenuBarPreview;