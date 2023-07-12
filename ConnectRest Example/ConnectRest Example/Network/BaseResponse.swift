//
//  BaseResponse.swift
//  ConnectRest Example
//
//  Created by Yusuf Tekin on 12.07.2023.
//

import ConnectREST
import Foundation

class BaseResponse: JsonStruct {
    var error: String?
    var message: String?
    var success: Bool?

    override init(Data data: Data?) {
        super.init(Data: data)
    }
}
