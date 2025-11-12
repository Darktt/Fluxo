//
//  HTTPMethod.swift
//
//  Created by Darktt on 19/5/28.
//  Copyright © 2019 Darktt. All rights reserved.
//

import Foundation

public
enum HTTPMethod: String
{
    case connect = "CONNECT"
    
    case delete  = "DELETE"
    
    case get     = "GET"
    
    case head    = "HEAD"
    
    case options = "OPTIONS"
    
    case patch   = "PATCH"
    
    case post    = "POST"
    
    case put     = "PUT"
    
    case trace   = "TRACE"
    
    public static
    var allCases: Array<HTTPMethod> {
        
        [.connect, .delete, .get, .head, .options, .patch, .post, .put, .trace]
    }
}

extension HTTPMethod: Equatable
{
    public static func == (lhs: String, rhs: HTTPMethod) -> Bool
    {
        return lhs == rhs.rawValue
    }
    
    public static func == (lhs: HTTPMethod, rhs: String) -> Bool
    {
        return rhs == lhs
    }
    
    public static func == (lhs: String?, rhs: HTTPMethod) -> Bool
    {
        guard let method: String = lhs else {
            
            return false
        }
        
        return method == rhs
    }
    
    public static func == (lhs: HTTPMethod, rhs: String?) -> Bool
    {
        return rhs == lhs
    }
    
    public static func == (lhs: HTTPMethod, rhs: HTTPMethod) -> Bool
    {
        return lhs.rawValue == rhs.rawValue
    }
}

extension HTTPMethod: Codable
{
    
}

extension HTTPMethod: Identifiable
{
    public
    var id: String {
        
        self.rawValue
    }
}
