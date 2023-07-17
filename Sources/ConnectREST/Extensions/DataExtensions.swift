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

/**
 - `attributedHtmlString`: Represents an optional `NSAttributedString` object based on the HTML content within it.

 - `describing`: Represents an optional `String` that represents the string value of the `Data` object.

 - `prettyPrint`: Represents the JSON data within the `Data` object as a pretty-printed string if available.

 - `prettyDescribing`: Represents the `Data` object as a pretty-printed string if available. If the `Data` object contains a text value and cannot be printed in a pretty format, it includes a message stating that the data value cannot be printed in a pretty format.

 - `object`: Represents an optional `[String: Any]` dictionary object if the `Data` object can be serialized into a dictionary.

 - `array`: Represents an optional `[Any]` array object if the `Data` object can be serialized into an array.

 */
extension Data {
    /// `attributedHtmlString`: Represents an optional `NSAttributedString` object based on the HTML content within it.
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

    /// `describing`: Represents an optional `String` that represents the string value of the `Data` object.
    var describing: String? { attributedHtmlString?.string }

    /// `prettyPrint`: Represents the JSON data within the `Data` object as a pretty-printed string if available.
    var prettyPrint: String? {
        if let object = try? JSONSerialization.jsonObject(with: self, options: .mutableContainers),
           let prettyData = try? JSONSerialization.data(withJSONObject: object, options: .prettyPrinted) {
            return String(decoding: prettyData, as: UTF8.self)
        }
        return nil
    }

    /// `prettyDescribing`: Represents the `Data` object as a pretty-printed string if available. If the `Data` object contains a text value and cannot be printed in a pretty format, it includes a message stating that the data value cannot be printed in a pretty format.
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

    /// `object`: Represents an optional `[String: Any]` dictionary object if the `Data` object can be serialized into a dictionary.
    var object: [String: Any]? {
        if let object = try? JSONSerialization.jsonObject(with: self, options: .mutableContainers) as? [String: Any] {
            return object
        }
        return nil
    }

    /// `array`: Represents an optional `[Any]` array object if the `Data` object can be serialized into an array.
    var array: [Any]? {
        if let object = try? JSONSerialization.jsonObject(with: self, options: .mutableContainers) as? [Any] {
            return object
        }
        return nil
    }
}
