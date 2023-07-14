//
//  File.swift
//  
//
//  Created by Yusuf Tekin on 14.07.2023.
//

import Foundation



public struct EncodeAny: Encodable {
    public var value: Any?
    public init<T>(_ value: T?) {
        self.value = value ?? ()
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        
            print(container.codingPath)
        switch value {
        case is NSNull:
            try container.encodeNil()
        case is Void:
            try container.encodeNil()
        case let encoded as Bool:
            try container.encode(encoded)

        case let encoded as Int:
            try container.encode(encoded)

        case let encoded as Int8:
            try container.encode(encoded)

        case let encoded as Int16:
            try container.encode(encoded)

        case let encoded as Int32:
            try container.encode(encoded)

        case let encoded as Int64:
            try container.encode(encoded)

        case let encoded as UInt:
            try container.encode(encoded)

        case let encoded as UInt8:
            try container.encode(encoded)

        case let encoded as UInt16:
            try container.encode(encoded)

        case let encoded as UInt32:
            try container.encode(encoded)

        case let encoded as UInt64:
            try container.encode(encoded)

        case let encoded as Float:
            try container.encode(encoded)

        case let encoded as Double:
            try container.encode(encoded)

        case let encoded as String:
            try container.encode(encoded)

        case let encoded as DecodeAny?:
            try container.encode(EncodeAny(encoded?.value))
            
        case let encoded as [Any?]:
            try container.encode(encoded.map { EncodeAny($0) })

        case let encoded as [String: Any?]:
            try container.encode(encoded.mapValues { EncodeAny($0) })

        case let encoded as Encodable:
            try encoded.encode(to: encoder)

        default:
            let context = EncodingError.Context(codingPath: container.codingPath, debugDescription: "EncodeAny value cannot be encoded")
            throw EncodingError.invalidValue(value, context)
        }
    }

}
