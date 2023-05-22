//
//  StarComponent.swift
//  check24-Task
//
//  Created by admin on 22/05/2023.
//

import Foundation
import UIKit

class StarComponent {
    
    static func setStar(rateStackView:UIStackView , star: Double) {
        rateStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        for _ in 1...Int(star) {
            let starFull = UIImage(systemName: "star.fill")
            let imageView = UIImageView(image: starFull)
            imageView.tintColor = .systemYellow
            rateStackView.addArrangedSubview(imageView)
        }
        
        let reminder = star.truncatingRemainder(dividingBy: 1)
        if reminder >= 0.5 {
            let starHalf = UIImage(systemName: "star.leadinghalf.filled")
            let imageView = UIImageView(image: starHalf)
            imageView.tintColor = .systemYellow
            
            rateStackView.addArrangedSubview(imageView)
        }
        
        if rateStackView.arrangedSubviews.count != 5 {
            for _ in 1...(5-rateStackView.arrangedSubviews.count) {
                let starEmpty = UIImage(systemName: "star")
                let imageView = UIImageView(image: starEmpty)
                imageView.tintColor = .systemYellow
                
                rateStackView.addArrangedSubview(imageView)
            }
        }
    }
}
