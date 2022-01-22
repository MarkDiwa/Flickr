//
//  SearchViewModel.swift
//  flickr-image-search
//
//  Created by Mark Dennis Diwa on 1/22/22.
//

import Foundation

class SearchViewModel: SearchViewModelProtocol {
    
    required init(service: SearchService = SearchService()) {
        self.service = service
    }
    
    private let service: SearchServiceProtocol
    private var imageUrls: [String] = []
    private var currentPage = 1
    private var lastSearchedText = ""
    
    var isFetching = false
    
}

extension SearchViewModel {
    
    func handleSuccess(then completion: @escaping VoidResult) -> SingleResult<SearchPhotosResponse> {
        return { [weak self] searchResult in
            guard let self = self else { return }
            let urls = searchResult.data.photos.map {
                return "https://farm\($0.farm).static.flickr.com/\($0.server)/\($0.id)_\($0.secret).jpg"
            }
            
            self.isFetching = false
            self.imageUrls.append(contentsOf: urls)
            self.currentPage += 1
            completion()
        }
    }
    
    func handleError(then completion: @escaping ErrorResult) -> ErrorResult {
        return { [weak self] error in
            guard let self = self else { return }
            self.isFetching = false
            completion(error)
        }
    }
}

extension SearchViewModel {
    
    func search(_ text: String, onSuccess: @escaping VoidResult, onError: @escaping ErrorResult) {
        isFetching = true
        if lastSearchedText != text {
            imageUrls.removeAll()
            currentPage = 1
        }
        lastSearchedText = text
        service.searchPhotos(
            text: text,
            page: currentPage,
            onSuccess: handleSuccess(then: onSuccess),
            onFailure: onError
        )
    }
    
    func searchPhotoViewModel(at index: Int) -> SearchPhotoViewModelProtocol? {
        guard let urlString = imageUrls[safe: index] else { return nil }
        return SearchPhotoViewModel(urlString: urlString)
    }
}

extension SearchViewModel {
    
    var numberOfItems: Int {
        imageUrls.count
    }
}
