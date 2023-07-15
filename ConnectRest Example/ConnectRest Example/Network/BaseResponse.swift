//
//  BaseResponse.swift
//  ConnectRest Example
//
//  Created by Yusuf Tekin on 12.07.2023.
//

import ConnectREST
import Foundation

struct BaseResponse<T: Codable>: Codable {
    
    var data: T?
    var success: Bool?
    
    init(_ data: Data?) {
        if let data = data,
           let result = try? JSONDecoder().decode(BaseResponse<T>.self, from: data) {
            self.data = result.data
            self.success = result.success
        }
    }
}



class BaseResponseClass<T>: MapStruct {
    var data: T?
    var success: Bool?
    required init(_ object: Any?) {
        super.init(object)
        data => self["data"]
        success => self["success"]
    }
}
