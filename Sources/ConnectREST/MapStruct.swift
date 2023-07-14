//
//  File 3.swift
//  
//
//  Created by Yusuf Tekin on 14.07.2023.
//

import Foundation


open class MapStruct: Codable {
    var parameters: [String: Any] = [:]
    public subscript(key: String) -> Any? {
        get {
            if let any = parameters[key] as? DecodeAny {
                return any.value
            }
            return parameters[key]
        }
        set {
            parameters[key] = newValue
        }
    }

    public required init(_ object: Any?) {
        if let param = object as? [String: Any] {
            parameters = param
        } else if let data = object as? Data {
            parameters = (try? JSONSerialization.jsonObject(with: data) as? [String: Any]) ?? [:]
        }
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()

        if let dictionary = try? container.decode([String: DecodeAny].self) {
            self.parameters = dictionary
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = try encoder.singleValueContainer()
        try? container.encode(EncodeAny(parameters))
        
    }
}
