//
//  OptionalExtension.swift
//
//  Created by Darktt on 19/6/11.
//  Copyright © 2019 Darktt. All rights reserved.
//

import Foundation

public 
extension Optional
{
    /// Unwrap object, when unwrap success will execute block and return object, otherwise return nil.
    ///
    /// - Parameter block: The block will be execute.
    /// - Returns: Unwrapped object.
    /// - Throws: Error type throwed from block.
    @discardableResult
    func unwrapped(_ block: (Wrapped) throws -> Void) rethrows -> Optional<Wrapped>
    {
        if case let .some(wrapped) = self {
            
            try block(wrapped)
        }
        
        return self
    }
    
    /// Unwrap and case down object, when case success will execute block and return object, otherwise return nil.
    ///
    /// - Parameters:
    ///   - type: Type to case.
    ///   - block: The block will be execute.
    ///   - wrapped: Unwrapped and case down object.
    /// - Returns: Case down object.
    /// - Throws: Error type throwed from block.
    @discardableResult
    func unwrapped<NewWrapped>(as type: NewWrapped.Type, _ block: (_ wrapped: NewWrapped) throws -> Void) rethrows -> Optional<NewWrapped>
    {
        guard case let .some(wrapped) = self, let caseType = wrapped as? NewWrapped else {
            
            return nil
        }
        
        try block(caseType)
        
        return caseType
    }
    
    func or(_ condition: Bool) -> Optional<Wrapped>
    {
        guard self != nil || condition else {
            
            return nil
        }
        
        return self
    }
    
    /// Return unwrapped object or default object.
    ///
    /// - Parameter default: Default value when unwrapped failed
    /// - Returns: Unwrapped object if not nil, otherwise default object.
    func or(_ default: Wrapped) -> Wrapped
    {
        let unwrapped: Wrapped = self ?? `default`
        
        return unwrapped
    }
    
    func or(else: @autoclosure () -> Wrapped) -> Wrapped
    {
        let unwrapped: Wrapped = self ?? `else`()
        
        return unwrapped
    }
    
    func or(throw exception: Error) throws -> Wrapped
    {
        guard case let .some(unwrapped) = self else {
            
            throw exception
        }
        
        return unwrapped
    }
    
    func and(_ condition: Bool) -> Optional<Wrapped>
    {
        guard case .some = self, condition else {
            
            return nil
        }
        
        return self
    }
    
    func and(_ condition: (Wrapped) -> Bool) -> Optional<Wrapped>
    {
        guard case let .some(unwrapped) = self, condition(unwrapped) else {
            
            return nil
        }
        
        return self
    }
    
    func and<Other>(_ other: Optional<Other>) -> Optional<Other>
    {
        guard self != nil else {
            
            return nil
        }
        
        return other
    }
    
    func filter(_ predicate: (Wrapped) -> Bool) -> Optional<Wrapped>
    {
        guard case let .some(unwrapped) = self, predicate(unwrapped) else {
            
            return nil
        }
        
        return self
    }
    
    func expect(_ message: String) -> Wrapped
    {
        guard case let .some(unwrapped) = self else {
            
            fatalError(message)
        }
        
        return unwrapped
    }
    
    func `else`(_ block: () throws -> Void) rethrows
    {
        guard self == nil else {
            
            return
        }
        
        try block()
    }
    
    func elseMap<T>(_ block: () throws -> T) rethrows -> T?
    {
        guard self == nil else {
            
            return nil
        }
        
        let result: Optional<T> = try block()
        
        return result
    }
    
    func compactMap<CaseType, ReturnType>(as: CaseType.Type, transform: (CaseType) throws -> Optional<ReturnType>) rethrows -> Optional<ReturnType>
    {
        guard case let .some(wrapped) = self, let caseType = wrapped as? CaseType else {
            
            return nil
        }
        
        let object: Optional<ReturnType> = try transform(caseType)
        
        return object
    }
    
    func compactMap<T>(_ transfrom: (Wrapped) throws -> Optional<T>) rethrows -> Optional<T>
    {
        guard case let .some(unwrapped) = self else {
            
            return nil
        }
        
        let result: Optional<T> = try transfrom(unwrapped)
        
        return result
    }
    
    func zip<Other>(_ other: Other?) -> Optional<(Wrapped, Other)>
    {
        guard case let .some(unwrapped) = self, case let .some(other) = other else {
            
            return nil
        }
        
        return (unwrapped, other)
    }
}

extension Optional where Wrapped: Comparable
{
    public static
    func < (lhs: Optional<Wrapped>, rhs: Optional<Wrapped>) -> Bool
    {
        guard let left: Wrapped = lhs, let right: Wrapped = rhs else {
            
            return false
        }
        
        return left < right
    }
    
    public static
    func <= (lhs: Optional<Wrapped>, rhs: Optional<Wrapped>) -> Bool
    {
        guard let left: Wrapped = lhs, let right: Wrapped = rhs else {
            
            return false
        }
        
        return left <= right
    }
    
    public static
    func > (lhs: Optional<Wrapped>, rhs: Optional<Wrapped>) -> Bool
    {
        guard let left: Wrapped = lhs, let right: Wrapped = rhs else {
            
            return false
        }
        
        return left < right
    }
    
    public static
    func >= (lhs: Optional<Wrapped>, rhs: Optional<Wrapped>) -> Bool
    {
        guard let left: Wrapped = lhs, let right: Wrapped = rhs else {
            
            return false
        }
        
        return left >= right
    }
}

public
extension Optional where Wrapped: AdditiveArithmetic
{
    static
    func += (left: inout Optional<Wrapped>, right: Wrapped)
    {
        guard let unwarppedLeft = left else {
            
            return
        }
        
        left = .some(unwarppedLeft + right)
    }
    
    static
    func -= (left: inout Optional<Wrapped>, right: Wrapped)
    {
        guard let unwarppedLeft = left else {
            
            return
        }
        
        left = .some(unwarppedLeft - right)
    }
}

// MARK: - Optional<Error> -

public 
extension Optional where Wrapped == Error
{
    func or(_ else: (Wrapped) -> Void)
    {
        guard let error: Wrapped = self else {
            
            return
        }
        
        `else`(error)
    }
}
