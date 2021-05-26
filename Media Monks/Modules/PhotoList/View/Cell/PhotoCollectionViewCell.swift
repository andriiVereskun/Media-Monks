//
//  PhotoCollectionViewCell.swift
//  Media Monks
//
//  Created by Andrii Vereskun on 5/25/21.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Constants
    
    private enum Constants {
        static let image = UIImage(named: "photo")
    }
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var containerView: UIView!
    
    // MARK: - Private properties
    
    private var viewModel: PhotoCollectionViewCell.ViewModel?
    
    // MARK: - Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.render(.image(Constants.image))
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.render(.image(Constants.image))
        titleLabel.text = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        self.imageView.layer.masksToBounds = true
        self.imageView.layer.cornerRadius = 5
    }
}

// MARK: - Public methods

extension PhotoCollectionViewCell {
    func setupCell(viewModel: PhotoCollectionViewCell.ViewModel) {
        self.viewModel = viewModel
        titleLabel.text = viewModel.title
        imageView.render(.stringUrl(viewModel.url.absoluteString), placeholder: Constants.image)
    }
}

// MARK: - View Model

extension PhotoCollectionViewCell {
    struct ViewModel {
        let title: String
        let url: URL
        let tapAction: Command
    }
}
