//
//  ResponseItemEditView.swift
//  Fluxo
//
//  Created by Darktt on 2025/11/12.
//

import SwiftUI
import SwiftExtensions

public
struct ResponseItemEditView: View
{
    @EnvironmentObject
    private
    var store: MonitorStore
    
    public
    let responseItem: ResponseItem
    
    @Binding
    public
    var navigationPath: NavigationPath
    
    @State
    private
    var path: String
    
    @State
    private
    var method: HTTPMethod
    
    @State
    private
    var content: String
    
    private
    var isSaveButtonEnabled: Bool {
        
        !self.path.isEmpty && !self.content.isEmpty
    }
    
    private
    var title: LocalizedStringKey {
        
        guard self.responseItem.path.isEmpty else {
            
            return "Edit Response Item"
        }
        
        return "New Response Item"
    }
    
    public
    var body: some View {
        
        VStack {
            Spacer()
            
            Form {
                
                self.pathAndMethodSection()
                
                self.contentSection()
            }
            
            Spacer(minLength: 10.0)
            
            self.buttonSection()
        }
        .padding(.allEdge(10.0))
        .navigationBarBackButtonHidden()
        .navigationTitle(self.title)
    }
    
    public
    init(responseItem: ResponseItem, navigationPath: Binding<NavigationPath>)
    {
        self.responseItem = responseItem
        self._navigationPath = navigationPath
        
        self.path = responseItem.path
        self.method = responseItem.method
        self.content = responseItem.content
    }
}

extension ResponseItemEditView
{
    func pathAndMethodSection() -> some View
    {
        Section {
            
            TextField("Path: ", text: self.$path)
                .textFieldStyle(.roundedBorder)
                .disableAutocorrection(true)
                .onChange(of: self.path) {
                    
                    _, newValue in
                    
                    self.path = newValue
                }
                .disableAutocorrection(true)
            
            Picker("Method: ", selection: self.$method) {
                
                ForEach(HTTPMethod.allCases) {
                    
                    method in
                    
                    Text(method.rawValue)
                        .tag(method)
                }
            }
        }
    }
    
    func contentSection() -> some View
    {
        Section {
            
            TextEditor(text: self.$content)
        } header: {
            
            Text("Content:")
        }
        .padding(.leading, -62.0)
        .disableAutocorrection(true)
    }
    
    func buttonSection() -> some View
    {
        HStack {
            
            Button("Cancel") {
                
                self.navigationPath.removeLast()
            }
            
            Spacer()
            
            Button("Save") {
                
                let newItem = ResponseItem(method: self.method, path: self.path, content: self.content)
                
                let action = MonitorAction.addResponseItem(newItem)
                
                self.store.dispatch(action)
                self.navigationPath.removeLast()
            }
            .disabled(!self.isSaveButtonEnabled)
            .background(Color.accentColor)
            .clipShape(.rect(cornerRadius: 3.0))
        }
    }
}

#Preview {
    
    ResponseItemEditView(responseItem: ResponseItem.defaultItem(), navigationPath: .constant(NavigationPath()))
        .environmentObject(kMonitorStore)
}
