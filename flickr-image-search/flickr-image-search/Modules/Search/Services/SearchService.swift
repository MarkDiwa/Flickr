//
//  SearchService.swift
//  flickr-image-search
//
//  Created by Mark Dennis Diwa on 1/22/22.
//

import Foundation

class SearchService: SearchServiceProtocol {
    
    private let api: SearchAPI
    
    init(api: SearchAPI = APIClient(baseUrlString: "https://api.flickr.com")) {
        self.api = api
    }
    
    func searchPhotos<T: Decodable>(
        text: String,
        page: Int,
        onSuccess: @escaping SingleResult<T>,
        onFailure: @escaping ErrorResult
    ) {
        let searchPhotosParams = SearchPhotoRequestParameters(
            apiKey: "96358825614a5d3b1a1c3fd87fca2b47",
            text: text,
            page: page
        )
        api.searchPhotos(
            params: searchPhotosParams.json,
            onSuccess: onSuccess,
            onFailure: onFailure
        )
    }
    
}
