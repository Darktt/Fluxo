//
//  GeneralSettingView.swift
//  Fluxo
//
//  Created by Eden on 2025/10/23.
//

import SwiftUI

public
struct GeneralSettingView: View
{
    @State
    var port: UInt16 = Setting().port
    
    public
    var body: some View {
        
        Form {
            
            Section {
                
                Spacer(minLength: 20.0)
                
                TextField("Monitor Port:",
                          value: self.$port,
                          format: .number.grouping(.never),
                          prompt: Text("Default: 3000")
                )
                .onChange(of: self.port) {
                    
                    _, new in
                    
                    var setting = Setting()
                    setting.port = new
                }
                .textFieldStyle(.roundedBorder)
                .disableAutocorrection(true)
                
                Spacer(minLength: 20.0)
            }
            .formStyle(.grouped)
        }
    }
}

#Preview {
    GeneralSettingView()
}
