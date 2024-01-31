//
//  MockProductService.swift
//  ProductsAssignmentTests
//
//  Created by Jyoti Kumari on 31/01/24.
//

import XCTest
import PromiseKit
@testable import ProductsAssignment

class MockProductService: ProductServiceProtocol {
    
    var response: ProductDTO?
    var error: Error?
    
    func getProducts() -> Promise<ProductDTO> {
        if let error = error {
            return Promise(error: error)
        }
        return Promise.value(response!)
    }
}
