//
//  File.swift
//  
//
//  Created by Yusuf Tekin on 15.07.2023.
//

import Foundation

extension Dictionary {
    var data:Data? {
        try? JSONSerialization.data(withJSONObject: self)
    }
}
