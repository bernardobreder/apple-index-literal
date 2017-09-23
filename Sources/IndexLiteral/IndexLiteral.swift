//
//  IndexLiteral.swift
//  Literal
//
//  Created by Bernardo Breder on 09/01/17.
//
//

import Foundation

public enum IndexLiteralType {
    case string
    case int
}

public struct IndexLiteral {
    
    public let type: IndexLiteralType
    
    public let value: Any
    
    public init(_ string: String) {
        self.type = .string
        self.value = string
    }
    
    public init(_ int: Int) {
        self.type = .int
        self.value = int
    }
    
    public init(any: String) {
        if let int = Int(any) { self.init(int) }
        else { self.init(any) }
    }
    
    public var string: String? {
        return type == .string ? value as? String : nil
    }
    
    public var int: Int? {
        return type == .int ? value as? Int : nil
    }
    
    public var isInt: Bool { return type == .int }
    
    public var isString: Bool { return type == .string }
    
    public func string(_ f: (String) -> Void) {
        if let string = self.string { f(string) }
    }
    
    public func int(_ f: (Int) -> Void) {
        if let int = self.int { f(int) }
    }
    
    public func literal(string: (String) -> Void, int: (Int) -> Void) {
        switch type {
        case .string: string(value as! String)
        case .int: int(value as! Int)
        }
    }
    
    public func literal<E>(string: (String) -> E, int: (Int) -> E) -> E {
        switch type {
        case .string: return string(value as! String)
        case .int: return int(value as! Int)
        }
    }
    
}

extension IndexLiteral {
    
    public init(encoded: String) throws {
        guard let c = encoded.characters.first else { throw IndexLiteralError.decodeEmpty }
        let string = encoded.substring(from: encoded.index(after: encoded.startIndex))
        switch c {
        case "S":
            self.init(string)
        case "I":
            guard let int = Int(string) else { throw IndexLiteralError.decodeInt(string) }
            self.init(int)
        default:
            throw IndexLiteralError.decodeUnknown(c, string)
        }
    }
    
    public func encode() -> String {
        switch type {
        case .string:
            return "S" + (value as! String)
        case .int:
            return "I" + String(value as! Int)
        }
    }
    
}

extension IndexLiteral: ExpressibleByStringLiteral, ExpressibleByIntegerLiteral {
    
    public init(stringLiteral value: StringLiteralType) {
        self.init(value)
    }
    
    public init(extendedGraphemeClusterLiteral value: StringLiteralType) {
        self.init(value)
    }
    
    public init(unicodeScalarLiteral value: StringLiteralType) {
        self.init(value)
    }
    
    public init(integerLiteral value: IntegerLiteralType) {
        self.init(value)
    }
    
}

extension IndexLiteral: CustomStringConvertible, CustomDebugStringConvertible {
    
    public var description: String {
        switch type {
        case .string: return value as! String
        case .int: return String(value as! Int)
        }
    }
    
    public var debugDescription: String {
        return description
    }
    
}

extension IndexLiteral: Hashable {
    
    public static func ==(lhs: IndexLiteral, rhs: IndexLiteral) -> Bool {
        switch (lhs.type, rhs.type) {
        case (.string, .string):
            return lhs.string == rhs.string
        case (.int, .int):
            return lhs.int == rhs.int
        default:
            return false
        }
    }
    
    public var hashValue: Int {
        switch (type) {
        case .string:
            return (value as! String).hash
        case .int:
            return value as! Int
        }
    }
    
}

public enum IndexLiteralError: Error {
    case decodeEmpty
    case decodeInt(String)
    case decodeUnknown(Character, String)
}
