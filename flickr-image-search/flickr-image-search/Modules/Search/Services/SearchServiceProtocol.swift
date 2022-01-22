//
//  SearchServiceProtocol.swift
//  flickr-image-search
//
//  Created by Mark Dennis Diwa on 1/22/22.
//

import Foundation

protocol SearchServiceProtocol {
    func searchPhotos<T: Decodable>(
        text: String,
        page: Int,
        onSuccess: @escaping SingleResult<T>,
        onFailure: @escaping ErrorResult
    )
}
