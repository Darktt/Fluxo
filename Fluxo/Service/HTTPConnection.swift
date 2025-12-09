//
//  HTTPConnection.swift
//  Fluxo
//
//  Created by Eden on 2021/9/8.
//

import Foundation
import Network
import SwiftExtensions

public
class HTTPConnection
{
    public
    let MTU: Int = ServiceConfig.mtu
    
    public
    let identifier: String = UUID().uuidString
    
    public
    let connection: NWConnection
    
    public
    var receiveRequestHandler: HTTPService.ReceiveRequestHandler?
    
    public
    var errorHandler: HTTPService.ErrorHandler?
    
    // MARK: - Methods -
    // MARK: Initial Method
    
    public
    init(_ connection: NWConnection)
    {
        self.connection = connection
    }
    
    public
    func start(queue: DispatchQueue = .main)
    {
        print("Starting connect the connection...")
        
        self.connection.stateUpdateHandler = self.connectionStateChange
        
        self.handleReceive()
        self.connection.start(queue: queue)
    }
    
    public
    func cancel()
    {
        print("Canceling connect the connection...")
        
        self.connection.stateUpdateHandler = nil
        self.connection.pathUpdateHandler = nil
        self.connection.cancel()
    }
}

private
extension HTTPConnection
{
    func connectionStateChange(to state: NWConnection.State)
    {
        switch state {
                
            case .setup:
                print("ℹ️ Connection: \(self.connection) in setup.")
                
            case .waiting(let error):
                print("ℹ️ Connection: \(self.connection) is waiting with error: \(error)")
                
            case .preparing:
                print("ℹ️ Connection: \(self.connection) is preparing.")
                
            case .ready:
                print("ℹ️ Connection: \(self.connection) is ready.")
                
            case .failed(let error):
                print("ℹ️ Connection: \(self.connection), failed to start with error: \(error)")
                
            case .cancelled:
                print("ℹ️ Connection: \(self.connection) is canceled.")
                
            @unknown
            default:
                fatalError()
        }
    }
    
    func handleReceive(_ request: HTTPMessage? = nil)
    {
        let request = request ?? HTTPMessage()
        
        let completion: @Sendable (Data?, NWConnection.ContentContext?, Bool, NWError?)  -> Void = {
            
            [weak self] data, _, isComplete, error in
            
            guard let self = self else {
                
                return
            }
            
            // 處理錯誤和連接狀態
            if let error: NWError = error {
                print("❌ Receive error: \(error)")
                
                // 如果是連接重置錯誤，不要嘗試繼續接收
                
                if error.errorCode == 54 {
                    
                    // ECONNRESET
                    print("ℹ️ Connection reset by peer, closing connection")
                    self.cancel()
                    return
                }
                
                self.errorHandler.unwrapped({ $0(error) })
                return
            }
            
            // 處理接收到的數據
            if let data = data, !data.isEmpty {
                
                if let string = String(data: data, encoding: .utf8) {
                    
                    print("ℹ️ Request data: \(string)")
                }
                
                request.appendData(data)
                
                if !self.isValidHTTPRequest(request) {
                    
                    print("❗️ Failed to parse HTTP message from data")
                    
                    let errorResponse = self.badRequestResponse()
                    
                    self.sendResponse(errorResponse) {
                        
                        self.cancel()
                    }
                    return
                }
                
                print("⬅️ Received data: \(data.count) bytes")
                print("➡️ Current size: \(request.currentSize) bytes")
                print("ℹ️ Request content size: \(request.contentSize)")
                print("------------------")
            }
            
            let isComplete: Bool = isComplete || request.isComplete
            
            // 如果連接完成，關閉連接
            if isComplete {
                
                self.receiveRequestHandler.unwrapped({ $0(request) })
                
                Task {
                    let response = await self.makeResponse(fromRequest: request)
                    await self.sendResponse(response)
                    
                    print("ℹ️ Connection completed, closing")
                    self.cancel()
                }
                
                return
            }
            
            self.handleReceive(request)
        }
        
        self.connection.receive(minimumIncompleteLength: 1, maximumLength: self.MTU, completion: completion)
    }
    
    func isValidHTTPRequest(_ request: HTTPMessage) -> Bool
    {
        let isValid: Bool = (request.requestMethod != nil)
        
        return isValid
    }
    
    func makeResponse(fromRequest request: HTTPMessage) async -> HTTPMessage
    {
        let responseItem = await self.responseItem(for: request)
        let response = HTTPMessage.response(statusCode: .ok, htmlString: responseItem.content)
        
        return response
    }
    
    func responseItem(for request: HTTPMessage) async -> ResponseItem
    {
        var pathComponents: Array<String> = request.requestURL?.pathComponents ?? []
        pathComponents.removeAll(where: { $0 == "/" })
        let path: String = pathComponents.joined(separator: "/")
        
        guard let method = request.requestMethod else {
            
            return ResponseItem.badRequest()
        }
        
        let mainActorBody: @MainActor () -> ResponseItem? = {
            
            kMonitorStore.state.setting.item(with: path, method: method)
        }
        
        if let item = await MainActor.run(body: mainActorBody) {
            
            return item
        }
        
        return ResponseItem.defaultItem(with: method)
    }
    
    func badRequestResponse() -> HTTPMessage
    {
        let requestItem = ResponseItem.badRequest()
        let response = HTTPMessage.response(statusCode: .badRequest, htmlString: requestItem.content)
        
        return response
    }
    
    func sendResponse(_ response: HTTPMessage) async
    {
        await withCheckedContinuation {
            
            continuation in
            
            let completion = {
                
                continuation.resume()
            }
            
            self.sendResponse(response, completion: completion)
        }
    }
    
    func sendResponse(_ response: HTTPMessage, completion: @escaping () -> Void)
    {
        guard let data: Data = response.data else {
            
            return
        }
        
        self.send(data, completion: completion)
    }
    
    func send(_ data: Data, completion: @escaping () -> Void)
    {
        let completion: NWConnection.SendCompletion = .contentProcessed {
            
            [unowned self] error in
            
            if let error: NWError = error {
                
                print("ℹ️ Connection: \(self.connection), content processed with error: \(error)")
                
                self.errorHandler.unwrapped({ $0(error) })
            }
            
            print("ℹ️ Response sent successfully")
            
            completion()
        }
        
        self.connection.send(content: data, contentContext: .finalMessage, completion: completion)
    }
}
