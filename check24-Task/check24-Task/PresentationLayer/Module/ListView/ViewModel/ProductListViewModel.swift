//
//  ProductListViewModel.swift
//  check24-Task
//
//  Created by admin on 22/05/2023.
//

import Foundation
import UIKit
import Combine

public enum ProductCategoryType: Int {
    case all = 0
    case available = 1
    case favorite = 2
}


protocol ProductListViewModelProtocol {
    func getAllProductList(category: ProductCategoryType)
    //navigation
    func navigateToDetailsView(viewController:UIViewController ,products:Product)
    func navigateTowebView(viewController:UIViewController)

    var displayedProductList: CurrentValueSubject<[Product], Never> { get }
    var headerSection: Header? {get}
    var isLoading : PassthroughSubject<Bool, Never> {get}
    var fetchedError : PassthroughSubject<Error, Never> {get }
    var category: ProductCategoryType { get set }
}

class ProductListViewModel: ProductListViewModelProtocol {

    var headerSection: Header?
    var isLoading = PassthroughSubject<Bool, Never>()
    var fetchedError = PassthroughSubject<Error, Never>()
    var category : ProductCategoryType  = .all
    var displayedProductList = CurrentValueSubject<[Product], Never>([])
    
    private var allProducts = [Product]()
    var subscriptions = Set<AnyCancellable>()
    
    private func arrangeProducts(category: ProductCategoryType) {
        self.category = category
        switch category {
        case .all:
            showAllProducts()
        case .available:
            showAvailableProducts()
        case .favorite:
            showFavoriteProducts()
        }
    }
    
    private func showAllProducts() {
        displayedProductList.send(allProducts)
    }
    
    private func showAvailableProducts() {
        let filtered = allProducts.filter { prodcut in
            return prodcut.available == true
        }
        displayedProductList.send(filtered)
    }
    
    private func showFavoriteProducts() {
        displayedProductList.send(allProducts.filter{ $0.isFavourite })
    }
    
    func getAllProductList(category: ProductCategoryType) {
        // self.isLoading = true
        let service = ProductListService(networkRequest: NativeRequestable(), environment: .development)
        service.getProductList()
            .sink { (completion) in
                DispatchQueue.main.async {
                    // self.isLoading = false
                }
                switch completion {
                case .failure(let error):
                    print("oops got an error \(error.localizedDescription)")
                case .finished:
                    print("nothing much to do here")
                }
            } receiveValue: { (productList) in
                DispatchQueue.main.async {
                    self.headerSection = productList.header
                    self.allProducts = productList.products
                    self.arrangeProducts(category: category)
                    // self.displayedProductList.value = productList.products
                }
            }
            .store(in: &subscriptions)
    }
    
    //MARK: - Navigation
    //TODO Move this logic to Router or coordinator
    func navigateToDetailsView(viewController:UIViewController , products:Product) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let viewModel = ProductDetailsViewModel(product: products)
        if let detailsViewController = storyBoard.instantiateViewController(withIdentifier: "ProductDetailsViewController") as? ProductDetailsViewController {
            detailsViewController.setup(viewModel: viewModel)
            viewController.present(detailsViewController, animated: true)
        }
    }
    func navigateTowebView(viewController:UIViewController) {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = mainStoryboard.instantiateViewController(withIdentifier: "WebViewViewController") as! WebViewViewController
        viewController.present(vc, animated: true)
    }
}
