//
//  File.swift
//
//
//  Created by Yusuf Tekin on 11.07.2023.
//

import Foundation

/// - The `baseURL` variable is a global variable that holds the base URL for the requests. It is initially an empty string, and its value can be set or retrieved as needed.
var baseURL = ""

/// - The `sharedSession` private variable is an optional `URLSession` instance that holds a shared session for network requests. It is initially `nil`.
private var sharedSession: URLSession?

/**
 - The `sharedURLSession` computed property is used to access the shared session. It returns the shared session if it already exists, or creates a new `URLSession.shared` session and assigns it to `sharedSession` before returning it.

 Here's a breakdown of the code:

 1. When accessing the `sharedURLSession` property, it checks if `sharedSession` already contains a session. If it does, it returns the existing session.

 2. If `sharedSession` is `nil`, it means there is no shared session yet. In this case, it creates a new `URLSession.shared` session and assigns it to `sharedSession`.

 3. Finally, it returns the shared session.

 The purpose of this code is to provide a shared `URLSession` instance for making network requests. It ensures that only one session is created and shared across the application, promoting efficiency and reusability.

 */
var sharedURLSession: URLSession {
    if let session = sharedSession {
        return session
    } else {
        let session = URLSession.shared
        sharedSession = session
        return session
    }
}
