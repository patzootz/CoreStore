//
//  CoreStoreQueryableAttributeType.swift
//  CoreStore
//
//  Copyright © 2017 John Rommel Estropia
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//

import Foundation
import CoreGraphics
import CoreData


// MARK: - CoreStoreQueryableAttributeType

public protocol CoreStoreQueryableAttributeType: Hashable {
    
    associatedtype QueryableNativeType: CoreDataNativeType
    
    static var cs_rawAttributeType: NSAttributeType { get }
    
    @inline(__always)
    static func cs_fromQueryableNativeType(_ value: QueryableNativeType) -> Self?
    
    @inline(__always)
    func cs_toQueryableNativeType() -> QueryableNativeType
}


//// MARK: - NSManagedObject
//
//extension NSManagedObject: CoreStoreQueryableAttributeType {
//    
//    public typealias QueryableNativeType = NSManagedObjectID
//    
//    public static let cs_rawAttributeType: NSAttributeType = .objectIDAttributeType
//    
//    @inline(__always)
//    public func cs_toQueryableNativeType() -> QueryableNativeType {
//        
//        return self.objectID
//    }
//}


// MARK: - NSManagedObjectID

extension NSManagedObjectID: CoreStoreQueryableAttributeType {
    
    public typealias QueryableNativeType = NSManagedObjectID
    
    public static let cs_rawAttributeType: NSAttributeType = .objectIDAttributeType
    
    @nonobjc @inline(__always)
    public class func cs_fromQueryableNativeType(_ value: QueryableNativeType) -> Self? {
        
        func forceCast<T: NSManagedObjectID>(_ value: Any) -> T? {
            
            return value as? T
        }
        return forceCast(value)
    }
    
    @inline(__always)
    public func cs_toQueryableNativeType() -> QueryableNativeType {
        
        return self
    }
}


// MARK: - NSNumber

extension NSNumber: CoreStoreQueryableAttributeType {
    
    public typealias QueryableNativeType = NSNumber
    
    public class var cs_rawAttributeType: NSAttributeType {
        
        return .integer64AttributeType
    }
    
    @nonobjc @inline(__always)
    public class func cs_fromQueryableNativeType(_ value: QueryableNativeType) -> Self? {
        
        func forceCast<T: NSNumber>(_ value: Any) -> T? {
            
            return value as? T
        }
        return forceCast(value)
    }
    
    public func cs_toQueryableNativeType() -> QueryableNativeType {
        
        return self
    }
}


// MARK: - NSNumber

extension NSDecimalNumber /*: CoreStoreQueryableAttributeType */ {
    
    public override class var cs_rawAttributeType: NSAttributeType {
        
        return .decimalAttributeType
    }
}


// MARK: - NSString

extension NSString: CoreStoreQueryableAttributeType {
    
    public typealias QueryableNativeType = NSString
    
    public static let cs_rawAttributeType: NSAttributeType = .stringAttributeType
    
    @nonobjc @inline(__always)
    public class func cs_fromQueryableNativeType(_ value: QueryableNativeType) -> Self? {
        
        func forceCast<T: NSString>(_ value: Any) -> T? {
            
            return value as? T
        }
        return forceCast(value)
    }
    
    @inline(__always)
    public func cs_toQueryableNativeType() -> QueryableNativeType {
        
        return self
    }
}


// MARK: - NSDate

extension NSDate: CoreStoreQueryableAttributeType {
    
    public typealias QueryableNativeType = NSDate
    
    public static let cs_rawAttributeType: NSAttributeType = .dateAttributeType
    
    @nonobjc @inline(__always)
    public class func cs_fromQueryableNativeType(_ value: QueryableNativeType) -> Self? {
        
        func forceCast<T: NSDate>(_ value: Any) -> T? {
            
            return value as? T
        }
        return forceCast(value)
    }
    
    @inline(__always)
    public func cs_toQueryableNativeType() -> QueryableNativeType {
        
        return self
    }
}


// MARK: - NSData

extension NSData: CoreStoreQueryableAttributeType {
    
    public typealias QueryableNativeType = NSData
    
    public static let cs_rawAttributeType: NSAttributeType = .binaryDataAttributeType
    
    @nonobjc @inline(__always)
    public class func cs_fromQueryableNativeType(_ value: QueryableNativeType) -> Self? {
        
        func forceCast<T: NSData>(_ value: Any) -> T? {
            
            return value as? T
        }
        return forceCast(value)
    }
    
    @inline(__always)
    public func cs_toQueryableNativeType() -> QueryableNativeType {
        
        return self
    }
}


// MARK: - Bool

extension Bool: CoreStoreQueryableAttributeType {
    
    public typealias QueryableNativeType = NSNumber
    
    public static let cs_rawAttributeType: NSAttributeType = .booleanAttributeType
    
    @inline(__always)
    public static func cs_fromQueryableNativeType(_ value: QueryableNativeType) -> Bool? {
        
        switch value {
            
        case let decimal as NSDecimalNumber:
            // iOS: NSDecimalNumber(string: "0.5").boolValue // true
            // OSX: NSDecimalNumber(string: "0.5").boolValue // false
            return NSNumber(value: decimal.doubleValue).boolValue
            
        default:
            return value.boolValue
        }
    }
    
    @inline(__always)
    public func cs_toQueryableNativeType() -> QueryableNativeType {
        
        return self as NSNumber
    }
}


// MARK: - Int8

extension Int8: CoreStoreQueryableAttributeType {
    
    public typealias QueryableNativeType = NSNumber
    
    public static let cs_rawAttributeType: NSAttributeType = .integer16AttributeType
    
    @inline(__always)
    public static func cs_fromQueryableNativeType(_ value: QueryableNativeType) -> Int8? {
        
        return value.int8Value
    }
    
    @inline(__always)
    public func cs_toQueryableNativeType() -> QueryableNativeType {
        
        return self as NSNumber
    }
}


// MARK: - Int16

extension Int16: CoreStoreQueryableAttributeType {
    
    public typealias QueryableNativeType = NSNumber
    
    public static let cs_rawAttributeType: NSAttributeType = .integer16AttributeType
    
    @inline(__always)
    public static func cs_fromQueryableNativeType(_ value: QueryableNativeType) -> Int16? {
        
        return value.int16Value
    }
    
    @inline(__always)
    public func cs_toQueryableNativeType() -> QueryableNativeType {
        
        return self as NSNumber
    }
}


// MARK: - Int32

extension Int32: CoreStoreQueryableAttributeType {
    
    public typealias QueryableNativeType = NSNumber
    
    public static let cs_rawAttributeType: NSAttributeType = .integer32AttributeType
    
    @inline(__always)
    public static func cs_fromQueryableNativeType(_ value: QueryableNativeType) -> Int32? {
        
        return value.int32Value
    }
    
    @inline(__always)
    public func cs_toQueryableNativeType() -> QueryableNativeType {
        
        return self as NSNumber
    }
}


// MARK: - Int64

extension Int64: CoreStoreQueryableAttributeType {
    
    public typealias QueryableNativeType = NSNumber
    
    public static let cs_rawAttributeType: NSAttributeType = .integer64AttributeType
    
    @inline(__always)
    public static func cs_fromQueryableNativeType(_ value: QueryableNativeType) -> Int64? {
        
        return value.int64Value
    }
    
    @inline(__always)
    public func cs_toQueryableNativeType() -> QueryableNativeType {
        
        return self as NSNumber
    }
}


// MARK: - Int

extension Int: CoreStoreQueryableAttributeType {
    
    public typealias QueryableNativeType = NSNumber
    
    public static let cs_rawAttributeType: NSAttributeType = .integer64AttributeType
    
    @inline(__always)
    public static func cs_fromQueryableNativeType(_ value: QueryableNativeType) -> Int? {
        
        return value.intValue
    }
    
    @inline(__always)
    public func cs_toQueryableNativeType() -> QueryableNativeType {
        
        return self as NSNumber
    }
}


// MARK: - Double

extension Double: CoreStoreQueryableAttributeType {
    
    public typealias QueryableNativeType = NSNumber
    
    public static let cs_rawAttributeType: NSAttributeType = .doubleAttributeType
    
    @inline(__always)
    public static func cs_fromQueryableNativeType(_ value: QueryableNativeType) -> Double? {
        
        return value.doubleValue
    }
    
    @inline(__always)
    public func cs_toQueryableNativeType() -> QueryableNativeType {
        
        return self as NSNumber
    }
}


// MARK: - Float

extension Float: CoreStoreQueryableAttributeType {
    
    public typealias QueryableNativeType = NSNumber
    
    public static let cs_rawAttributeType: NSAttributeType = .floatAttributeType
    
    @inline(__always)
    public static func cs_fromQueryableNativeType(_ value: QueryableNativeType) -> Float? {
        
        return value.floatValue
    }
    
    @inline(__always)
    public func cs_toQueryableNativeType() -> QueryableNativeType {
        
        return self as NSNumber
    }
}


// MARK: - CGFloat

extension CGFloat: CoreStoreQueryableAttributeType {
    
    public typealias QueryableNativeType = NSNumber
    
    public static let cs_rawAttributeType: NSAttributeType = .doubleAttributeType
    
    @inline(__always)
    public static func cs_fromQueryableNativeType(_ value: QueryableNativeType) -> CGFloat? {
        
        return CGFloat(value.doubleValue)
    }
    
    @inline(__always)
    public func cs_toQueryableNativeType() -> QueryableNativeType {
        
        return self as NSNumber
    }
}


// MARK: - Date

extension Date: CoreStoreQueryableAttributeType {
    
    public typealias QueryableNativeType = NSDate
    
    public static let cs_rawAttributeType: NSAttributeType = .dateAttributeType
    
    @inline(__always)
    public static func cs_fromQueryableNativeType(_ value: QueryableNativeType) -> Date? {
        
        return value as Date
    }
    
    @inline(__always)
    public func cs_toQueryableNativeType() -> QueryableNativeType {
        
        return self as NSDate
    }
}


// MARK: - String

extension String: CoreStoreQueryableAttributeType {
    
    public typealias QueryableNativeType = NSString
    
    public static let cs_rawAttributeType: NSAttributeType = .stringAttributeType
    
    @inline(__always)
    public static func cs_fromQueryableNativeType(_ value: QueryableNativeType) -> String? {
        
        return value as String
    }
    
    @inline(__always)
    public func cs_toQueryableNativeType() -> QueryableNativeType {
        
        return self as NSString
    }
}


// MARK: - Data

extension Data: CoreStoreQueryableAttributeType {
    
    public typealias QueryableNativeType = NSData
    
    public static let cs_rawAttributeType: NSAttributeType = .binaryDataAttributeType
    
    @inline(__always)
    public static func cs_fromQueryableNativeType(_ value: QueryableNativeType) -> Data? {
        
        return value as Data
    }
    
    @inline(__always)
    public func cs_toQueryableNativeType() -> QueryableNativeType {
        
        return self as NSData
    }
}


// MARK: - NSNull

extension NSNull: CoreStoreQueryableAttributeType {
    
    public typealias QueryableNativeType = NSNull
    
    public static let cs_rawAttributeType: NSAttributeType = .undefinedAttributeType
    
    @inline(__always)
    public static func cs_fromQueryableNativeType(_ value: QueryableNativeType) -> Self? {
        
        return self.init()
    }
    
    @inline(__always)
    public func cs_toQueryableNativeType() -> QueryableNativeType {
        
        return self
    }
}
