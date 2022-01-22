//
//  SearchPhotoViewModel.swift
//  flickr-image-search
//
//  Created by Mark Dennis Diwa on 1/22/22.
//

import Foundation

class SearchPhotoViewModel: SearchPhotoViewModelProtocol {
    
    init(urlString: String) {
        imageUrl = URL(string: urlString)
    }
    
    var imageUrl: URL?
    
}
