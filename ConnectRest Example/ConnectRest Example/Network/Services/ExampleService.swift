//
//  ExampleService.swift
//  ConnectRest Example
//
//  Created by Yusuf Tekin on 12.07.2023.
//

import Foundation

class ExampleService {
    class SignIn: BaseConnect {
        
        var email: String
        var password: String

        init(email: String, password: String) {
            self.email = email
            self.password = password
            super.init(Path: "/api/Auth/SignIn", Method: .post)
            tokenRequired = false
        }
    }
}
