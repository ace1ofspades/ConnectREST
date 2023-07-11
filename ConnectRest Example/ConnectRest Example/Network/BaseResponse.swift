//
//  BaseResponse.swift
//  ConnectRest Example
//
//  Created by Yusuf Tekin on 12.07.2023.
//

import Foundation
import ConnectREST

class BaseResponse: JsonStruct {
    @objc var birthday: String?
    @objc var birthday2: String!
    var birthday3: Int?
    override init(Data data: Data?) {
        super.init(Data: data)
        birthday2 => parameters["birthday"]
        birthday3 => parameters["birthday"]
    }
}
