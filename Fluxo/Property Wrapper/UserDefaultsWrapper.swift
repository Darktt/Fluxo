//
//  UserDefaultsWrapper.swift
//
//  Created by Darktt on 20/1/9.
//  Copyright © 2020 Darktt. All rights reserved.
//

import Foundation
import Combine

/**
 將屬性自動與 UserDefaults 綁定，支援預設值、Optional 與 Combine。
 
 用法：
 ```swift
 struct Settings {
     @UserDefaultsWrapper("username", defaultValue: "guest")
     var username: String
     
     @UserDefaultsWrapper("age", defaultValue: 18)
     var age: Int
 
     @UserDefaultsWrapper("website")
     var website: URL?
 }
 
 extension Settings: CustomStringConvertible {
     var description: String {
         "Settings: [username]: \(username), [age]: \(age), [website]: \(website?.absoluteString ?? "nil")"
     }
 }
 
 var settings = Settings()
 print(settings) // Settings: [username]: guest, [age]: 18, [website]: nil
 
 settings.username = "eden"
 settings.age = 30
 settings.website = URL(string: "https://github.com/")
 print(settings) // Settings: [username]: eden, [age]: 30, [website]: https://github.com/
 
 // 也可用 $username (Combine) 監聽變化（需支援平台）
 // settings.$username.sink { print("username changed: \($0)") }
 ```
 */

// MARK: - OptionalValue -

public
protocol OptionalValue: ExpressibleByNilLiteral
{
    var isNil: Bool { get }
}

extension Optional: OptionalValue
{
    public
    var isNil: Bool {
        
        self == nil
    }
}

// MARK: - UserDefaultsWrapper -

@propertyWrapper
public
struct UserDefaultsWrapper<Value>
{
    // MARK: - Properties -
    
    public
    var wrappedValue: Value {
        
        set {
            
            defer {
                
                self.userDefaults.synchronize()
            }
            
            if let newValue = newValue as? OptionalValue, newValue.isNil {
                
                self.userDefaults.removeObject(forKey: self.key)
                return
            }
            
            self.userDefaults.set(newValue, forKey: self.key)
            self.subject.send(newValue)
        }
        
        get {
            
            if let value: Value = self.userDefaults.object(forKey: self.key) as? Value {
                
                return value
            }
            
            return self.defaultValue
        }
    }
    
    @available(iOS 13.0, macOS 10.15, tvOS 13.0, *)
    public
    var projectedValue: AnyPublisher<Value, Never> {
        
        self.subject.eraseToAnyPublisher()
    }
    
    private
    let key: String
    
    private
    let defaultValue: Value
    
    private
    let userDefaults: UserDefaults
    
    @available(iOS 13.0, macOS 10.15, tvOS 13.0, *)
    private
    let subject: PassthroughSubject<Value, Never> = PassthroughSubject()
    
    // MARK: - Methods -
    // MARK: Initial Method
    
    public
    init(_ key: String, defaultValue: Value, userDefaults: UserDefaults = .standard)
    {
        self.key = key
        self.defaultValue = defaultValue
        self.userDefaults = userDefaults
        
        if userDefaults.object(forKey: key) == nil {
            
            userDefaults.set(defaultValue, forKey: key)
            userDefaults.synchronize()
        }
    }
}

public
extension UserDefaultsWrapper where Value: OptionalValue
{
    init(_ key: String, userDefaults: UserDefaults = .standard)
    {
        self.key = key
        self.defaultValue = nil
        self.userDefaults = userDefaults
    }
}

public
extension UserDefaultsWrapper where Value == URL
{
    var wrappedValue: Value {
        
        set {
            
            defer {
                
                self.userDefaults.synchronize()
            }
            
            if let newValue = newValue as? OptionalValue, newValue.isNil {
                
                self.userDefaults.removeObject(forKey: self.key)
                return
            }
            
            self.userDefaults.set(newValue.absoluteString, forKey: self.key)
            self.subject.send(newValue)
        }
        
        get {
            
            if let value: Value = self.userDefaults.object(forKey: self.key) as? Value,
               let url = URL(string: value.absoluteString) {
                
                return url
            }
            
            return self.defaultValue
        }
    }
}
