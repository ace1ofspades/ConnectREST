//
//  ViewController.swift
//  ConnectRest Example
//
//  Created by Yusuf Tekin on 12.07.2023.
//

import UIKit
import ConnectREST

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}
//
//class BaseResponse: JsonStruct {
//    @objc var birthday: String?
//    @objc var birthday2: String!
//    var birthday3: Int?
//    override init(Data data: Data?) {
//        super.init(Data: data)
//        birthday2 => parameters["birthday"]
//        birthday3 => parameters["birthday"]
//    }
//}
//
//class Test {
//    init() {
//        var signUpService = TestService.SignUp()
//        signUpService.birthday = "Doğum günü"
//        signUpService.connect { data, response, error in
//            if let error = error {
//                // Error Happened
//            }
//            if let data = data {
//                let response = BaseResponse(Data: data)
//                // Data Arrived
//            }
//            if let response = response {
//                // Response Arrived
//            }
//        }
//    }
//}
//
//class TestService {
//    class SignUp: BaseConnect {
//        var username: String?
//        var fullname: String?
//        var email: String?
//        var birthday: String?
//        var countryCode: Int?
//        init() {
//            super.init(Path: "/api/test", Method: .post)
//            tokenRequired = false
//        }
//
//    }
//}
