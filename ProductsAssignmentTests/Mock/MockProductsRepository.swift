//
//  MockProductsRepository.swift
//  ProductsAssignmentTests
//
//  Created by Jyoti Kumari on 31/01/24.
//

import XCTest
import PromiseKit
@testable import ProductsAssignment

final class MockProductsRepository: ProductRepositoryProtocol {
    
    var products: [ProductDomainData]?
    var error: Error?
    
    func getProducts() -> Promise<[ProductDomainData]> {
        if let error = error {
            return Promise(error: error)
        }
        let response = products ?? []
        return Promise.value(response)
    }
}
