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
    var requestItems: Array<ResponseItem> {
        
        self.state.setting.requestItems
    }
    
    @State
    private
    var path = NavigationPath()
    
    private
    let limitCount: Int = 20
    
    public
    var body: some View {
        
        NavigationStack(path: self.$path) {
            
            VStack {
                
                ResponseItemCell.Title()
                
                ScrollView {
                    
                    LazyVStack(alignment: .leading, spacing: 0.0) {
                        
                        ForEach(self.requestItems) {
                            
                            item in
                            
                            ResponseItemCell(requestItem: item,
                                             deleteAction: self.deleteItem,
                                             editAction: self.editItem)
                        }
                        
                        if self.requestItems.count < self.limitCount {
                            
                            ForEach(0 ..< (self.limitCount - self.requestItems.count),
                                    id: \.self) {
                                
                                _ in
                                
                                ResponseItemCell(requestItem: ResponseItem.empty())
                            }
                        }
                    }
                }
                .padding(.bottom, 5.0)
                
                self.addButton()
            }
            .padding(.bottom, 2.0)
            .navigationDestination(for: ResponseItem.self) {
                
                item in
                
                ResponseItemEditView(responseItem: item, navigationPath: self.$path)
                    .environmentObject(self.store)
            }
            .navigationTitle("Custom Responses Content")
        }
    }
}

// MARK: - Extent View -

extension ResponseSettingView
{
    func addButton() -> some View {
        
        HStack {
            
            Spacer()
            
            Button {
                
                self.addItem()
            } label: {
                
                Image(systemName: "plus")
            }
            .buttonStyle(.borderless)
            .frame(width: 50.0, height: 30.0)
        }
        .background(Color.gray.opacity(0.1))
    }
}

// MARK: - Actions -

extension ResponseSettingView
{
    func deleteItem(item: ResponseItem)
    {
        let action = MonitorAction.deleteResponseItem(item)
        
        self.store.dispatch(action)
    }
    
    func editItem(item: ResponseItem)
    {
        self.path.append(item)
    }
    
    func addItem()
    {
        self.path.append(ResponseItem.empty())
    }
}

#Preview {
    
    ResponseSettingView()
        .environmentObject(kMonitorStore)
        .frame(width: 400, height: 300)
}
