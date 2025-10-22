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
    var port: UInt16 = Setting().port
    
    public
    var body: some View {
        
        ZStack {
            
            Color(NSColor.windowBackgroundColor)
                .ignoresSafeArea()
            
            Form {
                
                Section {
                    
                    TextField("Monitor Port:", value: self.$port, format: .number, prompt: Text("Default: 3000"))
                        .onChange(of: self.port) {
                            
                            _, new in
                            
                            var setting = Setting()
                            setting.port = new
                        }
                        .textFieldStyle(.roundedBorder)
                        .disableAutocorrection(true)
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
