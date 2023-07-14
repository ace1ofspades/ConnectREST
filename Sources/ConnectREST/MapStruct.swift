//
//  File 3.swift
//  
//
//  Created by Yusuf Tekin on 14.07.2023.
//

import Foundation


open class MapStruct {
    var parameters: [String: Any] = [:]
    subscript(key: String) -> Any? {
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
}
