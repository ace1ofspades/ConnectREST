//
//  LoginResponseDto.swift
//  ConnectRest Example
//
//  Created by Yusuf Tekin on 15.07.2023.
//

import Foundation
import MapStruct

class LoginDtoClass: MapStruct {
    var token: String?
    required init(_ object: Any?) {
        super.init(object)
        token => self["token"]
    }
}

struct LoginDto: Codable {
    var token: String?
}
