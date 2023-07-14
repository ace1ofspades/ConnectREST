//
//  File.swift
//  
//
//  Created by Yusuf Tekin on 14.07.2023.
//

import Foundation


public struct DecodeAny: Decodable {
    public var value: Any?
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()

        if container.decodeNil() {
            value = nil; return
        }

        if let decoded = try? container.decode(Bool.self) {
            value = decoded; return
        }

        if let decoded = try? container.decode(Int.self) {
            value = decoded; return
        }

        if let decoded = try? container.decode(Double.self) {
            value = decoded; return
        }

        if let decoded = try? container.decode(String.self) {
            value = decoded; return
        }

        if let decoded = try? container.decode([DecodeAny].self) {
            value = decoded; return
        }

        if let decoded = try? container.decode([String: DecodeAny].self) {
            value = decoded; return
        }

        let context = DecodingError.Context(codingPath: container.codingPath, debugDescription: "value cannot be decoded with key '\(String(describing: container.codingPath.first?.stringValue))'")
        throw DecodingError.typeMismatch(DecodeAny.self, context)
    }
}
