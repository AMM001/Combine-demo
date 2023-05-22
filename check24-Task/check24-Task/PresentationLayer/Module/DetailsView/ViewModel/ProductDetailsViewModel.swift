//
//  ProductDetailsViewModel.swift
//  check24-Task
//
//  Created by admin on 22/05/2023.
//

import Foundation
import Combine

protocol ProductDetailsViewModelProtocol {
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
}
