//
//  UICollectionViewCell+Nib.swift
//  flickr-image-search
//
//  Created by Mark Dennis Diwa on 1/22/22.
//

import Foundation
import UIKit

extension UICollectionViewCell {
    static var reuseIdentifier: String { String(describing: self) }
    static var nib: UINib { UINib(nibName: reuseIdentifier, bundle: nil) }
}
