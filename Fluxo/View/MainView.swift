//
//  MainView.swift
//  Fluxo
//
//  Created by Eden on 2025/8/19.
//

import SwiftUI

public
struct MainView: View
{
    @EnvironmentObject
    private
    var store: MonitorStore
    
    private
    var state: MonitorState {
        
        self.store.state
    }
    
    @AppStorage("selectedSetting")
    private
    var settingTab: SettingView.Item = .general
    
    @Environment(\.openSettings)
    private var openSettings
    
    @State
    private
    var isShowingErrorAlert: Bool = false
    
    public
    var body: some View {
        
        ZStack {
            // 背景色，支援 Light/Dark Mode
            Color(NSColor.windowBackgroundColor)
                .ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 0.0) {
                
                self.functionBar()
                
                self.bottomView()
                
                if self.state.httpStatus == .runing {
                    
                    StatusBar(self.ipAddress())
                        .background(.ultraThinMaterial)
                        .transition(.move(edge: .bottom))
                }
            }
        }
        .alert("Error", isPresented: self.$isShowingErrorAlert) {
            
            Button("OK", role: .cancel) {
                
                self.handleErrorAction()
            }
            
            if let error = self.state.error,
                error.code == MonitorErrorCode.portAlreadyUsed.rawValue {
                
                Button("Open Settings") {
                    
                    self.handleErrorAction() {
                        
                        self.settingTab = .general
                        self.openSettings()
                    }
                }
            }
        } message: {
            
            if let message = self.state.error?.message {
                
                Text(LocalizedStringKey(message))
            } else {
                
                Text("An unknown error occurred.")
            }
        }
        .onChange(of: self.state.error != nil) {
            
            _, newValue in
            
            self.isShowingErrorAlert = newValue
        }
        .edgesIgnoringSafeArea(.top)
        .animation(.easeInOut(duration: 0.3), value: self.state.httpStatus)
    }
}

// MARK: - Private Methods -

private
extension MainView
{
    func functionBar() -> some View {
        
        FunctionBar(state: self.state) {
            
            action in
            
            self.store.dispatch(action)
        }
    }
    
    func bottomView() -> some View {
        
        GeometryReader {
            
            geometry in
            
            HStack(alignment: .top, spacing: 0.0) {
                
                let selectedRequest: Request? = self.state.selectedRequest
                
                // Sidebar（RequestListView）
                RequestListView(requests: self.state.requests, selected: selectedRequest)
                    .onSelected {
                        
                        request in
                        
                        let action = MonitorAction.selectRequest(request)
                        
                        self.store.dispatch(action)
                    }
                    .frame(width: geometry.size.width * 0.3)
                
                // 分隔線
                Rectangle()
                    .fill(Color.secondary.opacity(0.15))
                    .frame(width: 1.0)
                    .padding(.vertical, 8.0)
                
                // Content（DetailView）
                DetailView(request: selectedRequest)
                    .clipShape(RoundedRectangle(cornerRadius: 8.0, style: .continuous))
                    .padding([.leading, .bottom], 5.0)
                    .padding(.trailing, 7.0)
                    .frame(width: geometry.size.width * 0.7)
            }
        }
        .padding(.top, 4)
    }
    
    func ipAddress() -> String {
        
        let portNumber: String = "\(self.state.setting.port)"
        let ipAddress: String = self.state.ipAddress.map {
            
            ipAddress in
            
            ", http://\(ipAddress):\(portNumber)"
        } ?? ""
        
        return "http://localhost:\(portNumber)" + ipAddress
    }
    
    func handleErrorAction(otherAction: (() -> Void)? = nil)
    {
        self.isShowingErrorAlert = false
        let action = MonitorAction.stopMonitor
        
        self.store.dispatch(action)
        otherAction?()
    }
}

#Preview {
    
    MainView()
        .environmentObject(kMonitorStore)
}
