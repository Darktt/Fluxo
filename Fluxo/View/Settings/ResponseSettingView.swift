//
//  ResponseSetting.swift
//  Fluxo
//
//  Created by Eden on 2025/10/23.
//

import SwiftUI

public
struct ResponseSettingView: View
{
    @EnvironmentObject
    private
    var store: MonitorStore
    
    private
    var state: MonitorState {
        
        self.store.state
    }
    
    private
    lazy var requestItems: Array<RequestItem> = {
        
        self.state.setting.requestItems
    }()
    
    public
    var body: some View {
        
        LazyVStack {
            
            
        }
    }
}

#Preview {
    ResponseSettingView()
}
