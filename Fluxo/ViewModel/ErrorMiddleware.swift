//
//  ErrorMiddleware.swift
//  Fluxo
//
//  Created by Eden on 2025/12/5.
//

import Foundation
import Network

public
let ErrorMiddleware: Middleware<MonitorState, MonitorAction> = {
    
    store in
    
    {
        next in
        
        {
            action in
            
            if case let .updateStatus(status) = action {
                
                if case let .waitting(error) = status {
                    
                    let error = parseNetworkError(error: error)
                    let newAction = MonitorAction.error(error)
                    
                    next(action)
                    next(newAction)
                    return
                }
                
                if case let .failed(error) = status {
                    
                    let error = parseNetworkError(error: error)
                    let newAction = MonitorAction.error(error)
                    
                    next(action)
                    next(newAction)
                    return
                }
            }
            
            next(action)
        }
    }
}


func parseNetworkError(error: NWError) -> MonitorError
{
    let newError: MonitorError
    
    switch error
    {
        case let .posix(errorCode):
            let message: String = {
                if errorCode == .EADDRINUSE {
                    
                    return "Port already used, click \"Open Settings\" button to change another port."
                } else {
                    
                    return "POSIX Error: \(errorCode), description: \(error.localizedDescription)"
                }
            }()
            newError = (Int(errorCode.rawValue), message)
            
        case let .dns(errorCode):
            newError = (Int(errorCode), "DNS Error: \(errorCode), description: \(error.localizedDescription)")
            
        case let .tls(errorCode):
            newError = (Int(errorCode), "TLS Error: \(errorCode), description: \(error.localizedDescription)")
            
        case let .wifiAware(errorCode):
            newError = (Int(errorCode), "WiFi Aware Error: \(errorCode), description: \(error.localizedDescription)")
            
        @unknown default:
            fatalError()
    }
    
    return newError
}
