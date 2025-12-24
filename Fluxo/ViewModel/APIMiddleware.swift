//
//  APIMiddleware.swift
//  Fluxo
//
//  Created by Eden on 2025/12/24.
//

import Foundation

@MainActor
public
let APIMiddleware: Middleware<MonitorState, MonitorAction> = {
    
    store in
    
    {
        next in
        
        {
            action in
            
            if case let .fetchChangeLog(request) = action {
                
                Task {
                    
                    @MainActor in
                    
                    let newAction = await fetchChangeLogAction(request)
                    
                    next(newAction)
                }
            }
            
            next(action)
        }
    }
}

@MainActor
private
func apiRequest<Request>(_ request: Request) async throws -> Request.Response where Request: APIRequest
{
    let apiHandler = APIHandler.shared
    let response: Request.Response = try await apiHandler.sendRequest(request)
    
    return response
}

@MainActor
private
func fetchChangeLogAction(_ request: ChangeLogRequest) async -> MonitorAction
{
    do {
        
        let response: String = try await apiRequest(request)
        
        let newAction = MonitorAction.fetchChangeLogResponse(response)
        
        return newAction
    } catch {
        
        let newAction = MonitorAction.fetchApiError(error)
        
        return newAction
    }
}
