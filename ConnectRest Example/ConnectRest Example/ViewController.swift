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


class Test {
    init() {
        var signUpService = TestService.SignUp()
        signUpService.birthday = "Doğum günü"
        signUpService.connect { data, response, error in
            if let error = error {
                // Error Happened
            }
            if let data = data {
                let response = BaseResponse(Data: data)
                // Data Arrived
            }
            if let response = response {
                // Response Arrived
            }
        }
    }
}
