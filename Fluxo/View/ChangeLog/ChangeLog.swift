//
//  ChangeLog.swift
//  Fluxo
//
//  Created by Eden on 2025/12/24.
//

import SwiftUI
import MarkdownView

public
struct ChangeLog: View
{
    @EnvironmentObject
    private
    var store: MonitorStore
    
    private
    var state: MonitorState {
        
        self.store.state
    }
    
    public
    var log: String {
        
        self.state.changeLog ?? "# Empty Log"
    }
    
    public
    var body: some View {
        
        LazyVStack {
            
            MarkdownView(self.log)
        }
        .padding([.horizontal], 10.0)
        .onAppear(perform: self.isWatched)
    }
}

// MARK: - Private Methods -

private
extension ChangeLog
{
    func isWatched()
    {
        let version = self.state.setting.version
        let action = MonitorAction.setWatchedVersion(version)
        
        self.store.dispatch(action)
    }
}

#Preview {
    
    ChangeLog()
}
