//
//  SearchPhotoCollectionViewCell.swift
//  flickr-image-search
//
//  Created by Mark Dennis Diwa on 1/22/22.
//

import UIKit
import Kingfisher

class SearchPhotoCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var photoImageView: UIImageView!
    
    var viewModel: SearchPhotoViewModelProtocol? {
        didSet {
            downloadImage()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}

extension SearchPhotoCollectionViewCell {
    
    func downloadImage() {
        photoImageView.kf.setImage(with: viewModel?.imageUrl, placeholder: UIImage(named: "placeholder-image"))
    }
}
