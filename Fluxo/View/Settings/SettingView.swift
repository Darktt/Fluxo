//
//  SettingView.swift
//  Fluxo
//
//  Created by Eden on 2025/10/21.
//

import SwiftUI

public
struct SettingView: View
{
    @EnvironmentObject
    private
    var store: MonitorStore
    
    public
    var body: some View {
        
        ZStack {
            
            if #available(macOS 15.0, *) {
                
                self.tabViewAfter15()
            } else {
                
                self.tabView()
            }
        }
        .scenePadding()
    }
}

private
extension SettingView
{
    @available(macOS 15.0, *)
    func tabViewAfter15() -> some View
    {
        TabView {
            
            Tab("General", systemImage: "gear") {
                
                GeneralSettingView()
                    .environmentObject(self.store)
            }
            
            Tab("Custom Responses Content", systemImage: "list.bullet") {
                
                ResponseSettingView()
                    .environmentObject(self.store)
            }
        }
    }
    
    func tabView() -> some View
    {
        TabView {
            
            GeneralSettingView()
                .environmentObject(self.store)
                .tabItem {
                    Label("General", systemImage: "gear")
                }
            
            ResponseSettingView()
                .environmentObject(self.store)
                .tabItem {
                    Label("Custom Responses Content", systemImage: "list.bullet")
                }
        }
    }
}

#Preview {
    
    SettingView()
        .environmentObject(kMonitorStore)
}
