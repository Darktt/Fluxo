//
//  Setting.swift
//  Fluxo
//
//  Created by Darktt on 2025/10/12.
//

import Foundation

public
struct Setting
{
    // MARK: - Properties -
    
    @UserDefaultsWrapper("port", defaultValue: 3000)
    public
    var port: UInt16
    
    // MARK: - Methods -
    // MARK: Initial Method
    
    public
    init()
    {
        
    }
}
