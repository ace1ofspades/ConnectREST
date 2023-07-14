//
//  File 2.swift
//  
//
//  Created by Yusuf Tekin on 14.07.2023.
//

import Foundation

@propertyWrapper
struct Map<T: MapStruct>: Codable {
    private var value: T?

    var wrappedValue: T? {
        get { value }
        set { value = newValue }
    }

    init(wrappedValue: T?) {
        self.wrappedValue = wrappedValue
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()

        if let dictionary = try? container.decode([String: DecodeAny].self) {
            wrappedValue = T(dictionary)
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = try encoder.singleValueContainer()
        print(value?.parameters)
        try? container.encode(EncodeAny(value?.parameters))
        
    }
}
