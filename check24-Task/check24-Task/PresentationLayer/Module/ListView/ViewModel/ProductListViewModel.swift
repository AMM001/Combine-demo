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
    func getAllProductList()
    func navigateToDetailsView(viewController:UIViewController ,products:Product)
    
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
    
    var subscriptions = Set<AnyCancellable>()

    func getAllProductList() {
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
                    self.displayedProductList.value = productList.products
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
}
