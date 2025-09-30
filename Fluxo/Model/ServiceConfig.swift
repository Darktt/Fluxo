//
//  ServiceConfig.swift
//  Fluxo
//
//  Created by Eden on 2025/9/30.
//

import Foundation

public
struct ServiceConfig
{
    // MARK: - Properties -
    
    public static
    let port: UInt16 = 3000
    
    //The TCP maximum package size is 64K 65536
    public static
    let mtu: Int = 65536
}
