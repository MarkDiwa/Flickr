//
//  SearchAPI.swift
//  flickr-image-search
//
//  Created by Mark Dennis Diwa on 1/22/22.
//

import Foundation

protocol SearchAPI {
    func searchPhotos<T: Decodable>(
        params: Parameters,
        onSuccess: @escaping SingleResult<T>,
        onFailure: @escaping ErrorResult
    )
}
