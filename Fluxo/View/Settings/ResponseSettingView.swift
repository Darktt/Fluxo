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
    
    @State
    private
    var willDeleteItem: ResponseItem?
    
    private
    var isPresentAlert: Binding<Bool> {
        
        Binding {
            
            self.willDeleteItem != nil
        } set: {
            
            isPresented in
            
            if !isPresented {
                self.willDeleteItem = nil
            }
        }
    }
    
    public
    var body: some View {
        
        NavigationStack(path: self.$path) {
            
            VStack {
                
                ResponseItemCell.Title()
                
                self.responseItemListView()
                
                self.addButton()
            }
            .padding(.bottom, 2.0)
            .navigationDestination(for: ResponseItem.self) {
                
                item in
                
                ResponseItemEditView(responseItem: item, navigationPath: self.$path)
                    .environmentObject(self.store)
            }
            .navigationTitle("Custom Responses")
        }
        .alert("Delete item", isPresented: self.isPresentAlert) {
            
            Button(role: .destructive) {
            
                self.sendDeleteAction(with: self.willDeleteItem!)
                self.willDeleteItem = nil
            } label: {
                
                Text("Delete")
            }
        } message: {
            
            Text("Ensure delete this item?")
        }

    }
}

// MARK: - Extent View -

extension ResponseSettingView
{
    func responseItemListView() -> some View
    {
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
    }
    
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
        self.willDeleteItem = item
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

private
extension ResponseSettingView
{
    func sendDeleteAction(with item: ResponseItem)
    {
        let action = MonitorAction.deleteResponseItem(item)
        
        self.store.dispatch(action)
    }
}

#Preview {
    
    ResponseSettingView()
        .environmentObject(kMonitorStore)
        .frame(width: 400, height: 300)
}
