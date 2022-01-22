//
//  Array+Index.swift
//  flickr-image-search
//
//  Created by Mark Dennis Diwa on 1/22/22.
//

import Foundation

extension Array {
  subscript(safe idx: Int) -> Element? {
    idx < endIndex ? self[idx] : nil
  }
}
