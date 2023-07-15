//
//  BaseConnect.swift
//  ConnectRest Example
//
//  Created by Yusuf Tekin on 12.07.2023.
//

import ConnectREST
import Foundation

class BaseConnect: Connect {
    var tokenRequired = false
    override func configure() {
        super.configure()
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")

        if tokenRequired {
            request.setValue("Bearer JWT Token", forHTTPHeaderField: "Authorization")
        }
    }
}
