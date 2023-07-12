//
//  ViewController.swift
//  ConnectRest Example
//
//  Created by Yusuf Tekin on 12.07.2023.
//

import ConnectREST
import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        let signUpService = TestService.SignUp()
        signUpService.username = "username"
        signUpService.fullname = "Name Surname"
        signUpService.email = "example@mail.com"
        signUpService.birthday = "1970-01-01"
        signUpService.countryCode = 90

        signUpService.connect { data, response, error in
            if let error = error {
                // Error Happened
                print(error.localizedDescription)
            }
            if let data = data {
                let response = BaseResponse(Data: data)
                print(response.description)
                // Data Arrived
            }
            if let response = response {
                print(response.url?.absoluteString ?? "")
                // Response Arrived
            }
        }
    }
}
