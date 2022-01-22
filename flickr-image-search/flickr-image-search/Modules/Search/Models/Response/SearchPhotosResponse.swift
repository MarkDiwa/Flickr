//
//  SearchPhotosResponse.swift
//  flickr-image-search
//
//  Created by Mark Dennis Diwa on 1/22/22.
//

import Foundation

// MARK: - SearchPhotosResponse
struct SearchPhotosResponse: Codable {
    var data: SearchPhotosResult
    var stat: String
    var message: String?
    var code: Int?
    
    enum CodingKeys: String, CodingKey {
        case data = "photos"
        case stat
        case message
        case code
    }
}

// MARK: - Photos
struct SearchPhotosResult: Codable {
    var page: Int
    var pages: Int
    var perpage: Int
    var total: Int
    var photos: [Photo]
    
    enum CodingKeys: String, CodingKey {
        case page
        case pages
        case perpage
        case total
        case photos = "photo"
    }
}

// MARK: - Photo
struct Photo: Codable {
    var id: String
    var owner: String
    var secret: String
    var server: String
    var farm: Int
    var title: String
    var ispublic: Int
    var isfriend: Int
    var isfamily: Int
}
