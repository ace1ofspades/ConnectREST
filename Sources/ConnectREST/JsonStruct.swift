//
//  File.swift
//  
//
//  Created by Yusuf Tekin on 11.07.2023.
//

import Foundation

class JsonStruct: NSObject {
    var parameters: [String: Any] = [:]
    init(Data data: Data?) {
        super.init()
        if let data = data {
            parameters = (try? JSONSerialization.jsonObject(with: data) as? [String: Any]) ?? [:]
            let mirror = Mirror(reflecting: self)
            for (name, _) in mirror.children {
                if let propertyName = name {
                    let parameterValue = parameters[propertyName]
                    setValue(parameterValue, forKey: propertyName)
                }
            }
        }
    }
}
