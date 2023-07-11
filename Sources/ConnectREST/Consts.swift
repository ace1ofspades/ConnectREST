//
//  File.swift
//  
//
//  Created by Yusuf Tekin on 11.07.2023.
//

import Foundation


public var baseURL = ""
private var sharedSession: URLSession?

public var sharedURLSession: URLSession {
    if let session = sharedSession {
        return session
    } else {
        let session = URLSession.shared
        sharedSession = session
        return session
    }
}
