//
//  File.swift
//  
//
//  Created by Yusuf Tekin on 15.07.2023.
//

import Foundation

extension URLResponse {
    public var statusCode: Int? {
        if let response = self as? HTTPURLResponse {
            let statusCode: Int = response.statusCode
            return statusCode
        }
        return nil
    }
}
