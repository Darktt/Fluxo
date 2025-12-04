//
//  MonitorError.swift
//  Fluxo
//
//  Created by Eden on 2025/8/19.
//

import Foundation

public
enum MonitorErrorCode: Int32 {
    
    case unknown = -1
    
    case portAlreadyUsed = 1804225296
}

public
typealias MonitorError = (code: Int, message: String)
