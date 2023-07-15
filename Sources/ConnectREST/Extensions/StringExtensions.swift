//
//  File.swift
//
//
//  Created by Yusuf Tekin on 15.07.2023.
//

import Foundation

extension StringProtocol {
    var attributedHtmlString: NSAttributedString? {
        data(using: .utf8)?.attributedHtmlString
    }

    var describing: String? {
        attributedHtmlString?.string
    }

    var urlEncodedString: String? {
        addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
    }
}
