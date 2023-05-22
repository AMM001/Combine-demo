//
//  ProductDetailsViewController.swift
//  check24-Task
//
//  Created by admin on 22/05/2023.
//

import UIKit

class ProductDetailsViewController: UIViewController {
    
    @IBOutlet weak private var nameLabel: UILabel!
    @IBOutlet weak private var productImageView: UIImageView!
    @IBOutlet weak private var priceLabel: UILabel!
    @IBOutlet weak private var rateStackView: UIStackView!
    @IBOutlet weak private var dateLabel: UILabel!
    @IBOutlet weak private var descriptionLabel: UILabel!
    @IBOutlet weak private var detailLabel: UILabel!
    @IBOutlet weak private var favoriteButton: UIButton!
    
    private var viewModel:ProductDetailsViewModelProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }
    func setup(viewModel: ProductDetailsViewModelProtocol = ProductDetailsViewModel()) {
         self.viewModel = viewModel
     }
    
    private func setupView() {
        nameLabel.text = viewModel?.product?.name
        priceLabel.text = viewModel?.product?.priceFormatted
        dateLabel.text = viewModel?.product?.dateFormatted
        descriptionLabel.text = viewModel?.product?.description
        detailLabel.text = viewModel?.product?.longDescription
        
        StarComponent.setStar(rateStackView: rateStackView, star: viewModel?.product?.rating ?? 0.0)
       // setupFavoriteButton()
        
        guard let url = URL(string: viewModel?.product?.imageURL ?? "") else {
            return
        }
        productImageView.kf.setImage(with: url)
    }
    
    @IBAction func favouriteBtn(_ sender: Any) {
       
    }
    
    @IBAction func gotToWebView(_ sender: Any) {
        self.viewModel?.navigateTowebView(viewController: self)
    }
    
}
