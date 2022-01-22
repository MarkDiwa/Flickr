//
//  APIError.swift
//  flickr-image-search
//
//  Created by Mark Dennis Diwa on 1/22/22.
//

import Foundation

struct APIError: Error {
    var errorMessage: String
}

extension APIError: LocalizedError {
    
    var errorDescription: String? {
        errorMessage
    }
}
