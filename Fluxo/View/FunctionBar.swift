//
//  FunctionBar.swift
//  Fluxo
//
//  Created by Eden on 2025/8/20.
//

import SwiftUI

public
struct FunctionBar: View
{
    public
    var state: MonitorState
    
    public
    var actionHandler: (MonitorAction) -> Void
    
    public
    var body: some View {
        
        ZStack(alignment: .top) {
            
            VStack(alignment: .leading, spacing: 0.0) {
                
                HStack(spacing: 0.0) {
                    
                    Text(self.state.status)
                        .bold()
                        .foregroundColor(.primary)
                    
                    Spacer()
                    
                    self.buttons()
                }
                .padding(.allEdge(10.0))
                
                Divider()
            }
            .padding(.top, 22.0)
        }
    }
}

// MARK: - Private Methods -

private
extension FunctionBar
{
    func buttons() -> some View
    {
        HStack(spacing: 12.0) {
            
            if !self.state.requests.isEmpty {
                
                FunctionBarButton(icon: "trash", label: "Clean") {
                    
                    let action: MonitorAction = .cleanRequests
                    
                    self.actionHandler(action)
                }
            }
            
            self.startStopButton()
        }
    }
    
    func startStopButton() -> some View
    {
        if self.state.httpStatus != .suspend {
            
            // Stop Monitor Button
            FunctionBarButton(icon: "stop.fill", label: "Stop") {
                
                let action: MonitorAction = .stopMonitor
                
                self.actionHandler(action)
            }
        } else {
            
            // Start Monitor Button
            FunctionBarButton(icon: "play.fill", label: "Start") {
                
                let action: MonitorAction = .startMonitor
                
                self.actionHandler(action)
            }
        }
    }
}

private
struct FunctionBarButton: View
{
    let icon: String
    
    let label: LocalizedStringKey
    
    let action: () -> Void
    
    @State
    private
    var isHover = false
    
    var body: some View {
        
        Button(action: self.action) {
            
            HStack(spacing: 6.0) {
                
                Image(systemName: self.icon)
                    .font(.system(size: 15.0, weight: .semibold))
                
                Text(self.label)
                    .font(.system(size: 14.0, weight: .medium))
            }
            .padding(.vertical, 6.0)
            .padding(.horizontal, 14.0)
            .contentShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
        }
        .buttonStyle(.plain)
        .background(self.backgroundMaterial)
        .overlay(self.overlayStroke)
        .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
        .shadow(color: self.isHover ? Color.black.opacity(0.08) : .clear, radius: 6.0, x: 0.0, y: 2.0)
        .onHover {
            
            hover in
            
            self.isHover = hover
        }
        .animation(.easeInOut(duration: 0.18), value: self.isHover)
    }
    
    // MARK: - Glass Layers -
    
    private
    var backgroundMaterial: some View
    {
        // 基礎玻璃材質：可視需求換 .thinMaterial / .regularMaterial
        let base: AnyShapeStyle = AnyShapeStyle(.ultraThinMaterial)
        let view = RoundedRectangle(cornerRadius: 10.0, style: .continuous)
                    .fill(base)
                    .overlay {
                        
                        RoundedRectangle(cornerRadius: 10.0, style: .continuous)
                            .fill(self.isHover ? Color.white.opacity(0.05) : .clear)
                    }
        
        return view
    }
    
    private
    var overlayStroke: some View
    {
        // 亮邊 + 暗邊 疊加，營造玻璃邊緣質感
        RoundedRectangle(cornerRadius: 10.0, style: .continuous)
            .strokeBorder(
                LinearGradient(
                    colors: [
                        .white.opacity(0.55),
                        .white.opacity(0.18)
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                ),
                lineWidth: 0.7
            )
            .overlay {
                
                RoundedRectangle(cornerRadius: 10.0, style: .continuous)
                    .strokeBorder(Color.black.opacity(0.12), lineWidth: 0.5)
                    .blendMode(.multiply)
            }
    }
}
