//
//  RequestItemExtension.swift
//
//  Created by Darktt on 2025/11/4.
//  
//

import Foundation
import SwiftExtensions

public
struct ResponseItem
{
    public
    let method: HTTPMethod
    
    public
    let path: String
    
    public
    let content: String
    
    public static
    func empty() -> ResponseItem
    {
        ResponseItem(method: .get, path: "", content: "")
    }
    
    public static
    func defaultItem(with method: HTTPMethod = .get) -> ResponseItem
    {
        let content = "<h1>Hello world!</h1><br/><p>Method: \(method.rawValue)</p>"
        let requestItem = ResponseItem(method: method, path: "/", content: content)
        
        return requestItem
    }
    
    public static
    func badRequest() -> ResponseItem
    {
        ResponseItem(method: .get, path: "/", content: "<h1>400 Bad Request</h1><p>Invalid HTTP request format</p>")
    }
}

extension ResponseItem: Hashable
{
    public
    func hash(into hasher: inout Hasher)
    {
        hasher.combine(method)
        hasher.combine(path)
    }
}

extension ResponseItem: Equatable
{
    public static
    func == (lhs: Self, rhs: Self) -> Bool
    {
        var result = (lhs.path == rhs.path)
        result &= (lhs.method == lhs.method)
        result &= (lhs.content == rhs.content)
        
        return result
    }
}

extension ResponseItem: Identifiable
{
    public
    var id: Int {
        
        "\(self.method.rawValue)-\(self.path)".hashValue
    }
}

extension ResponseItem: Codable
{
    public static
    func decode(with data: Data) throws -> ResponseItem
    {
        let jsonDecoder = JSONDecoder()
        let requestItem = try jsonDecoder.decode(ResponseItem.self, from: data)
        
        return requestItem
    }
    
    public
    func encode() throws -> Data
    {
        let jsonEncoder = JSONEncoder()
        let data = try jsonEncoder.encode(self)
        
        return data
    }
}

// MARK: - RequestItem.CodingKeys -

extension ResponseItem
{
    private
    enum CodingKeys: String, CodingKey
    {
        case method
        
        case path
        
        case content
    }
}
