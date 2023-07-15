//
//  File.swift
//
//
//  Created by Yusuf Tekin on 15.07.2023.
//

import Foundation

class DebugPrint {
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
