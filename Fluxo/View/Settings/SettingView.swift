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
    
    @State
    private
    var selectedSetting: Item = .general
    
    public
    var body: some View {
        
        NavigationSplitView {
            
            self.sidebar()
        } detail: {
            
            self.detailView()
        }
        .navigationSplitViewStyle(.prominentDetail)
    }
}

private
extension SettingView
{
    func sidebar() -> some View
    {
        List(Item.allCases, id: \.self, selection: self.$selectedSetting) {
            
            item in
            
            Label(item.title, systemImage: item.icon)
                .tag(item)
        }
        .listStyle(.sidebar)
        .toolbar(removing: .sidebarToggle)
        .navigationTitle("Settings")
        .frame(minWidth: 180)
    }
    
    @ViewBuilder
    func detailView() -> some View
    {
        switch self.selectedSetting {
            
            case .general:
                GeneralSettingView()
                    .environmentObject(self.store)
                    .padding(.allEdge(10.0))
                
            case .customResponses:
                ResponseSettingView()
                    .environmentObject(self.store)
                    .padding(.allEdge(10.0))
        }
    }
}

// MARK: SettingView.Item

private
extension SettingView
{
    enum Item: Hashable, CaseIterable
    {
        case general
        case customResponses
        
        var title: LocalizedStringKey
        {
            switch self {
                
                case .general:
                    return "General"
                
                case .customResponses:
                    return "Custom Responses"
            }
        }
        
        var icon: String
        {
            switch self {
                
                case .general:
                    return "gear"
                
                case .customResponses:
                    return "list.bullet"
            }
        }
    }
}

#Preview {
    
    SettingView()
        .environmentObject(kMonitorStore)
        .frame(width: 700, height: 400)
}
