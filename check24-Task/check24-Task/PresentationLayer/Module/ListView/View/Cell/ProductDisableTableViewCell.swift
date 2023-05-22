//
//  ProductDisableTableViewCell.swift
//  check24-Task
//
//  Created by admin on 22/05/2023.
//

import UIKit
import Kingfisher

class ProductDisableTableViewCell: UITableViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var rateStackView: UIStackView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(item: Product) {
        nameLabel.text = item.name
        descriptionLabel.text = item.description
        StarComponent.setStar(rateStackView: rateStackView, star: item.rating)
        guard let url = URL(string: item.imageURL) else {
            return
        }
        productImageView.kf.setImage(with: url)
        
    }
}
