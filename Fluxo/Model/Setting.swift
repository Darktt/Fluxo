//
//  Setting.swift
//  Fluxo
//
//  Created by Darktt on 2025/10/12.
//

import Foundation
import SwiftExtensions

public
struct Setting
{
    // MARK: - Properties -
    
    @UserDefaultsWrapper("port", defaultValue: 3000)
    public
    var port: UInt16
    
    public private(set)
    var requestItems: Array<ResponseItem> = [] {
        
        willSet {
            
            do {
                
                let data: Array<Data> = try newValue.map({ try $0.encode() })
                
                self.requestItemDates = data
            } catch {
                
                print("Failed to encode requestItems: \(error)")
            }
        }
    }
    
    public
    var isNeedsToShowChangeLog: Bool {
        
        return self.watchedVersion != self.version;
    }
    
    public
    let version: String = "1.0.1"
    
    @UserDefaultsWrapper("requestItemDates", defaultValue: [])
    private
    var requestItemDates: Array<Data>
    
    @UserDefaultsWrapper("watchedVersion", defaultValue: "1.0.0")
    private
    var watchedVersion: String
    
    // MARK: - Methods -
    // MARK: Initial Method
    
    public
    init()
    {
        self.requestItems = []
//        self.watchedVersion = ""
        
        do {
            
            let items = try self.requestItemDates.map {
                
                try ResponseItem.decode(with: $0)
            }
            
            self.requestItems = items
        } catch {
            
            print("Failed to decode requestItemDates: \(error)")
        }
    }
    
    public mutating
    func add(_ item: ResponseItem)
    {
        if let index = self.requestItems.firstIndex(of: item) {
            
            self.requestItems.remove(at: index)
        }
        
        self.requestItems.append(item)
    }
    
    public mutating
    func remove(_ item: ResponseItem)
    {
        self.requestItems.remove(object: item)
    }
    
    public
    func item(with path: String, method: HTTPMethod) -> ResponseItem?
    {
        self.requestItems.first {
            
            var result = $0.path == path
            result &= $0.method == method
            
            return result
        }
    }
    
    public mutating
    func setWatchedVersion(version: String)
    {
        self.watchedVersion = version
    }
}
