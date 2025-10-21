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
    @State
    var port: String = "3000"
    
    public
    var body: some View {
        
        ZStack {
            
            Color(NSColor.windowBackgroundColor)
                .ignoresSafeArea()
            
            Form {
                
                Section {
                    
                    TextField(text: self.$port, prompt: nil) {
                        
                        Text("Monitor Port:")
                    }
                    .textFieldStyle(.roundedBorder)
                    .frame(width: 100)
                }
                
                Section("Custom response") {
                    
                    TextEditor(text: .constant("// TODO: Add custom response script here"))
                        .frame(height: 200)
                        .font(.system(.body, design: .monospaced))
                }
            }
            .formStyle(.grouped)
            
        }.edgesIgnoringSafeArea(.top)
        .scenePadding()
        .frame(maxWidth: 350, minHeight: 100)
    }
}

#Preview {
    SettingView()
}
