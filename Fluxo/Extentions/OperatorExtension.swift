//
//  OperatorExtension.swift
//
//  Created by Darktt on 15/2/3.
//  Copyright © 2015 Darktt. All rights reserved.
//

import Foundation

#if canImport(CoreGraphics)

import CoreGraphics

#endif

#if canImport(CoreLocation)

import CoreLocation

#endif

// MARK: - "+" -

#if canImport(CoreGraphics)

public
func + (left: CGPoint, right: CGPoint) -> CGPoint
{
    return CGPoint(x: left.x + right.x, y: left.y + right.y)
}

public
func + (left: CGSize, right: CGSize) -> CGSize
{
    return CGSize(width: left.width + right.width, height: left.height + right.height)
}

#endif

public
func + <T> (left: Dictionary<AnyHashable, T>, right: Dictionary<AnyHashable, T>) -> Dictionary<AnyHashable, T>
{
    var newDictionary = left
    
    right.forEach {
        
        newDictionary[$0.key] = $0.value
    }
    
    return newDictionary
}

public
func + <T> (left: Array<T>, right: T) -> Array<T>
{
    var newArray = left
    newArray.append(right)
    
    return newArray
}

public
func + <T> (left: Array<T>, right: Array<T>) -> Array<T>
{
    var newArray = left
    newArray.append(contentsOf: right)
    
    return newArray
}

public
func + <T> (left: Set<T>, right: T) -> Set<T> where T: Hashable
{
    var newSet = left
    newSet.insert(right)
    
    return newSet
}

public
func + <T> (left: Set<T>, right: Set<T>) -> Set<T> where T: Hashable
{
    var newSet = left
    newSet.formUnion(right)
    
    return newSet
}

// MARK: - "+=" -

#if canImport(CoreGraphics)

public
func += (left: inout CGPoint, right: CGPoint)
{
    left = left + right
}

public
func += (left: inout CGSize, right: CGSize)
{
    left = left + right
}

#endif

public
func += <T> (left: inout Dictionary<AnyHashable, T>, right: Dictionary<AnyHashable, T>)
{
    left = left + right
}

public
func += <T> (left: inout Array<T>, right: T)
{
    left = left + right
}

public
func += <T> (left: inout Array<T>, right: Array<T>)
{
    left = left + right
}

public
func += <T> (left: inout Set<T>, right: T) where T: Hashable
{
    left = left + right
}

public
func += <T> (left: inout Set<T>, right: Set<T>) where T: Hashable
{
    left = left + right
}

// MARK: - "-" -

#if canImport(CoreGraphics)

public
func - (left: CGPoint, right: CGPoint) -> CGPoint
{
    return CGPoint(x: left.x - right.x, y: left.y - right.y)
}

public
func - (left: CGSize, right: CGSize) -> CGSize
{
    return CGSize(width: left.width - right.width, height: left.height - right.height)
}

#endif

public
func - (left: String, right: String) -> String
{
    let range: Range<String.Index>? = left.range(of: right, options: .caseInsensitive)
    
    if let range = range {
        
        let startIndex = left.startIndex
        let endIndex = left.endIndex
        
        return String(left[startIndex ..< range.lowerBound]) + left[range.upperBound ..< endIndex]
    }
    
    return left
}

public
func - <T> (left: Array<T>, right: T) -> Array<T> where T: Equatable
{
    var newArray = left
    newArray.remove(object: right)
    
    return newArray
}

public
func - <T> (left: Array<T>, right: Array<T>) -> Array<T> where T: Equatable
{
    var newArray = left
    
    right.forEach {
        
        newArray.remove(object: $0)
    }
    
    return newArray
}

public
func - <T> (left: Set<T>, right: T) -> Set<T> where T: Hashable
{
    var newSet = left
    newSet.remove(right)
    
    return newSet
}

public
func - <T> (left: Set<T>, right: Set<T>) -> Set<T> where T: Hashable
{
    var newSet = left
    newSet.subtract(right)
    
    return newSet
}

// MARK: - "-=" -

#if canImport(CoreGraphics)

public
func -= (left: inout CGPoint, right: CGPoint)
{
    left = left - right
}

public
func -= (left: inout CGSize, right: CGSize)
{
    left = left - right
}

public
func -= (left: inout String, right: String)
{
    left = left - right
}

#endif

public
func -= <T> (left: inout Array<T>, right: T) where T: Equatable
{
    left = left - right
}

public
func -= <T> (left: inout Array<T>, right: Array<T>) where T: Equatable
{
    left = left - right
}

public
func -= <T> (left: inout Set<T>, right: T) where T: Hashable
{
    left = left - right
}

public
func -= <T> (left: inout Set<T>, right: Set<T>) where T: Hashable
{
    left = left - right
}

// MARK: - "+-" -

infix operator +-: RangeFormationPrecedence

public
func +- <Bound> (left: Bound, right: Bound) -> ClosedRange<Bound> where Bound: SignedInteger
{
    let lower: Bound = left - right
    let upper: Bound = left + right
    let range: ClosedRange<Bound> = lower ... upper
    
    return range
}

public
func +- <Bound> (left: Bound, right: Bound) -> ClosedRange<Bound> where Bound: FloatingPoint
{
    let lower: Bound = left - right
    let upper: Bound = left + right
    let range: ClosedRange<Bound> = lower ... upper
    
    return range
}

prefix operator +-

public prefix func +- <I> (number: I) -> ClosedRange<I> where I: SignedInteger
{
    let range: ClosedRange<I> = 0 +- number
    
    return range
}

public prefix func +- <F> (number: F) -> ClosedRange<F> where F: FloatingPoint
{
    let range: ClosedRange<F> = 0 +- number
    
    return range
}

// MARK: - "*" -

#if canImport(CoreGraphics)

public
func * (left: CGPoint, right: CGFloat) -> CGPoint
{
    return CGPoint(x: left.x * right, y: left.y * right)
}

public
func * (left: CGPoint, right: CGPoint) -> CGPoint
{
    return CGPoint(x: left.x * right.x, y: left.y * right.y)
}

public
func * (left: CGSize, right: CGFloat) -> CGSize
{
    return CGSize(width: left.width * right, height: left.height * right)
}

public
func * (left: CGSize, right: CGSize) -> CGSize
{
    return CGSize(width: left.width * right.width, height: left.height * right.height)
}

public
func * (left: CGRect, right: CGFloat) -> CGRect
{
    var result: CGRect = left
    result.size *= right
    
    return result
}

public
func * (left: CGRect, right: CGPoint) -> CGRect
{
    var result: CGRect = left
    result.origin *= right
    
    return result
}

public
func * (left: CGRect, right: CGSize) -> CGRect
{
    var result: CGRect = left
    result.size *= right
    
    return result
}

public
func * (left: CGRect, right: CGRect) -> CGRect
{
    var result: CGRect = left
    result.origin *= right.origin
    result.size *= right.size
    
    return result
}

#endif

// MARK: - "*=" -

#if canImport(CoreGraphics)

public
func *= (left: inout CGPoint, right: CGFloat)
{
    left = left * right
}

public
func *= (left: inout CGPoint, right: CGPoint)
{
    left = left * right
}

public
func *= (left: inout CGSize, right: CGFloat)
{
    left = left * right
}

public
func *= (left: inout CGSize, right: CGSize)
{
    left = left * right
}

public
func *= (left: inout CGRect, right: CGFloat)
{
    left = left * right
}

public
func *= (left: inout CGRect, right: CGPoint)
{
    left = left * right
}

public
func *= (left: inout CGRect, right: CGSize)
{
    left = left * right
}

public
func *= (left: inout CGRect, right: CGRect)
{
    left = left * right
}

#endif

// MARK: - "/" -

#if canImport(CoreGraphics)

public
func / (left: CGPoint, right: CGFloat) -> CGPoint
{
    return CGPoint(x: left.x / right, y: left.y / right)
}

public
func / (left: CGPoint, right: CGPoint) -> CGPoint
{
    return CGPoint(x: left.x / right.x, y: left.y / right.y)
}

public
func / (left: CGSize, right: CGFloat) -> CGSize
{
    return CGSize(width: left.width / right, height: left.height / right)
}

public
func / (left: CGSize, right: CGSize) -> CGSize
{
    return CGSize(width: left.width / right.width, height: left.height / right.height)
}

public
func / (left: CGRect, right: CGFloat) -> CGRect
{
    var result: CGRect = left
    result.size /= right
    
    return result
}

public
func / (left: CGRect, right: CGPoint) -> CGRect
{
    var result: CGRect = left
    result.origin /= right
    
    return result
}

public
func / (left: CGRect, right: CGSize) -> CGRect
{
    var result: CGRect = left
    result.size /= right
    
    return result
}

public
func / (left: CGRect, right: CGRect) -> CGRect
{
    var result: CGRect = left
    result.origin /= right.origin
    result.size /= right.size
    
    return result
}

#endif

// MARK: - "/=" -

#if canImport(CoreGraphics)

public
func /= (left: inout CGPoint, right: CGFloat)
{
    left = left / right
}

public
func /= (left: inout CGPoint, right: CGPoint)
{
    left = left / right
}

public
func /= (left: inout CGSize, right: CGFloat)
{
    left = left / right
}

public
func /= (left: inout CGSize, right: CGSize)
{
    left = left / right
}

public
func /= (left: inout CGRect, right: CGFloat)
{
    left = left / right
}

public
func /= (left: inout CGRect, right: CGPoint)
{
    left = left / right
}

public
func /= (left: inout CGRect, right: CGSize)
{
    left = left / right
}

public
func /= (left: inout CGRect, right: CGRect)
{
    left = left / right
}

#endif

// MARK: - "**" -

precedencegroup ExponentiationPrecedence {
    associativity: left
    higherThan: MultiplicationPrecedence
}

infix operator **: ExponentiationPrecedence

#if canImport(CoreGraphics)

public
func ** (left: CGFloat, right: CGFloat) -> CGFloat
{
    return pow(left, right)
}

#endif

public
func ** (left: Double, right: Double) -> Double
{
    return pow(left, right)
}

public
func ** (left: Float, right: Float) -> Float
{
    return powf(left, right)
}

public
func ** (left: Int, right: Int) -> Int
{
    let result: Double = Double(left) ** Double(right)
    
    return Int(result)
}

// MARK: - "**=" -

infix operator **=: AssignmentPrecedence

#if canImport(CoreGraphics)

public
func **= ( left: inout CGFloat, right: CGFloat)
{
    left = left ** right
}

#endif

public
func **= ( left: inout Double, right: Double)
{
    left = left ** right
}

public
func **= ( left: inout Float, right: Float)
{
    left = left ** right
}

public
func **= ( left: inout Int, right: Int)
{
    left = left ** right
}

// MARK: - "√" -

prefix operator √

#if canImport(CoreGraphics)

public prefix func √ (number: CGFloat) -> CGFloat
{
    return sqrt(number)
}

#endif

public prefix func √ (number: Double) -> Double
{
    return sqrt(number)
}

public prefix func √ (number: Float) -> Float
{
    return sqrtf(number)
}

public prefix func √ (number: Int) -> Int
{
    let result: Double = sqrt(Double(number))
    
    return Int(result)
}

// MARK: - "x√y" -

precedencegroup SqrtPrecedence {
    associativity: left
    higherThan: MultiplicationPrecedence
}

infix operator √ : SqrtPrecedence

#if canImport(CoreGraphics)

public
func √ (left: CGFloat, right: CGFloat) -> CGFloat
{
    return right ** ( 1 / left )
}

#endif

public
func √ (left: Double, right: Double) -> Double
{
    return right ** ( 1 / left )
}

public
func √ (left: Float, right: Float) -> Float
{
    return right ** ( 1 / left )
}

public
func √ (left: Int, right: Int) -> Int
{
    let result: Double = Double(left) √ Double(right)
    
    return Int(result)
}

// MARK: - "%" -

postfix operator %

#if canImport(CoreGraphics)

public postfix func % (percentage: CGFloat) -> CGFloat
{
    return (percentage / 100.0)
}

#endif

public postfix func % (percentage: Double) -> Double
{
    return (percentage / 100.0)
}

public postfix func % (percentage: Float) -> Float
{
    return (percentage / 100.0)
}

public postfix func % (percentage: Int) -> Double
{
    let result: Double = Double(percentage) / 100.0
    
    return result
}

// MARK: - "<" -

public
func < (left: NSDate?, right: NSDate?) -> Bool
{
    guard let left = left as Date?, let right = right as Date? else {
        
        return false
    }
    
    return left < right
}

public
func < (left: Date?, right: Date?) -> Bool
{
    guard let left = left, let right = right else {
        
        return false
    }
    
    return left < right
}

// MARK: - ">" -

public
func > (left: NSDate?, right: NSDate?) -> Bool
{
    guard let left = left as Date?, let right = right as Date? else {
        
        return false
    }
    
    return left > right
}

public
func > (left: Date?, right: Date?) -> Bool
{
    guard let left = left, let right = right else {
        
        return false
    }
    
    return left > right
}

// MARK: - "|=" -

public
func |= (left: inout Bool, right: @autoclosure () throws -> Bool) rethrows
{
    left = try left || right()
}

// MARK: - "&=" -

public
func &= (left: inout Bool, right: @autoclosure () throws -> Bool) rethrows
{
    left = try left && right()
}

// MARK: - "~="
// MARK: Contains in -

#if canImport(CoreGraphics)

public
func ~= (left: CGRect, right: CGPoint) -> Bool
{
    return left.contains(right)
}

public
func ~= (left: CGRect, right: CGRect) -> Bool
{
    return left.contains(right)
}

#endif

public
func ~= <T> (left: Array<T>, right: T) -> Bool where T: Equatable
{
    return left.contains(right)
}

public
func ~= <T> (left: Set<T>, right: T) -> Bool where T: Equatable
{
    return left.contains(right)
}

/// Check right string contained within left string
///
/// - Discussion: Equivalent to `left.contains(right)`.
/// - Parameter left: Source string.
/// - Parameter right: Other string.
/// https://github.com/apple/swift/blob/9858f398320e70e357f636674845938b41d9290e/stdlib/public/core/StringComparable.swift#L93C3-L93C9
//public
//func ~= <S> (left: String, right: S) -> Bool where S: StringProtocol
//{
//    return left.contains(right)
//}

#if canImport(CoreLocation)

/// Check location is contain in circular region
/// - Parameter left: The circular region.
/// - Parameter right: Location.
public
func ~= (left: CLCircularRegion, right: CLLocation) -> Bool
{
    return left.contains(right.coordinate)
}

/// Check location of coordinate is contain in circular region
/// - Parameter left: The circular region.
/// - Parameter right: Location of coordinate.
public
func ~= (left: CLCircularRegion, right: CLLocationCoordinate2D) -> Bool
{
    return left.contains(right)
}

#endif

// MARK: - "==" -

public
func ==<L, R> (left: L?, right: R) -> Bool where R: RawRepresentable, R.RawValue: Equatable, R.RawValue == L
{
    guard let left: L = left else {
        
        return false
    }
    
    return left == right.rawValue
}

public
func ==<L, R> (left: L, right: R) -> Bool where R: RawRepresentable, R.RawValue: Equatable, R.RawValue == L
{
    left == right.rawValue
}

public
func ==<L, R> (left: L, right: R?) -> Bool where L: RawRepresentable, L.RawValue: Equatable, L.RawValue == R
{
    guard let right: R = right else {
        
        return false
    }
    
    return left.rawValue == right
}

public
func ==<L, R> (left: L, right: R) -> Bool where L: RawRepresentable, L.RawValue: Equatable, L.RawValue == R
{
    left.rawValue == right
}

// MARK: - "<=>" -

infix operator <=>

/// Check is same type
/// - Parameter left: Object.
/// - Parameter right: Other object.
public
func <=> <L, R> (left: L, right: R) -> Bool
{
    let result: Bool = (type(of: left) == type(of: right))
    
    return result
}

/// Check is same type
/// - Parameter left: Option object.
/// - Parameter right: Other object.
public
func <=> <L, R> (left: L?, right: R) -> Bool
{
    guard let unwrappedLeft = left else {
        
        return false
    }
    
    let result: Bool = (type(of: unwrappedLeft) == type(of: right))
    
    return result
}

/// Check is same type
/// - Parameter left: Object.
/// - Parameter right: Other option object.
public
func <=> <L, R> (left: L, right: R?) -> Bool
{
    guard let unwrappedRight = right else {
        
        return false
    }
    
    let result: Bool = (type(of: left) == type(of: unwrappedRight))
    
    return result
}

// MARK: - "<!>" -

infix operator <!>

/// Check is not same type
/// - Parameter left: Object.
/// - Parameter right: Other object.
public
func <!> <L, R> (left: L, right: R) -> Bool
{
    let result: Bool = (left <=> right)
    
    return !result
}

/// Check is not same type
/// - Parameter left: Option object.
/// - Parameter right: Other object.
public
func <!> <L, R> (left: L?, right: R) -> Bool
{
    let result: Bool = (left <=> right)
    
    return !result
}

/// Check is not same type
/// - Parameter left: Object.
/// - Parameter right: Other option object.
public
func <!> <L, R> (left: L, right: R?) -> Bool
{
    let result: Bool = (left <=> right)
    
    return !result
}
