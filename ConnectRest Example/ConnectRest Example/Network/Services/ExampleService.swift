//
//  ExampleService.swift
//  ConnectRest Example
//
//  Created by Yusuf Tekin on 12.07.2023.
//

import Foundation

class TestService {
    class SignUp: BaseConnect {
        var username: String?
        var fullname: String?
        var email: String?
        var birthday: String?
        var countryCode: Int?
        init() {
            super.init(Path: "/api/test", Method: .post)
            tokenRequired = false
        }

    }
}
