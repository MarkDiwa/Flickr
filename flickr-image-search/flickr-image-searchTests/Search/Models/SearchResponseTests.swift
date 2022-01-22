//
//  SearchResponseTests.swift
//  flickr-image-searchTests
//
//  Created by Mark Dennis Diwa on 1/22/22.
//

import Foundation
import XCTest

@testable import flickr_image_search

class SearchResponseTests: XCTestCase {
    
    func testPhotoDecoding() {
        let jsonData = Data(jsonPhoto.utf8)
        let photo = try? JSONDecoder().decode(Photo.self, from: jsonData)
        XCTAssertNotNil(photo)
    }
    
    //TODO: - Test other Decoding and Encodings of other models
}

extension SearchResponseTests {
    
    var jsonPhoto: String {
        """
        {
        "id": "1",
        "owner": "132960335@N04",
        "secret": "1",
        "server": "1",
        "farm": 1,
        "title": "test",
        "ispublic": 1,
        "isfriend": 0,
        "isfamily": 0
        }
        """
    }
}
