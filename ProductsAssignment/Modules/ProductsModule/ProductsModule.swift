//
//  ProductsModule.swift
//  ProductsAssignment
//
//  Created by Jyoti Kumari on 31/01/24.
//

import Foundation

final class ProductsModule {
    private let networkManager: NetworkManager
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func createProductsListView() -> ProductViewModel {
        let viewModel = generateViewModel()
        return viewModel
    }
    
    private func generateViewModel() -> ProductViewModel {
        let viewModel = ProductViewModel(fetchProductsUseCaseProtocol: generateProductUseCase())
        return viewModel
    }
    
    private func generateProductUseCase() -> FetchProductsUseCase {
        let useCase = FetchProductsUseCase(productRepository: generateProductRepository())
        return useCase
    }
    
    private func generateProductRepository() -> ProductRepository {
        let repository = ProductRepository(apiService: generateProductService())
        return repository
    }
    
    private func generateProductService() -> ProductServiceProtocol {
        let service = ProductService(apiService: networkManager)
        return service
    }
}

