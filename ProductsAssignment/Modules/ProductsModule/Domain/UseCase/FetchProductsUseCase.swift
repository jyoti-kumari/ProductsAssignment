//
//  FetchProductsUseCase.swift
//  ProductsAssignment
//
//  Created by Jyoti Kumari on 29/01/24.
//

import Foundation
import PromiseKit

protocol FetchProductsUseCaseProtocol {
    func execute() -> Promise<[ProductData]>
}

class FetchProductsUseCase: FetchProductsUseCaseProtocol {
    private let productRepository: ProductRepositoryProtocol
    
    init(productRepository: ProductRepositoryProtocol) {
        self.productRepository = productRepository
    }
    
    func execute() -> Promise<[ProductData]> {
        return productRepository.getProducts()
    }
}
