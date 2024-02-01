//
//  ProductViewModel.swift
//  ProductsAssignment
//
//  Created by Jyoti Kumari on 29/01/24.
//

import Foundation

protocol ProductViewModelProtocol: ObservableObject {
    var products: [ProductPresentationData] { get }
    var title: String { get }
    var errorMessage: String { get }
    func getProducts()
}

final class ProductViewModel: ProductViewModelProtocol {
    @Published var products: [ProductPresentationData] = []
    @Published var isLoading: Bool = false
    @Published var showError: Bool = false
    
    var title: String = StringConstant.title
    var errorMessage: String = ""
    
    // MARK: - Dependencies
    
    let fetchProductsUseCaseProtocol: FetchProductsUseCaseProtocol
    
    // MARK: - Initialization
    
    init(fetchProductsUseCaseProtocol: FetchProductsUseCaseProtocol) {
        self.fetchProductsUseCaseProtocol = fetchProductsUseCaseProtocol
    }
    
    // MARK: - Get Products Methods
    
    func getProducts() {
        isLoading = true
        fetchProductsUseCaseProtocol.execute()
            .done() { [weak self] data in
                self?.isLoading = false
                self?.products = data
            }
            .catch() { error in
                self.isLoading = false
                self.showError = true
                self.errorMessage = error.localizedDescription
            }
    }
}

