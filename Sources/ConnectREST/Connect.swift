//
//  File.swift
//
//
//  Created by Yusuf Tekin on 7.07.2023.
//

import Foundation

/**
 Overall, the `Connect` class provides a convenient way to make HTTP requests by encapsulating the necessary logic and providing an easy-to-use interface. It allows customization and extension through subclassing and method overriding.

 - The `Connect` class has several properties and methods for configuring and executing network requests. It has a `session` property of type `URLSession` to handle the network communication, a `request` property of type `URLRequest` to store the request details,
 - The `Connect` class provides multiple initializer methods for convenience when creating requests. Each initializer sets up the request with the provided path, HTTP method, and optional parameters.
 */
open class Connect {
    public var session: URLSession!
    public var request: URLRequest!
    var task: URLSessionDataTask!
    var errorHandler: (Error?) -> Void = { _ in }
    
    ///- The `baseUrl` property is a static property that allows setting and getting the base URL for the requests.
    public static var baseUrl: String {
        get {
            return baseURL
        }
        set {
            baseURL = newValue
        }
    }

    ///- The `configure()` method is meant to be overridden by subclasses and can be used for additional configuration before making the request.
    open func configure() {}

    ///- The `printForDebug(_: _: _: _)` method is used for printing debug information about the request, response, and data. It is conditional based on the `DEBUG` preprocessor macro.
    open func printForDebug(_ data: Data?, _ response: URLResponse?, _ error: Error?) -> String? { DebugPrint.defaultPrint(request, data, response, error) }

    ///- The `jsonBody` computed property provides access to the JSON body of the request. It converts the `httpBody` property of the `URLRequest` to a dictionary when getting, and sets the `httpBody` property from the provided dictionary when setting.
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
    ///- The `commonInit(_: _: _: )` private method is a common initialization method that sets up the `session`, `request`, and `task` properties based on the provided path, HTTP method, and parameters.
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
    ///- The `Connect` class has an extension that defines the `_printForDebug(_: _: _: )` method, which is responsible for printing debug information. It checks the `DEBUG` preprocessor macro and prints the debug information if it is defined.
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
    ///- The `Connect` class has another extension that defines the `connect(_: _: _: _: )` and `connect(_: _: _: )` methods. These methods are used to execute the network request. The `connect(_: _: _: _: )` method accepts closure parameters to handle the data, response, and error, and the `connect(_: _: _: )` method accepts a completion handler for the same purpose. These methods also handle the serialization of parameters and the printing of debug information.
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

    ///- The `Connect` class has another extension that defines the `connect(_: _: _: _: )` and `connect(_: _: _: )` methods. These methods are used to execute the network request. The `connect(_: _: _: _: )` method accepts closure parameters to handle the data, response, and error, and the `connect(_: _: _: )` method accepts a completion handler for the same purpose. These methods also handle the serialization of parameters and the printing of debug information.
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
