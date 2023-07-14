//
//  File 2.swift
//  
//
//  Created by Yusuf Tekin on 14.07.2023.
//

import Foundation

@propertyWrapper
public struct Map<T: MapStruct>: Codable {
    private var value: T?

    public var wrappedValue: T? {
        get { value }
        set { value = newValue }
    }

    public init(wrappedValue: T?) {
        self.wrappedValue = wrappedValue
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()

        if let dictionary = try? container.decode([String: DecodeAny].self) {
            wrappedValue = T(dictionary)
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = try encoder.singleValueContainer()
        try? container.encode(EncodeAny(value?.parameters))
        
    }
}
