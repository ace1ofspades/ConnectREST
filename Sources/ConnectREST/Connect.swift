//
//  File.swift
//  
//
//  Created by Yusuf Tekin on 7.07.2023.
//

import Foundation

public class Connect {
    public var session: URLSession!
    public var request: URLRequest!
    var task: URLSessionDataTask!

    public var contentType: String? {
        didSet {
            let key = "Content-Type"
            let value = contentType
            request.setValue(value, forHTTPHeaderField: key)
        }
    }

    public var accept: String? {
        didSet {
            let key = "Accept"
            let value = accept
            request.setValue(value, forHTTPHeaderField: key)
        }
    }

    public var acceptLanguage: String? {
        didSet {
            let key = "Accept-Language"
            let value = acceptLanguage
            request.setValue(value, forHTTPHeaderField: key)
        }
    }

    public var acceptCountry: String? {
        didSet {
            let key = "Accept-Country"
            let value = acceptCountry
            request.setValue(value, forHTTPHeaderField: key)
        }
    }

    public var authorization: String? {
        didSet {
            let key = "Authorization"
            let value = authorization
            request.setValue(value, forHTTPHeaderField: key)
        }
    }

    public func configure() {
    }

    public var jsonBody: [String: Any]? {
        if let data = request.httpBody {
            let json = try? JSONSerialization.jsonObject(with: data) as? Dictionary<String, Any>
            return json
        }
        return nil
    }

    init(Path path: String, Method method: HttpMethod = .get) {
        commonInit(Path: path, Method: method)
    }

    init(Path path: String, Method method: HttpMethod = .get, Parameters parameters: Data) {
        commonInit(Path: path, Method: method, Parameters: parameters)
    }

    init(Path path: String, Method method: HttpMethod = .get, Parameters parameters: Any) {
        let params = try? JSONSerialization.data(withJSONObject: parameters, options: [])
        commonInit(Path: path, Method: method, Parameters: params)
    }

    init(Path path: String, Method method: HttpMethod = .get, Parameters parameters: String, Encoding encoding: String.Encoding = .utf8) {
        let encoding = encoding
        let params = parameters.data(using: encoding)
        commonInit(Path: path, Method: method, Parameters: params)
    }

    private func commonInit(Path path: String, Method method: HttpMethod = .get, Parameters parameters: Data? = nil) {
        session = sharedURLSession
        request = URLRequest(url: URL(string: baseURL + path)!)
        task = session.dataTask(with: request)

        request.httpMethod = method.rawValue

        configure()

        if let parameters = parameters, method != .get {
            request.httpBody = parameters
        }
    }
}

extension Connect {
    public func connect(_ completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void, IncludeProperties includeProperties: Bool = true) {
        if includeProperties, request.httpMethod != HttpMethod.get.rawValue {
            var parameters: [String: Any]? = jsonBody ?? [:]
            let mirror = Mirror(reflecting: self)
            for (name, value) in mirror.children {
                if let name = name {
                    parameters?[name] = value
                }
            }
            var params: Data?
            if let parameters = parameters, !parameters.isEmpty {
                params = try? JSONSerialization.data(withJSONObject: parameters, options: [])
                request.httpBody = params
            }
        }

        task = session.dataTask(with: request, completionHandler: completionHandler)
        task.resume()
    }

    public func fakeConnect(IncludeProperties includeProperties: Bool = true) {
        if includeProperties, request.httpMethod != HttpMethod.get.rawValue {
            var parameters: [String: Any]? = jsonBody ?? [:]
            let mirror = Mirror(reflecting: self)
            for (name, value) in mirror.children {
                if let propertyName = name {
                    parameters?[propertyName] = value
                }
            }
            var params: Data?
            if let parameters = parameters, !parameters.isEmpty {
                params = try? JSONSerialization.data(withJSONObject: parameters, options: [])
                request.httpBody = params
            }
        }
    }
}
