//
//  File.swift
//
//
//  Created by Yusuf Tekin on 7.07.2023.
//

import Foundation

open class Connect {
    public var session: URLSession!
    public var request: URLRequest!
    var task: URLSessionDataTask!
    var errorHandler: (Error?) -> Void = { _ in }
    
    public static var baseUrl: String {
        get {
            return baseURL
        }
        set {
            baseURL = newValue
        }
    }

    open func configure() {}

    open func printForDebug(_ data: Data?, _ response: URLResponse?, _ error: Error?) -> String? { DebugPrint.defaultPrint(request, data, response, error) }

    open var jsonBody: [String: Any]? {
        get { request.httpBody?.object }
        set { request.httpBody = newValue?.data }
    }

    public init(Path path: String, Method method: HttpMethod = .get) {
        commonInit(Path: path, Method: method)
    }

    public init(Path path: String, Method method: HttpMethod = .get, Parameters parameters: Data) {
        commonInit(Path: path, Method: method, Parameters: parameters)
    }

    public init(Path path: String, Method method: HttpMethod = .get, Parameters parameters: Any) {
        let params = try? JSONSerialization.data(withJSONObject: parameters, options: [])
        commonInit(Path: path, Method: method, Parameters: params)
    }

    public init(Path path: String, Method method: HttpMethod = .get, Parameters parameters: String, Encoding encoding: String.Encoding = .utf8) {
        let encoding = encoding
        let params = parameters.data(using: encoding)
        commonInit(Path: path, Method: method, Parameters: params)
    }
}

// Common Initilize Method
extension Connect {
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

// Debug Print Method
extension Connect {
    func _printForDebug(_ data: Data?, _ response: URLResponse?, _ error: Error?) {
        #if !DEBUG
            return
        #endif

        print("""

        --------------- Debug Print ---------------
        \(printForDebug(data, response, error) ?? "nil")
        --------------- ----- ----- ---------------

        """)
    }
}

// Connect Methods
extension Connect {
    public func connect(
        Data v1: ((Data?) -> Void)? = nil,
        Response v2: ((URLResponse?) -> Void)? = nil,
        Error v3: ((Error?) -> Void)? = nil,
        IncludeProperties includeProperties: Bool = true
    ) {
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

        task = session.dataTask(with: request, completionHandler: { data, response, error in
            self._printForDebug(data, response, error)
            DispatchQueue.main.async {
                v1?(data)
                v2?(response)
                v3?(error) ?? self.errorHandler(error)
            }
        })
        task.resume()
    }

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

        task = session.dataTask(with: request, completionHandler: { data, response, error in
            self._printForDebug(data, response, error)
            DispatchQueue.main.async {
                completionHandler(data, response, error)
            }
        })
        task.resume()
    }
}
