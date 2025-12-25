//
//  DataExtension.swift
//
//  Created by Darktt on 16/10/12.
//  Copyright © 2016 Darktt. All rights reserved.
//

import Foundation

private
let CC_SHA1_DIGEST_LENGTH: Int32 = 20

private
let CC_SHA256_DIGEST_LENGTH: Int32 = 32

private
let CC_MD5_DIGEST_LENGTH: Int32 = 16

private
typealias CC_LONG = CUnsignedInt

@_silgen_name("CC_SHA1") @discardableResult
private
func CC_SHA1(data: UnsafeRawPointer, len: CC_LONG, md: UnsafeMutablePointer<UInt8>) -> Int32

@_silgen_name("CC_SHA256") @discardableResult
private
func CC_SHA256(data: UnsafeRawPointer, len: CC_LONG, md: UnsafeMutablePointer<UInt8>) -> Int32

@_silgen_name("CC_MD5") @discardableResult
private
func CC_MD5(data: UnsafeRawPointer, len: CC_LONG, md: UnsafeMutablePointer<UInt8>) -> Int32

public 
extension Data
{
    // MARK: - Properties -
    
    var bytes: Array<UInt8> {
        
        return Array<UInt8>(self)
    }
    
    var hexString: String {
        
        let hexString: String = self.reduce("") {
            
            let character = String(format: "%.2x", $1)
            
            return $0 + character
        }
        
        return hexString
    }
    
    var debugHexString: String {
        
        let hexString: String = self.reduce("") {
            
            let character = String(format: "%.2x", $1)
            
            return $0 + " " + character
        }
        
        return hexString
    }
    
    // MARK: - Methods -
    
    func string(encoding: String.Encoding = .utf8) -> String?
    {
        let encodedString = String(data: self, encoding: encoding)
        
        return encodedString
    }
    
    func md5() -> String
    {
        let length = UInt32(self.count)
        let digestLength = Int(CC_MD5_DIGEST_LENGTH)
        var result: Array<UInt8> = Array(repeating: 0, count: digestLength)
        
        CC_MD5(data: self.bytes, len: length, md: &result)
        
        let hash: String = result.reduce("") {
            
            let hashString = String(format: "%02x", $1)
            
            return $0 + hashString
        }
        
        return hash
    }
    
    func sha1() -> String
    {
        let length = UInt32(self.count)
        let digestLength = Int(CC_SHA1_DIGEST_LENGTH)
        var result: Array<UInt8> = Array(repeating: 0, count: digestLength)
        
        CC_SHA1(data: self.bytes, len: length, md: &result)
        
        let hash: String = result.reduce("") {
            
            let hashString = String(format: "%02x", $1)
            
            return $0 + hashString
        }
        
        return hash
    }
    
    func sha256() -> String
    {
        let length = UInt32(self.count)
        let digestLength = Int(CC_SHA256_DIGEST_LENGTH)
        var result: Array<UInt8> = Array(repeating: 0, count: digestLength)
        
        CC_SHA256(data: self.bytes, len: length, md: &result)
        
        let hash: String = result.reduce("") {
            
            let hashString = String(format: "%02x", $1)
            
            return $0 + hashString
        }
        
        return hash
    }
}
