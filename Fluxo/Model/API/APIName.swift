//
//  APIName.swift
//
//  Created by Darktt on 2025/8/12.
//  Copyright © 2025 Darktt. All rights reserved.
//

import Foundation

@MainActor
public
struct APIName
{
    // MARK: - Properties -
    
    public
    var url: URL
    
    // MARK: - Methods -
    // MARK: Initial Method
    
    private
    init(_ urlString: String)
    {
        self.url = URL(string: urlString)!
    }
}

public
extension APIName
{
    static
    func changeLog(version: String, language: String) -> APIName
    {
        let baseUrl: String = "https://www.fluxoapp.org/change log/"
        let url = baseUrl + "\(version)/\(language).md"
        let apiName = APIName(url)
        
        return apiName
    }
}

