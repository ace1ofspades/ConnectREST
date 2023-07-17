//
//  File.swift
//
//
//  Created by Yusuf Tekin on 15.07.2023.
//

import Foundation

/**
 The provided code defines a `DebugPrint` class with a static method `defaultPrint`. This method is used to generate a formatted string that contains debug information about a network request, response, and error.

 Here's a breakdown of the code:

 1. The `defaultPrint` method takes four parameters: `request` (URLRequest), `data` (optional Data), `response` (optional URLResponse), and `error` (optional Error). These parameters represent the components of a network interaction.

 2. The method returns a formatted string that includes the following information:
    - Path: The relative path of the URL in the request.
    - URL: The absolute string representation of the URL in the request.
    - Status Code: The HTTP status code of the response.
    - Request: A pretty-formatted description of the HTTP body data in the request.
    - Response: A pretty-formatted description of the data received in the response.
    - Error: The localized description of the error, if any.

 3. The string is constructed using string interpolation and includes relevant values from the request, response, and error objects.

 The purpose of this code is to provide a standardized way to print or log debug information about network interactions. It helps developers easily visualize and analyze the details of the request, response, and error during the debugging process.

 */
class DebugPrint {
    /// The `defaultPrint` method takes four parameters: `request` (URLRequest), `data` (optional Data), `response` (optional URLResponse), and `error` (optional Error). These parameters represent the components of a network interaction.
    static func defaultPrint(_ request: URLRequest, _ data: Data?, _ response: URLResponse?, _ error: Error?) -> String? {
        return """
        path -> \(request.url?.relativePath ?? "nil")

        url -> \(request.url?.absoluteString ?? "nil")

        status code -> \(response?.statusCode ?? 0)

        request ->
        \(request.httpBody?.prettyDescribing ?? "nil")

        response ->
        \(data?.prettyDescribing ?? "nil")

        error -> \(error?.localizedDescription ?? "nil")
        """
    }
}
