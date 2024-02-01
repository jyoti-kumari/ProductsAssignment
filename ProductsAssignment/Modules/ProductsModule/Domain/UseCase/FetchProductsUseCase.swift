//
//  FetchProductsUseCase.swift
//  ProductsAssignment
//
//  Created by Jyoti Kumari on 29/01/24.
//

import Foundation
import PromiseKit

protocol FetchProductsUseCaseProtocol {
    func execute() -> Promise<[ProductPresentationData]>
}

final class FetchProductsUseCase: FetchProductsUseCaseProtocol {
    private let productRepository: ProductRepositoryProtocol
    
    init(productRepository: ProductRepositoryProtocol) {
        self.productRepository = productRepository
    }
    
    func execute() -> Promise<[ProductPresentationData]> {
        return Promise { seal in
            productRepository.getProducts()
                .done { response in
                    seal.fulfill( response.map { $0.toPresentation() })
                }
                .catch { error in
                    seal.reject(error)
                }
        }
    }
}
