//
//  PhotoListViewController.swift
//  Media Monks
//
//  Created by Andrii Vereskun on 5/24/21.
//

import UIKit
import Kingfisher

protocol PhotoListViewInput: AnyObject {
    func setState(_ state: PhotoListViewController.State)
}

protocol PhotoListViewOutput {
    func viewIsReady()
    func didTapLogout()
}

final class PhotoListViewController: BaseViewController, Instantiatable, PhotoListViewInput {
    
    // MARK: - Constants
    
    private enum Constants {
        static let title = "Photos"
        static let cellHeight: CGFloat = 34
        static let widthOffset: CGFloat = 30
        static let heightOffset: CGFloat = 20
        static let heightLayoutOffset: CGFloat = 42
    }
    
    // MARK: - View state
    
    enum State {
        case viewIsReady
        case isLoading
        case dataIsLoaded
        case updateContent([PhotoCollectionViewCell.ViewModel])
        
        func apply(on view: PhotoListViewController) {
            switch self {
            case .viewIsReady:
                view.viewIsReady()
            case .isLoading:
                view.isLoading()
            case .dataIsLoaded:
                view.dataIsLoaded()
            case .updateContent(let viewModels):
                view.updateContentr(viewModels)
            }
        }
    }
    
    // MARK: - Public properties
    
    var output: PhotoListViewOutput!
    
    // MARK: - Private properties
    
    var viewModels = [PhotoCollectionViewCell.ViewModel]() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var collectionView: UICollectionView! {
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = self
        }
    }
    @IBOutlet private weak var activityView: UIActivityIndicatorView! {
        didSet {
            activityView.hidesWhenStopped = true
        }
    }
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
    }
    
    // MARK: - CreateNewPostViewInput
    
    func setState(_ state: State) {
        state.apply(on: self)
    }
}

// MARK: - Private methods

private extension PhotoListViewController {
    
    func viewIsReady() {
        collectionView.register(UINib(nibName: "PhotoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PhotoCollectionViewCell")
        setupApperence()
    }
    
    func setupApperence() {
        setBackBarButtonName("")
        setNavigationItemTitle(Constants.title)
        setupBarRightButtonItem()
        if let navigationController = navigationController {
            navigationController.navigationBar.barTintColor = .white
            navigationController.navigationBar.hideShadow()
        }
    }
    
    func setupBarRightButtonItem() {
        let logoutItem = UIBarButtonItem(image: UIImage(systemName: "arrowshape.turn.up.left"),
                                         style: .plain,
                                         target: self,
                                         action: #selector(onLogoutAction))
        logoutItem.tintColor = .black
        navigationItem.rightBarButtonItem = logoutItem
    }
    
    @objc
    func onLogoutAction() {
        output.didTapLogout()
    }
    
    func isLoading() {
        activityView.startAnimating()
    }
    
    func dataIsLoaded() {
        activityView.stopAnimating()
    }
    
    func updateContentr(_ viewModels: [PhotoCollectionViewCell.ViewModel]) {
        self.viewModels = viewModels
    }
}

extension PhotoListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModels[indexPath.row].tapAction.perform()
    }
}

// MARK: - UICollectionViewDataSource

extension PhotoListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCollectionViewCell", for: indexPath) as? PhotoCollectionViewCell else {
            return PhotoCollectionViewCell()
        }
        cell.setupCell(viewModel: viewModels[indexPath.row])
        return cell
    }
}


// MARK:  - UICollectionViewDelegateFlowLayout

extension PhotoListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: (UIScreen.main.bounds.width - Constants.widthOffset) / 2, height: (UIScreen.main.bounds.width - Constants.heightOffset) / 2 + Constants.heightLayoutOffset)
        return size
    }
}
