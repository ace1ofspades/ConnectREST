//
//  File.swift
//
//
//  Created by Yusuf Tekin on 12.07.2023.
//

import Foundation

/**
 The provided code defines an enumeration called `HttpMethod` that represents different HTTP methods used in network requests.

 Here's a breakdown of the code:

 1. The `HttpMethod` enumeration is defined as a public enumeration, meaning it can be accessed from other parts of the code.

 2. The enumeration has four cases: `post`, `get`, `put`, and `patch`. Each case represents a specific HTTP method.

 3. Each case is associated with a raw value of type `String`, which corresponds to the actual HTTP method string used in network requests.

 The purpose of this code is to provide a convenient way to represent and work with different HTTP methods in network-related operations. By using the `HttpMethod` enumeration, you can easily specify the desired HTTP method for a request and ensure consistency and correctness in your code.

 Please let me know if you need further clarification or have additional questions!

 */
public enum HttpMethod: String {
    case post = "POST"
    case get = "GET"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}
