//
//  ResponseDecodable.swift
//
//  Created by Darktt on 2025/12/24.
//  Copyright © 2025 Darktt. All rights reserved.
//

import Foundation

public
protocol ResponseDecodable
{
    static func decode(with data: Data) throws -> Self
}

extension String: ResponseDecodable
{
    public static
    func decode(with data: Data) throws -> String
    {
        guard let string: String = String(data: data, encoding: .utf8) else {
            
            let userInfo: Dictionary<String, Any> = [
                NSLocalizedDescriptionKey: "Failed to decode Data to String."
            ]
            throw NSError(domain: "ResponseDecodable", code: -1, userInfo: userInfo)
        }
        
        return string
    }
}
