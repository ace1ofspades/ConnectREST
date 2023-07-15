//
//  BaseConnect.swift
//  ConnectRest Example
//
//  Created by Yusuf Tekin on 12.07.2023.
//

import Foundation
import ConnectREST

class BaseConnect: Connect {
    var tokenRequired = false
    override func configure() {
        super.configure()
        contentType = "application/json"
        accept = "application/json"
        authorization = tokenRequired ? "Bearer JWT Token" : nil
    }
}

