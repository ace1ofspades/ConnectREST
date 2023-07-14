//
//  File.swift
//  
//
//  Created by Yusuf Tekin on 14.07.2023.
//

import Foundation

@dynamicMemberLookup
open class Json: MapStruct {
    public subscript(dynamicMember key: String) -> Any? {
        get {
            return parameters[key]
        }
        set {
            parameters[key] = newValue
        }
    }
}
