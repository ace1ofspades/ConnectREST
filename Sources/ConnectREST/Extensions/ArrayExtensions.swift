//
//  File.swift
//
//
//  Created by Yusuf Tekin on 15.07.2023.
//

import Foundation

/**
 The provided code extends the `Array` type in Swift with a computed property called `data`. This computed property returns the JSON data representation of the array using the `JSONSerialization` class.

 Here's a breakdown of the code:

 1. The code extends the `Array` type using Swift's extension mechanism. This allows you to add new functionality to the existing `Array` type.

 2. The computed property `data` is defined with a return type of `Data?`, which is an optional `Data` type. It allows the property to return `nil` if the serialization process fails.

 3. Inside the computed property's implementation, the `try?` keyword is used to attempt JSON serialization. The `JSONSerialization.data(withJSONObject:)` method is called with `self` (the current array) as the input parameter. This method attempts to convert the array into its JSON data representation.

 4. If the serialization is successful, the computed property returns the JSON data. If an error occurs during serialization, the `try?` expression returns `nil`.

 The purpose of this extension is to provide a convenient way to convert an array into its JSON data representation. By accessing the `data` property on an array, you can obtain the JSON data that can be used in various scenarios, such as sending data over a network or storing it locally.
 */
extension Array {
    /// The computed property `data` is defined with a return type of `Data?`, which is an optional `Data` type. It allows the property to return `nil` if the serialization process fails.
    var data: Data? {
        try? JSONSerialization.data(withJSONObject: self)
    }
}
