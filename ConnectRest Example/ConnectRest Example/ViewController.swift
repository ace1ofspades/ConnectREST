//
//  ViewController.swift
//  ConnectRest Example
//
//  Created by Yusuf Tekin on 12.07.2023.
//

import ConnectREST
import MapStruct
import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        Connect.baseUrl = "https://example.com"
    }

    // Single Request Example
    func singleRequestExample() {
        let parameters = [
            "email": "info@example.com",
            "password": "password",
        ]
        let request = Connect(Path: "/api/example", Method: .post, Parameters: parameters)

        // use full responseHandler
        // request.connect(responseHandler(_:_:_:))

        // or use only for what you need
        request.connect(
            Data: { data in
                if let data = data {
                    // Data Arrived
                }
            },
            Response: { response in
                if let response = response {
                    // Response Arrived
                }
            },
            Error: { error in
                if let error = error {
                    // Error Happened
                }
            },
            IncludeProperties: false
        )
    }

    // Example with service class
    func serviceClassExample() {
        let loginService = ExampleService.SignIn(email: "email", password: "password")
        loginService.connect(responseHandler(_:_:_:))
    }

    func responseHandler(_ data: Data?, _ response: URLResponse?, _ error: Error?) {
        if let error = error {
            // Error Happened
            print(error.localizedDescription)
        }

        if let response = response {
            print(response.url?.absoluteString ?? "")
            // Response Arrived
        }

        if let data = data {
            // Data Arrived

            // Result with BaseResponse
            let result = BaseResponse<LoginDto>(data)

            print("--------- RESULT 1 -----------")
            print(result.data?.token ?? "data not found")
            print(result.success ?? "success not found")

            // Result with BaseResponseClass
            let result2 = BaseResponseClass<LoginDtoClass>(data)

            print("--------- RESULT 2 -----------")
            print(result2.data?.token ?? "data not found")
            print(result2.success ?? "success not found")

            // Result with BaseResponse and data prop type is Any
            let result3 = BaseResponseClass<Any>(data)

            print("--------- RESULT 3 -----------")
            print(result3.data ?? "data not found")
            print(result3.success ?? "success not found")

            // Result with BaseResponse and data prop type is Json
            let result4 = BaseResponseClass<Json>(data)

            print("--------- RESULT 4 -----------")
            print(result4.data ?? "data not found")
            print(result4.data?.token ?? "data not found")
            print(result4.success ?? "success not found")
        }
    }
}
