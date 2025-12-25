//
//  URLRequestExtension.swift
//
//  Created by Darktt on 19/5/28.
//  Copyright © 2019 Darktt. All rights reserved.
//

import Foundation

public 
extension URLRequest
{
    // MARK: - Properties -
    
    var method: HTTPMethod? {
        
        get {
            
            guard let httpMethod = self.httpMethod else {
                
                return nil
            }
            
            let method = HTTPMethod(rawValue: httpMethod)!
            
            return method
        }
        
        set {
            
            self.httpMethod = newValue?.rawValue
        }
    }
    
    var httpHeaders: Array<HTTPHeader> {
        
        guard let allHTTPHeaderFields: Dictionary = self.allHTTPHeaderFields else {
            
            return []
        }
        
        let headers: Array<HTTPHeader> = HTTPHeader.dictionary(allHTTPHeaderFields)
        
        return headers
    }
    
    // MARK: - Methods -
    // MARK: Initial Method
    
    init(url: URL, method: HTTPMethod, @HTTPHeaderBuilder headers: () -> Dictionary<String, String>)
    {
        self.init(url: url)
        
        self.method = method
        self.allHTTPHeaderFields = headers()
    }
    
    mutating func addHTTPHeaders(@HTTPHeaderBuilder _ headers: () -> Dictionary<String, String>)
    {
        self.allHTTPHeaderFields = headers()
    }
}
