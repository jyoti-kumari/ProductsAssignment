//
//  AppDIRegistry.swift
//  ProductsAssignment
//
//  Created by Jyoti Kumari on 31/01/24.
//

final class AppDIRegistry {
    var networkManager: NetworkProtocol {
        NetworkManager(session: SharedURLSession.shared)
    }
    
    lazy var productViewModel: ProductViewModel = {
        let productsModule = ProductsModule(networkManager: networkManager)
        return productsModule.createProductsListView()
    }()
}
