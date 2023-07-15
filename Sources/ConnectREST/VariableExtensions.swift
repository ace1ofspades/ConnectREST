//
//  File.swift
//  
//
//  Created by Yusuf Tekin on 15.07.2023.
//

import Foundation

infix operator =>

public func => <T>(left: inout T?, right: Any?) {
    if let result = right as? T {
        left = result
        return
    }
    
    switch T.self {
    case is MapStruct.Type:
        left = (T.self as? MapStruct.Type)?.init(right) as? T
        break
    case is Codable.Type:
        let classType = T.self as! Codable.Type
        let result = classType => right
        left = result as? T
        break
    default:
        break
    }
}

public func => <T:Codable>(left: T.Type, right: Any?) -> T? {
    if let object = right as? [String: Any] {
        if let data = try? JSONSerialization.data(withJSONObject: object),
           let decoded = try? JSONDecoder().decode(left, from: data) {
            return decoded
        }
    } else if let data = right as? Data {
        if let decoded = try? JSONDecoder().decode(left, from: data) {
            return decoded
        }
    } else if let result = right as? T {
        return result
    }
    return nil
}
