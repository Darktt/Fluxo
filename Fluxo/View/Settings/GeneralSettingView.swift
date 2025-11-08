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
    @EnvironmentObject
    private
    var store: MonitorStore
    
    private
    var state: MonitorState {
        
        self.store.state
    }
    
    private
    var port: Binding<UInt16> {
        
        Binding {
            
            self.state.setting.port
        } set: {
            
            new in
            
            let action = MonitorAction.updatePort(new)
            self.store.dispatch(action)
        }

    }
    
    public
    var body: some View {
        
        Form {
            
            Section {
                
                Spacer(minLength: 20.0)
                
                TextField("Monitor Port:",
                          value: self.port,
                          format: .number.grouping(.never),
                          prompt: Text("Default: 3000")
                )
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
