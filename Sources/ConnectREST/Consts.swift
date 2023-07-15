//
//  File.swift
//  
//
//  Created by Yusuf Tekin on 11.07.2023.
//

import Foundation


var baseURL = ""

private var sharedSession: URLSession?
var sharedURLSession: URLSession {
    if let session = sharedSession {
        return session
    } else {
        let session = URLSession.shared
        sharedSession = session
        return session
    }
}
