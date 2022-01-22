//
//  APIClient.swift
//  flickr-image-search
//
//  Created by Mark Dennis Diwa on 1/22/22.
//

import Foundation

class APIClient: APIClientProtocol {
    var baseUrlString: String
    
    init(baseUrlString: String) {
        self.baseUrlString = baseUrlString
    }
    
}
