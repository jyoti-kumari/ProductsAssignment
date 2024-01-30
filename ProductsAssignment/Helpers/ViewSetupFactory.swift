//
//  ViewSetupFactory.swift
//  ProductsAssignment
//
//  Created by Jyoti Kumari on 29/01/24.
//

import Foundation

class ViewSetupFactory {
    
    static func createProductsListView() -> ProductViewModel {
        let productService = ProductService(apiService: APIManager(), api: .dev)
        let useCaseProtocol = FetchProductsUseCase(productRepository: ProductRepository(apiService: productService))
        let viewModelProtocol = ProductViewModel(fetchProductsUseCaseProtocol: useCaseProtocol)
        return viewModelProtocol
    }
    
}


