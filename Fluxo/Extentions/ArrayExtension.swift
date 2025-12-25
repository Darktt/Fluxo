//
//  ArrayExtension.swift
//
//  Created by Darktt on 15/10/15.
//  Copyright © 2015 Darktt. All rights reserved.
//

import Foundation

public 
extension Array
{
    typealias ReturnType = (element: Element, offset: Index)
    
    // MARK: - Properties -
    
    // MARK: - Methods -
    
    init<Input>(_ expression: (Input) -> Element, forIn inputs: any Sequence<Input>, if condition: ((Input) -> Bool)? = nil)
    {
        self = inputs.compactMap {
            
            if let condition = condition, !condition($0) {
                
                return nil
            }
            
            let element: Element = expression($0)
            
            return element
        }
    }
    
    subscript(index: UInt) -> Element
    {
        let _index = Int(index)
        
        return self[_index]
    }
    
    subscript<RawIndex>(index: RawIndex) -> Element where RawIndex: RawRepresentable, RawIndex.RawValue == Index
    {
        return self[index.rawValue]
    }
    
    func object<R>(at index: R) -> Element? where R: RawRepresentable, R.RawValue == Index
    {
        self.object(at: index.rawValue)
    }
    
    func object(at index: Array.Index) -> Element?
    {
        guard index < self.count else {
            
            return nil
        }
        
        let element: Element = self[index]
        
        return element
    }
    
    func object(at index: Array.Index) -> ReturnType
    {
        let count: Int = self.count
        var index: Int = index
        
        while index < 0 {
            
            index += count
        }
        
        let offset: Int = abs(index) / count
        index = index % count
        
        let object = self[index]
        
        return (object, offset)
    }
    
    func step(_ stride: Index) -> Array<Element>
    {
        let strideTo: StrideTo<Index> = Swift.stride(from: 0, to: self.count, by: stride)
        let newArray: Array<Element> = strideTo.map { self[$0] }
        
        return newArray
    }
    
    func chunked(by chunkSize: Int) -> Array<Array<Element>>
    {
        let strideTo: StrideTo<Index> = Swift.stride(from: 0, to: self.count, by: chunkSize)
        let result: Array<Array<Element>> = strideTo.map {
            
            Array(self[$0 ..< Swift.min($0 + chunkSize, self.count)])
        }
        
        return result
    }
    
#if canImport(UIKit)
    
    func element(for indexPath: IndexPath) -> Element
    {
        let index: Int = indexPath.row
        let element: Element = self[index]
        
        return element
    }
    
#endif
    
    func counted(for isIncluded: (Element) throws -> Bool) rethrows -> Int
    {
        let count: Int = try self.filter(isIncluded).count
        
        return count
    }
    
    func first<CastType>(is class: CastType.Type) -> CastType?
    {
        let firstElement = self.first(where: { $0 is CastType }) as? CastType
        
        return firstElement
    }
    
    func first<CastType>(as: CastType.Type, where predicate: (CastType) throws -> Bool) rethrows -> CastType?
    {
        let firstElement = try self.first {
            
            guard let castType = $0 as? CastType else {
                
                return false
            }
            
            let result: Bool = try predicate(castType)
            
            return result
        } as? CastType
        
        return firstElement
    }
    
    // Get new filtered array by exclude value for specified times.
    func filter<Exclude>(excludeBy exclude: Exclude, byCount count: Int, keyPath: KeyPath<Element, Exclude>) -> [Element] where Exclude: Equatable
    {
        var count: Int = count
        let result: [Element] = self.compactMap {
            
            guard ($0[keyPath: keyPath] == exclude) && (count > 0) else {
                
                return $0
            }
            
            count -= 1
            
            return nil
        }
        
        return result
    }
    
    func filter<Exclude>(excludeBy exclude: Exclude, byCount count: Int, keyPath: KeyPath<Element, Exclude?>) -> [Element] where Exclude: Equatable
    {
        var count: Int = count
        let result: [Element] = self.compactMap {
            
            guard ($0[keyPath: keyPath] == exclude) && (count > 0) else {
                
                return $0
            }
            
            count -= 1
            
            return nil
        }
        
        return result
    }
    
    func filter<Exclude>(excludeBy exclude: Exclude, byCount count: Int, comparison: (Element) -> Exclude) -> [Element] where Exclude: Equatable
    {
        var count: Int = count
        let result: [Element] = self.compactMap {
            
            let compareTarget: Exclude = comparison($0)
            guard (compareTarget == exclude) && (count > 0) else {
                
                return $0
            }
            
            count -= 1
            
            return nil
        }
        
        return result
    }
    
    mutating
    func filtered(isIncluded: (Element) -> Bool)
    {
        let filtered: Array<Element> = self.filter(isIncluded)
        
        self = filtered
    }
    
    func forEach(body: (Element, inout Bool) -> Void)
    {
        var isBreak: Bool  = false
        
        for element in self {
            
            body(element, &isBreak)
            
            if isBreak {
                
                break
            }
        }
    }
    
    func forEach<CastType>(is: CastType.Type, body: (CastType) -> Void)
    {
        self.forEach {
            
            guard let castType = $0 as? CastType else {
                
                return
            }
            
            body(castType)
        }
    }
}

#if canImport(UIKit)

public 
extension Array where Element: RandomAccessCollection, Element.Index == Int
{
    subscript(index: Index, innerIndex: Element.Index) -> Element.Element
    {
        let element: Element = self[index]
        let innerElement: Element.Element = element[innerIndex]
        
        return innerElement
    }
    
    func element(for indexPath: IndexPath) -> Element.Element
    {
        let section: Int = indexPath.section
        let row: Int = indexPath.row
        let element: Element = self[section]
        let innerElement: Element.Element = element[row]
        
        return innerElement
    }
}

#endif

public 
extension Array where Element == UInt8
{
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
    
    var utf8: String? {
        
        let data = Data(self)
        let string = String(data: data, encoding: .utf8)
        
        return string
    }
}

public 
extension Array where Element: Any
{
    /**
     Filter array via predicate.
     
     - parameter predicate: The predicate to filter array.
     
     - throws: The error of ArrayError enumerator.
     
     - returns: Filtered array.
     */
    func filteredArray(predicate: NSPredicate) throws -> Array<Element>
    {
        guard self.count != 0 else {
            return []
        }
        
        let filteredArray: Array<Element> = self.compactMap { predicate.evaluate(with: $0) ? $0 : nil }
        
        return filteredArray
    }
    
    mutating
    func exchange(from fromIndex: Int, to toIndex: Int)
    {
        let element: Element = self.remove(at: fromIndex)
        self.insert(element, at: toIndex)
    }
}

public 
extension Array where Element: Equatable
{
    func contains(otherArray: Array<Element>) -> Bool
    {
        let result: Bool = self.contains(where: otherArray.contains)
        
        return result
    }
    
    func filter(exclude element: Element, byCount count: Int) -> [Element]
    {
        var count: Int = count
        let result: [Element] = self.compactMap {
            
            guard ($0 == element) && (count > 0) else {
                
                return $0
            }
            
            count -= 1
            
            return nil
        }
        
        return result
    }
}

public 
extension Array where Element: Comparable
{
    func contains(otherArray: Array<Element>) -> Bool
    {
        let current: Array = self.sorted()
        let other: Array = otherArray.sorted()
        
        let result: Bool = current.contains(where: other.contains)
        
        return result
    }
}

public 
extension Array where Element: Hashable
{
    func union<S>(_ other: S) -> Array<Element> where Element == S.Element, S : Sequence
    {
        let selfSet: Set<Element> = Set(self)
        let resultSet: Set<Element> = selfSet.union(other)
        let unionArray: Array<Element> = Array(resultSet)
        
        return unionArray
    }
    
    mutating
    func formUnion<S>(_ other: S) where Element == S.Element, S : Sequence
    {
        self = self.union(other)
    }
    
    func intersection<S>(_ other: S) -> Array<Element> where Element == S.Element, S : Sequence
    {
        let selfSet: Set<Element> = Set(self)
        let resultSet: Set<Element> = selfSet.intersection(other)
        let intersectionArray: Array<Element> = Array(resultSet)
        
        return intersectionArray
    }
    
    mutating
    func formIntersection<S>(_ other: S) where Element == S.Element, S : Sequence
    {
        self = self.intersection(other)
    }
    
    func subtracting<S>(_ other: S) -> Array<Element> where Element == S.Element, S : Sequence
    {
        let selfSet: Set<Element> = Set(self)
        let resultSet: Set<Element> = selfSet.subtracting(other)
        let subtractingArray: Array<Element> = Array(resultSet)
        
        return subtractingArray
    }
    
    mutating
    func subtract<S>(_ other: S) where Element == S.Element, S : Sequence
    {
        self = self.subtracting(other)
    }
}

extension Array where Element: RawRepresentable, Element.RawValue: StringProtocol
{
    var stringValues: [Element.RawValue] {
        
        let result: [Element.RawValue] = self.map({ $0.rawValue })
        
        return result
    }
}

extension Array where Element: RawRepresentable, Element.RawValue: Equatable
{
    func contains(_ element: Element.RawValue) -> Bool
    {
        self.contains(where: { $0.rawValue == element })
    }
}

// MARK: - Remove object -

public 
extension Array {
    
    /// Remove duplicate elements
    mutating
    func removeDuplicate<Hash>(_ transform: (Element) -> Hash) where Hash: Hashable {
        
        var hashSet = Set<Hash>()
        self = self.compactMap {
            
            element -> Element? in
            
            let hashValue: Hash = transform(element)
            
            guard !hashSet.contains(hashValue) else {
                
                return nil
            }
            
            hashSet.insert(hashValue)
            
            return element
        }
    }
}

public 
extension RangeReplaceableCollection where Iterator.Element : Equatable
{
    /// Replace **object** to **another object**.
    mutating
    func replace(from: Iterator.Element, to: Iterator.Element)
    {
        guard let index: Index = self.firstIndex(of: from) else {
            
            return
        }
        
        self.remove(at: index)
        self.insert(to, at: index)
    }
    
    /// Remove first collection elements by other collection
    mutating
    func remove<R>(by other: R) where R: RangeReplaceableCollection, R.Iterator == Iterator
    {
        other.forEach {
            
            self.remove(object: $0)
        }
    }
    
    /// Remove first collection element that is equal to the given **object**.
    @discardableResult mutating
    func remove(object: Iterator.Element) -> Bool
    {
        guard let index: Index = self.firstIndex(of: object) else {
            
            return false
        }
        
        self.remove(at: index)
        return true
    }
    
    /// Remove all given **object** in collection.
    mutating
    func removeAll(_ object: Iterator.Element)
    {
        self.removeAll(where: { $0 == object })
    }
    
    /// Remove all given **objects** in collection.
    mutating
    func removeAll<R>(_ objects: R) where R: RangeReplaceableCollection, R.Iterator == Iterator
    {
        guard !objects.isEmpty else {
            
            return
        }
        
        self.removeAll(where: { objects.contains($0) })
    }
}

// MARK: - Collection -

public 
extension Collection
{
    func element(at index: Index) -> Iterator.Element?
    {
        let element: Iterator.Element? = self.indices.contains(index) ? self[index] : nil
        
        return element
    }
    
    func groups(of number: Int) -> Array<SubSequence>
    {
        var startIndex: Index = self.startIndex
        
        let count: Int = self.count
        let maximum: Int = Int((Double(count) / Double(number)).rounded(.up))
        
        let groupedResult: Array<SubSequence> = (0 ..< maximum).map {
            
            _ in
            
            var endIndex = self.index(startIndex, offsetBy: number, limitedBy: self.endIndex) ?? self.endIndex
            
            let remain: Int = (count % number)
            let distance: Int = self.distance(from: self.startIndex, to: startIndex)
            
            if (remain > 0) && (distance > count) {
                
                endIndex = self.endIndex
            }
            
            let result: SubSequence = self[startIndex ..< endIndex]
            
            startIndex = endIndex
            
            return result
        }
        
        return groupedResult
    }
}

// MARK: - Sequence -

public 
extension Sequence
{
    func zip<S>(with otherSequence: S) -> Zip2Sequence<Self, S> where S: Sequence
    {
        let zipSequence = Swift.zip(self, otherSequence)
        
        return zipSequence
    }
    
    func toDictionary<Key, Value>(with selectKey: (Iterator.Element) -> (key: Key, value: Value)) -> Dictionary<Key, Value> where Key: Hashable
    {
        var dictionary: Dictionary<Key, Value> = [:]
        
        self.forEach {
            
            let result = selectKey($0)
            
            dictionary[result.key] = result.value
        }
        
        return dictionary
    }
    
    func filter<Value>(by keyPath: KeyPath<Element, Value>, isIncluded: (Value) throws -> Bool) rethrows -> Array<Element> {
        
        let filter: Array<Element> = try self.filter {
            
            let value: Value = $0[keyPath: keyPath]
            let result: Bool = try isIncluded(value)
            
            return result
        }
        
        return filter
    }
    
    func sorted<Element>(by keyPath: KeyPath<Self.Element, Element>, increasingOrder: (Element, Element) throws -> Bool) rethrows -> Array<Self.Element>
    {
        let sortedResult: Array<Self.Element> = try self.sorted(by: {
            
            let first: Element = $0[keyPath: keyPath]
            let second: Element = $1[keyPath: keyPath]
            let result: Bool = try increasingOrder(first, second)
            
            return result
        })
        
        return sortedResult
    }
}

public 
extension Sequence where Iterator.Element == Dictionary<String, Any>
{
    func flatMapValues<ValueType>(as type: ValueType.Type) -> [ValueType]
    {
        let result = self.flatMap({ $0.values.compactMap({ $0 as? ValueType }) })
        
        return result
    }
    
    func flatMapValues<ValueType>(_ transform: (Iterator.Element.Values) -> [ValueType]) -> [ValueType]
    {
        let result: [ValueType] = self.flatMap {
            
            transform($0.values)
        }
        
        return result
    }
}

// MARK: - MutableCollection -

public 
extension MutableCollection {
    
    mutating
    func mutateForEach(_ body: (inout Element) throws -> Void) rethrows
    {
        for index in self.indices {
            
            var element: Element = self[index]
            
            try body(&element)
            
            self[index] = element
        }
    }
}

public 
extension MutableCollection where Self: RandomAccessCollection
{
    mutating
    func sort<Element>(by keyPath: KeyPath<Self.Element, Element>, increasingOrder: (Element, Element) throws -> Bool) rethrows
    {
        try self.sort(by: {
            
            let first: Element = $0[keyPath: keyPath]
            let second: Element = $1[keyPath: keyPath]
            let result: Bool = try increasingOrder(first, second)
            
            return result
        })
    }
}
