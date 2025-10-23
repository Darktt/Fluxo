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
    public
    var body: some View {
        
        ZStack {
            
            Color(NSColor.windowBackgroundColor)
                .ignoresSafeArea()
            
            if #available(macOS 15.0, *) {
                
                self.tabViewAfter15()
            } else {
                
                self.tabView()
            }
        }
        .scenePadding()
        .edgesIgnoringSafeArea(.top)
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
            }
            
            Tab("Custom Responses Content", systemImage: "list.bullet") {
                
                ResponseSettingView()
            }
        }
    }
    
    func tabView() -> some View
    {
        TabView {
            
            GeneralSettingView()
                .tabItem {
                    Label("General", systemImage: "gear")
                }
            
            ResponseSettingView()
                .tabItem {
                    Label("Custom Responses Content", systemImage: "list.bullet")
                }
        }
    }
}

#Preview {
    SettingView()
}
