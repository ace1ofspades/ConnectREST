//
//  BaseConnect.swift
//  ConnectRest Example
//
//  Created by Yusuf Tekin on 12.07.2023.
//

import Foundation
import ConnectREST

class BaseConnect:Connect {
    var tokenRequired:Bool = false
    override func configure() {
        if tokenRequired {
            authorization = "Bearer JWT"
        }
    }
}
