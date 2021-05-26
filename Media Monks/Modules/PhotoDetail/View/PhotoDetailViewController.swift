//
//  PhotoDetailViewController.swift
//  Media Monks
//
//  Created by Andrii Vereskun on 5/24/21.
//

import UIKit
import MapKit

protocol PhotoDetailViewInput: AnyObject {
    func setState(_ state: PhotoDetailViewController.State)
}

protocol PhotoDetailViewOutput {
    func viewIsReady()
}

class PhotoDetailViewController: BaseViewController, Instantiatable, PhotoDetailViewInput {

    // MARK: - View state
    
    enum State {
        case initialState(PhotoDetailViewController.ViewModel)
        
        func apply(on view: PhotoDetailViewController) {
            switch self {
            case .initialState(let viewModel):
                view.viewIsReady(viewModel)
            }
        }
    }
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var nameContainerView: UIView! {
        didSet {
            nameContainerView.round()
        }
    }
    @IBOutlet private weak var mapView: MKMapView!
    @IBOutlet private weak var fulNameLabel: UILabel!
    @IBOutlet private weak var emailLabel: UILabel!
    @IBOutlet private weak var websiteLabel: UILabel!
    @IBOutlet private weak var cityLabel: UILabel!
    @IBOutlet private weak var streetLabel: UILabel!
    @IBOutlet private weak var phoneLabel: UILabel!
    @IBOutlet private weak var firstLaterLabel: UILabel!
    
    // MARK: - Public properties
    
    var output: PhotoDetailViewOutput!
    
    // MARK: - Private properties
    
    private var viewModel: PhotoDetailViewController.ViewModel? {
        didSet {
            if let viewModel = viewModel {
                firstLaterLabel.text = viewModel.fullName.first?.uppercased()
                fulNameLabel.text = viewModel.fullName
                emailLabel.text = viewModel.email
                websiteLabel.text = viewModel.website
                cityLabel.text = viewModel.city
                streetLabel.text = viewModel.street
                phoneLabel.text = viewModel.phone
                mapView.centerToLocation(CLLocation(latitude: viewModel.lat, longitude: viewModel.lng))
            }
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

private extension PhotoDetailViewController {
    func viewIsReady(_ viewModal: PhotoDetailViewController.ViewModel) {
        self.viewModel = viewModal
        setupBackButtonItem()
        setNavigationItemTitle(viewModal.fullName)
    }
}

// MARK: - ViewModel

extension PhotoDetailViewController {
    struct ViewModel {
        let fullName: String
        let userName: String
        let email: String
        let phone: String
        let website: String
        let city: String
        let street: String
        let lat: Double
        let lng: Double
    }
}
