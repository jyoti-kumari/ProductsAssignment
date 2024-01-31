//
//  ProductRepository.swift
//  ProductsAssignment
//
//  Created by Jyoti Kumari on 29/01/24.
//

import Foundation
import PromiseKit

protocol ProductRepositoryProtocol {
    func getProducts() -> Promise<[ProductData]>
}

final internal class ProductRepository: ProductRepositoryProtocol {
    
    private let apiService: ProductService
    
    internal init(apiService: ProductService) {
        self.apiService = apiService
    }
    
    func getProducts() -> Promise<[ProductData]> {
        return apiService.getProducts()
    }
}


