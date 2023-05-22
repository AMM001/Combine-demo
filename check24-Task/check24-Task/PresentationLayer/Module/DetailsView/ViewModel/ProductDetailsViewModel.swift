//
//  ProductDetailsViewModel.swift
//  check24-Task
//
//  Created by admin on 22/05/2023.
//

import Foundation
import UIKit
import Combine

protocol ProductDetailsViewModelProtocol {
    func navigateTowebView(viewController:UIViewController)

    var product: Product? { get }
    var isFavouriteChanged : PassthroughSubject<Void, Never> { get}
}

class ProductDetailsViewModel: ProductDetailsViewModelProtocol {
    var product: Product?
    var isFavouriteChanged = PassthroughSubject<Void, Never>()
    
    init(product: Product) {
        self.product = product
    }
    init() {}
    
    func navigateTowebView(viewController:UIViewController) {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = mainStoryboard.instantiateViewController(withIdentifier: "WebViewViewController") as! WebViewViewController
        viewController.present(vc, animated: true)
    }
}
