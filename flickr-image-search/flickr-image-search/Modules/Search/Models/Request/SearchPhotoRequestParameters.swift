//
//  SearchPhotoRequestParameters.swift
//  flickr-image-search
//
//  Created by Mark Dennis Diwa on 1/22/22.
//

import Foundation

struct SearchPhotoRequestParameters: Codable {
    
    var method: String = "flickr.photos.search"
    var apiKey: String = ""
    var text: String
    var format: String = "json"
    var noJsonCallback: Int = 1
    var page: Int = 0
    
    enum CodingKeys: String, CodingKey {
        case method
        case apiKey = "api_key"
        case text
        case format
        case noJsonCallback = "nojsoncallback"
        case page
    }
}
