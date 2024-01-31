//
//  ProductViewModel.swift
//  ProductsAssignment
//
//  Created by Jyoti Kumari on 29/01/24.
//

import Foundation

protocol ProductViewModelProtocol: ObservableObject {
    func getProducts()
    var products: [ProductData] { get }
    var title: String { get }
    var errorMessage: String { get }
}

class ProductViewModel: ProductViewModelProtocol {
    @Published var products: [ProductData] = []
    var title: String = StringConstant.title
    var errorMessage: String = ""
    @Published var isLoading: Bool = false
    // MARK: - Dependencies
    
    let fetchProductsUseCaseProtocol: FetchProductsUseCaseProtocol
    
    // MARK: - Initialization
    
    init(fetchProductsUseCaseProtocol: FetchProductsUseCaseProtocol) {
        self.fetchProductsUseCaseProtocol = fetchProductsUseCaseProtocol
    }
    
    // MARK: - Public Methods
    func getProducts() {
        isLoading = true
        fetchProductsUseCaseProtocol.execute()
            .done() { [weak self] data in
                self?.isLoading = false
                self?.products = data
            }
            .catch() { error in
                self.isLoading = false
                self.errorMessage = error.localizedDescription
                print(error.localizedDescription)
            }
    }
}

