//
//  Encodable+JSON.swift
//  flickr-image-search
//
//  Created by Mark Dennis Diwa on 1/22/22.
//

import Foundation

extension Encodable {
    var json: [String: Any] {
        guard let data = try? JSONEncoder().encode(self),
            let dictionary = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
                return [:]
        }
        return dictionary
    }
}
