//
//  MockFetchProductsUseCase.swift
//  ProductsAssignmentTests
//
//  Created by Jyoti Kumari on 31/01/24.
//

import XCTest
import PromiseKit
@testable import ProductsAssignment

final class MockFetchProductsUseCase: FetchProductsUseCaseProtocol {
    var products: [ProductPresentationData]?
    var error: Error?
    
    func execute() -> Promise<[ProductPresentationData]> {
        if let error = error {
            return Promise(error: error)
        }
        let response = products ?? []
        return Promise.value(response)
    }
}
