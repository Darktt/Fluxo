//
//  RequestItemExtension.swift
//
//  Created by Darktt on 2025/11/4.
//  
//

import Foundation

public
struct RequestItem
{
    let method: HTTPMethod
    
    let path: String
    
    let content: String
}

extension RequestItem: Hashable
{
    public
    func hash(into hasher: inout Hasher)
    {
        hasher.combine(method)
        hasher.combine(path)
    }
}

extension RequestItem: Codable
{
    public static
    func decode(with data: Data) throws -> RequestItem
    {
        let jsonDecoder = JSONDecoder()
        let requestItem = try jsonDecoder.decode(RequestItem.self, from: data)
        
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

extension RequestItem
{
    private
    enum CodingKeys: String, CodingKey
    {
        case method
        
        case path
        
        case content
    }
}

extension HTTPMethod: Codable
{
    
}
