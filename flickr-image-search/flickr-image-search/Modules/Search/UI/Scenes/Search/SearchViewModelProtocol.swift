//
//  SearchViewModelProtocol.swift
//  flickr-image-search
//
//  Created by Mark Dennis Diwa on 1/22/22.
//

import Foundation

protocol SearchViewModelProtocol {
    
    var numberOfItems: Int { get }
    var isFetching: Bool { get }
    
    func search(
      _ text: String,
      onSuccess: @escaping VoidResult,
      onError: @escaping ErrorResult
    )
    func searchPhotoViewModel(at index: Int) -> SearchPhotoViewModelProtocol?
}
