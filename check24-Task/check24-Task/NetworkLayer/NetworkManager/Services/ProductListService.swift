//
//  ProductListService.swift
//  check24-Task
//
//  Created by admin on 22/05/2023.
//

import Combine 
import Foundation

protocol ProductListServiceable {
    func getProductList() -> AnyPublisher<ProductListModel, NetworkError>
}

class ProductListService: ProductListServiceable {

    private var networkRequest: Requestable
    private var environment: Environment = .development
    
  // inject this for testability
    init(networkRequest: Requestable, environment: Environment) {
        self.networkRequest = networkRequest
        self.environment = environment
    }

    func getProductList() -> AnyPublisher<ProductListModel, NetworkError> {
        let endpoint = ServiceEndpoints.getProductListService
        let request = endpoint.createRequest(token: "",
                                             environment: self.environment)
        return self.networkRequest.request(request)
    }
}
