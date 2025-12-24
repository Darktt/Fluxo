//
//  ChangeLogRequest.swift
//  Fluxo
//
//  Created by Eden on 2025/12/24.
//

import Foundation
import SwiftExtensions

@MainActor
public
struct ChangeLogRequest: APIRequest
{
    // MARK: - Properties -
    
    public
    typealias Response = String
    
    public
    let apiName: APIName
    
    public
    let method: SwiftExtensions.HTTPMethod = .get
    
    public
    let parameters: Dictionary<AnyHashable, Any>? = nil
    
    public
    let headers: Array<HTTPHeader>? = nil
    
    // MARK: - Methods -
    // MARK: Initial Method
    
    init(version: String, language: String)
    {
        let apiName = APIName.changeLog(version: version, language: language)
        
        self.apiName = apiName
    }
}
