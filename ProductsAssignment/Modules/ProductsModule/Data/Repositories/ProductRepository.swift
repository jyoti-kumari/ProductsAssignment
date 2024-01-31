//
//  ProductRepository.swift
//  ProductsAssignment
//
//  Created by Jyoti Kumari on 29/01/24.
//

import Foundation
import PromiseKit

protocol ProductRepositoryProtocol {
    func getProducts() -> Promise<[ProductDomainData]>
}

final internal class ProductRepository: ProductRepositoryProtocol {
    
    private let apiService: ProductServiceProtocol
    
    internal init(apiService: ProductServiceProtocol) {
        self.apiService = apiService
    }
    
    func getProducts() -> Promise<[ProductDomainData]> {
        return Promise { seal in
            self.apiService.getProducts()
                .done { response in
                    seal.fulfill(ProductMapper.getProduct(dataApiResponse: response))
                }
                .catch { error in
                    seal.reject(error)
                }
        }
    }
}


