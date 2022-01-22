//
//  SearchViewModelTests.swift
//  flickr-image-searchTests
//
//  Created by Mark Dennis Diwa on 1/22/22.
//

import Foundation
import XCTest

@testable import flickr_image_search

class SearchViewModelTests: XCTestCase {
    
    let viewModel = MockSearchViewModel()
    
    func testNumberOfItems() {
        XCTAssertEqual(viewModel.numberOfItems, 3)
    }
    
    func testisFetching() {
        XCTAssertEqual(viewModel.isFetching, false)
        viewModel.search("test", onSuccess: {}, onError: { _ in })
        XCTAssertEqual(viewModel.isFetching, true)
    }
    
    func testSearchPhotoVM() {
        let vm = viewModel.searchPhotoViewModel(at: 0)
        XCTAssertEqual(vm?.imageUrl?.absoluteString, "1")
    }
    
}

class MockSearchViewModel: SearchViewModelProtocol {
    
    private var imageUrls = ["1", "2", "3"]
    
    var numberOfItems: Int {
        return imageUrls.count
    }
    
    var isFetching = false
    
    func search(_ text: String, onSuccess: @escaping VoidResult, onError: @escaping ErrorResult) {
        isFetching = true
    }
    
    func searchPhotoViewModel(at index: Int) -> SearchPhotoViewModelProtocol? {
        return MockSearchPhotoViewModel(urlString: imageUrls[index])
    }
    
}

class MockSearchPhotoViewModel: SearchPhotoViewModelProtocol {
    var imageUrl: URL?
    
    init(urlString: String) {
        imageUrl = URL(string: urlString)
    }
}
