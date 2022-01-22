//
//  SearchViewController.swift
//  flickr-image-search
//
//  Created by Mark Dennis Diwa on 1/22/22.
//

import UIKit
import Kingfisher

class SearchViewController: UIViewController {
    @IBOutlet private(set) var searchBar: UISearchBar!
    @IBOutlet private(set) var collectionView: UICollectionView!
    
    var viewModel: SearchViewModelProtocol?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
}
// MARK: - Setup

private extension SearchViewController {
    
    func setup() {
        setupSearchBar()
        setupCollectionView()
    }
    
    func setupSearchBar() {
        searchBar.delegate = self
    }
    
    func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.prefetchDataSource = self
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        collectionView.setCollectionViewLayout(
            layout,
            animated: true
        )
        collectionView.register(
            SearchPhotoCollectionViewCell.nib,
            forCellWithReuseIdentifier: SearchPhotoCollectionViewCell.reuseIdentifier
        )
    }
    
}

// MARK: - UICollectionViewDataSource

extension SearchViewController: UICollectionViewDataSource {
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView
                .dequeueReusableCell(withReuseIdentifier: SearchPhotoCollectionViewCell.reuseIdentifier,
                                     for: indexPath) as? SearchPhotoCollectionViewCell,
              let searchPhotoVm = viewModel?.searchPhotoViewModel(at: indexPath.item) else {
                  return UICollectionViewCell(frame: .zero)
              }
        
        cell.viewModel = searchPhotoVm
        return cell
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return viewModel?.numberOfItems ?? 0
    }
    
}

// MARK: - UICollectionViewDelegate
extension SearchViewController: UICollectionViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
//        self.mycollectionview.contentOffset.y >= (self.mycollectionview.contentSize.height - self.mycollectionview.bounds.size.height)
        let bottomScroll = collectionView.contentSize.height - collectionView.bounds.size.height - 300
        guard viewModel?.isFetching == false,
              position > bottomScroll else { return }
        search(searchBar.text ?? "" )
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension SearchViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        return UIEdgeInsets(
            top: 1.0,
            left: 8.0,
            bottom: 1.0,
            right: 8.0
        )
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let layout = collectionViewLayout as? UICollectionViewFlowLayout
        let widthPerItem = collectionView.frame.width / 3 - (layout?.minimumInteritemSpacing ?? 4)
        
        return CGSize(width: widthPerItem - 8, height: widthPerItem)
    }
    
}

// MARK: - UICollectionViewDataSourcePrefetching

extension SearchViewController: UICollectionViewDataSourcePrefetching {
    
    func collectionView(
        _ collectionView: UICollectionView,
        prefetchItemsAt indexPaths: [IndexPath]
    ) {
        for indexPath in indexPaths {
            let imageView = UIImageView()
            let vm = viewModel?.searchPhotoViewModel(at: indexPath.item)
            // To cache the images.
            imageView.kf.setImage(with: vm?.imageUrl)
        }
    }
    
}

// MARK: - UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        search(searchBar.text ?? "")
        title = searchBar.text
    }
}

// MARK: - Helpers
private extension SearchViewController {
    func handleError() -> ErrorResult {
        return { [weak self] error in
            guard let self = self else { return }
            let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
            DispatchQueue.main.async {
                self.present(alert, animated: true, completion: nil)
                self.reloadCollectionView()
            }
        }
    }
    func handleSuccess() -> VoidResult {
        return { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.reloadCollectionView()
            }
        }
    }
    
    func search(_ text: String) {
        viewModel?.search(text, onSuccess: handleSuccess(), onError: handleError())
    }
    
    func reloadCollectionView() {
        collectionView.reloadData()
    }
}
