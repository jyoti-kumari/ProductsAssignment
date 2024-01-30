//
//  ProductViewModelTests.swift
//  ProductsAssignmentTests
//
//  Created by Jyoti Kumari on 30/01/24.
//

import XCTest
import PromiseKit
@testable import ProductsAssignment

final class ProductViewModelTests: XCTestCase {
    
    var viewModel: ProductViewModel!
    
    class MockFetchProductsUseCase: FetchProductsUseCaseProtocol {
        var products: [ProductData]?
        var error: Error?
        
        func execute() -> Promise<[ProductData]> {
            if let error = error {
                return Promise(error: error)
            }
            let response = products ?? []
            return Promise.value(response)
        }
    }
    
    override func setUp() {
        viewModel = ProductViewModel(fetchProductsUseCaseProtocol: MockFetchProductsUseCase())
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    // Test fetching products successfully
    func testFetchProductsSuccess() {
        // Given
        let expectation = XCTestExpectation(description: "Fetch products successfully")
        
        let mockResponse = MockResponseManager.loadMockResponse(ofType: ProductDTO.self, from: "Products")
        
        if let useCase = viewModel.fetchProductsUseCaseProtocol as? MockFetchProductsUseCase {
            useCase.products = ProductMapper.getProduct(dataApiResponse: mockResponse)
        }
        // When
        let promise: Promise<[ProductData]> = viewModel.fetchProductsUseCaseProtocol.execute()
        
        promise.done { response in
            // Then
            XCTAssertNotNil(self.viewModel.products)
            expectation.fulfill()
        }.catch { error in
            XCTFail("Error should not occur: \(error)")
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    // Test fetching products with an error
    func testFetchProductsError() {
        // Given
        let expectation = XCTestExpectation(description: "Fetch products with error")
        
        let mockError = NSError(domain: "TestErrorDomain", code: 123, userInfo: nil)
        if let useCase = viewModel.fetchProductsUseCaseProtocol as? MockFetchProductsUseCase {
            useCase.error = mockError
        }
        // When
        let promise: Promise<[ProductData]> = viewModel.fetchProductsUseCaseProtocol.execute()
        
        promise.done { _ in
            XCTFail("Promise should not fulfill")
        }.catch { error in
            // Then
            XCTAssertEqual(error as NSError, mockError)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)

    }
    
}


