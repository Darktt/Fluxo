//
//  MonitorMiddleware.swift
//
//  Created by Eden on 2025/8/19.
//

import Foundation
import Network

@MainActor
public
let MonitorMiddleware: Middleware<MonitorState, MonitorAction> = {
    
    store in
    
    {
        next in
        
        {
            action in
            
            if case .startMonitor = action {
                
                let port: UInt16 = store.state.setting.port
                let newAction = startMonitorAction(portNumber: port, store: store)
                
                next(newAction)
                return
            }
            
            if case .stopMonitor = action {
                
                store.state.httpService?.cancel()
                let newAction = MonitorAction.stopMonitorResponse
                
                next(newAction)
                return
            }
            
            next(action)
        }
    }
}

private
func startMonitorAction(portNumber: UInt16, store: MonitorStore) -> MonitorAction
{
    do {
        
        let port = NWEndpoint.Port(integerLiteral: portNumber)
        let service = try HTTPService(port: port)
        service.statusUpdateHandler = makeStatusUpdateHandler(store: store)
        service.receiveRequestHandler = makeReceiveRequestHandler(store: store)
        service.errorHandler = makeErrorHandler(store: store)
        service.start()
        
        let action = MonitorAction.startMonitorResponse(service)
        
        return action
    } catch {
        
        let nsError = error as NSError
        let error: MonitorError = (nsError.code, nsError.localizedDescription)
        
        let action = MonitorAction.error(error)
        
        return action
    }
}

private
func makeStatusUpdateHandler(store: MonitorStore) -> HTTPService.StatusUpdateHandler
{
    {
        status in
        
        Task {
            @MainActor in
            
            let action = MonitorAction.updateStatus(status)
            
            store.dispatch(action)
        }
    }
}

private
func makeReceiveRequestHandler(store: MonitorStore) -> HTTPService.ReceiveRequestHandler
{
    {
        request in
        
        Task {
            @MainActor in
            
            let action = MonitorAction.receiveRequest(request)
            
            store.dispatch(action)
        }
    }
}

private
func makeErrorHandler(store: MonitorStore) -> HTTPService.ErrorHandler
{
    {
        error in
        
        Task {
            @MainActor in
            
            let error: MonitorError = (error.errorCode, error.localizedDescription)
            let action = MonitorAction.error(error)
            
            store.dispatch(action)
        }
    }
}
