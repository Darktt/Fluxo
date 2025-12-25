//
//  HTTPError.swift
//
//  Created by Darktt on 19/3/28.
//  Copyright © 2019 Darktt. All rights reserved.
//

import Foundation

public 
struct HTTPError: Error, CustomNSError
{
    // MARK: - Properties -
    
    public
    let statusCode: StatusCode
    
    public
    var errorCode: Int {
        
        return self.statusCode.rawValue
    }
    
    // MARK: - Methods -
    // MARK: Initial Method
    
    public
    init(_ statusCode: StatusCode)
    {
        self.statusCode = statusCode
    }
    
    public
    init(_ code: Int)
    {
        let statusCode = StatusCode(rawValue: code)!
        
        self.statusCode = statusCode
    }
}

extension HTTPError: LocalizedError
{
    public
    var errorDescription: String? {
        
        return "\(self)"
    }
}

extension HTTPError: CustomStringConvertible
{
    public
    var description: String {
        
        let description: String = "\(self.statusCode.rawValue) \(self.statusCode)"
        
        return description
    }
}

// MARK: - HTTPError.StatusCode -

public 
extension HTTPError
{
    enum StatusCode: Int
    {
        // 100 Informational
        case `continue` = 100
        
        case switchingProtocols
        
        case processing
        
        // 200 Success
//        case ok = 200
        
        case created
        
        case accepted
        
        case nonAuthoritativeInformation
        
        case noContent
        
        case resetContent
        
        case partialContent
        
        case multiStatus
        
        case alreadyReported
        
        case iMUsed = 226
        
        // 300 Redirection
        case multipleChoices = 300
        
        case movedPermanently
        
        case found
        
        case seeOther
        
        case notModified
        
        case useProxy
        
        case switchProxy
        
        case temporaryRedirect
        
        case permanentRedirect
        
        // 400 Client Error
        case badRequest = 400
        
        case unauthorized
        
        case paymentRequired
        
        case forbidden
        
        case notFound
        
        case methodNotAllowed
        
        case notAcceptable
        
        case proxyAuthenticationRequired
        
        case requestTimeout
        
        case conflict
        
        case gone
        
        case lengthRequired
        
        case preconditionFailed
        
        case payloadTooLarge
        
        case uriTooLong
        
        case unsupportedMediaType
        
        case rangeNotSatisfiable
        
        case expectationFailed
        
        case imATeapot
        
        case misdirectedRequest = 421
        
        case unprocessableEntity
        
        case locked
        
        case failedDependency
        
        case upgradeRequired = 426
        
        case preconditionRequired = 428
        
        case tooManyRequests
        
        case requestHeaderFieldsTooLarge = 431
        
        case unavailableForLegalReasons = 451
        
        // 500 Server Error
        case internalServerError = 500
        
        case notImplemented
        
        case badGateway
        
        case serviceUnavailable
        
        case gatewayTimeout
        
        case httpVersionNotSupported
        
        case variantAlsoNegotiates
        
        case insufficientStorage
        
        case loopDetected
        
        case notExtended = 510
        
        case networkAuthenticationRequired
    }
}

extension HTTPError.StatusCode: CustomStringConvertible
{
    public
    var description: String {
        
        let description: String
        
        switch self {
            
        case .`continue`:
            description = "Continue"
            
        case .switchingProtocols:
            description = "Switching Protocols"
            
        case .processing:
            description = "Processing"
            
        case .created:
            description = "Created"
            
        case .accepted:
            description = "Accepted"
            
        case .nonAuthoritativeInformation:
            description = "Non Authoritative Information"
            
        case .noContent:
            description = "No Content"
            
        case .resetContent:
            description = "Reset Content"
            
        case .partialContent:
            description = "Partial Content"
            
        case .multiStatus:
            description = "Multi Status"
            
        case .alreadyReported:
            description = "Already Reported"
            
        case .iMUsed:
            description = "IM Used"
            
        case .multipleChoices:
            description = "Multiple Choices"
            
        case .movedPermanently:
            description = "Moved Permanently"
            
        case .found:
            description = "Found"
            
        case .seeOther:
            description = "See Other"
            
        case .notModified:
            description = "Not Modified"
            
        case .useProxy:
            description = "Use Proxy"
            
        case .switchProxy:
            description = "Switch Proxy"
            
        case .temporaryRedirect:
            description = "Temporary Redirect"
            
        case .permanentRedirect:
            description = "Permanent Redirect"
            
        case .badRequest:
            description = "Bad Request"
            
        case .unauthorized:
            description = "Unauthorized"
            
        case .paymentRequired:
            description = "Payment Required"
            
        case .forbidden:
            description = "Forbidden"
            
        case .notFound:
            description = "Not Found"
            
        case .methodNotAllowed:
            description = "Method Not Allowed"
            
        case .notAcceptable:
            description = "Not Acceptable"
            
        case .proxyAuthenticationRequired:
            description = "Proxy Authentication Required"
            
        case .requestTimeout:
            description = "Request Timeout"
            
        case .conflict:
            description = "Conflict"
            
        case .gone:
            description = "Gone"
            
        case .lengthRequired:
            description = "Length Required"
            
        case .preconditionFailed:
            description = "Precondition Failed"
            
        case .payloadTooLarge:
            description = "Payload Too Large"
            
        case .uriTooLong:
            description = "URI Too Long"
            
        case .unsupportedMediaType:
            description = "Unsupported Media Type"
            
        case .rangeNotSatisfiable:
            description = "Range Not Satisfiable"
            
        case .expectationFailed:
            description = "ExpectationFailed"
            
        case .imATeapot:
            description = "I'm a teapot"
            
        case .misdirectedRequest:
            description = "Misdirected Request"
            
        case .unprocessableEntity:
            description = "Unprocessable Entity"
            
        case .locked:
            description = "Locked"
            
        case .failedDependency:
            description = "Failed Dependency"
            
        case .upgradeRequired:
            description = "Upgrade Required"
            
        case .preconditionRequired:
            description = "Precondition Required"
            
        case .tooManyRequests:
            description = "Too Many Requests"
            
        case .requestHeaderFieldsTooLarge:
            description = "Request Header Fields Too Large"
            
        case .unavailableForLegalReasons:
            description = "Unavailable For Legal Reasons"
            
        case .internalServerError:
            description = "Internal Server Error"
            
        case .notImplemented:
            description = "Not Implemented"
            
        case .badGateway:
            description = "Bad Gateway"
            
        case .serviceUnavailable:
            description = "Service Unavailable"
            
        case .gatewayTimeout:
            description = "Gateway Timeout"
            
        case .httpVersionNotSupported:
            description = "Http Version Not Supported"
            
        case .variantAlsoNegotiates:
            description = "Variant Also Negotiates"
            
        case .insufficientStorage:
            description = "Insufficient Storage"
            
        case .loopDetected:
            description = "Loop Detected"
            
        case .notExtended:
            description = "Not Extended"
            
        case .networkAuthenticationRequired:
            description = "Network Authentication Required"
        }
        
        return description
    }
}
