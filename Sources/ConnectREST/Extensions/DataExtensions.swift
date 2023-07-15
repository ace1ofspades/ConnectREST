//
//  File.swift
//
//
//  Created by Yusuf Tekin on 15.07.2023.
//

import Foundation

#if canImport(UIKit)
    import UIKit
#endif

#if canImport(Cocoa)
    import Cocoa
#endif

extension Data {
    var attributedHtmlString: NSAttributedString? {
        try? NSAttributedString(
            data: self,
            options: [
                .documentType: NSAttributedString.DocumentType.html,
                .characterEncoding: String.Encoding.utf8.rawValue,
            ],
            documentAttributes: nil
        )
    }

    var describing: String? { attributedHtmlString?.string }
    
    var prettyPrint: String? {
        if let object = try? JSONSerialization.jsonObject(with: self, options: .mutableContainers),
           let prettyData = try? JSONSerialization.data(withJSONObject: object, options: .prettyPrinted) {
            return String(decoding: prettyData, as: UTF8.self)
        }
        return nil
    }
    
    var prettyDescribing: String? {
        if let prettyPrint = prettyPrint {
            return prettyPrint
        }
        if let describing = describing {
            let text =
                """
                {
                    "status": "The data cannot be printed in a pretty format because it is a text value.",
                    "value": \(describing.debugDescription)
                }
                """
            return text.data(using: .utf8)?.prettyPrint ?? describing.debugDescription
        }
        return nil
    }
    
    var object:[String:Any]? {
        if let object = try? JSONSerialization.jsonObject(with: self, options: .mutableContainers) as? [String:Any] {
            return object
        }
        return nil
    }
    
    var array:[Any]? {
        if let object = try? JSONSerialization.jsonObject(with: self, options: .mutableContainers) as? [Any] {
            return object
        }
        return nil
    }
}
