//
//  File.swift
//  
//
//  Created by Yusuf Tekin on 11.07.2023.
//

import Foundation

infix operator =>

public func => <T>(left: inout T?, right: Any?) {
    left = right as? T
}

public func => <T>(left: inout T, right: Any?) {
    if right is T {
        left = right as! T
    }
}
