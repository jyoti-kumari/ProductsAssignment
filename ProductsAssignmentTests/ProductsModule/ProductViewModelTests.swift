//
//  ProductViewModelTests.swift
//  ProductsAssignmentTests
//
//  Created by Jyoti Kumari on 31/01/24.
//

import XCTest
import PromiseKit
@testable import ProductsAssignment

class ProductViewModelTests: XCTestCase {
    
    var viewModel: ProductViewModel!
    var mockProductUseCase: MockFetchProductsUseCase!
    
    override func setUp() {
        super.setUp()
        mockProductUseCase = MockFetchProductsUseCase()
        viewModel = ProductViewModel(fetchProductsUseCaseProtocol: mockProductUseCase)
    }
    
    override func tearDown() {
        viewModel = nil
        mockProductUseCase = nil
        super.tearDown()
    }
    
    // Test fetching products successfully
    func testFetchProductsSuccess() {
        // Given
        let expectation = XCTestExpectation(description: "Fetch products successfully")
        
        // When
        let promise: Promise<[ProductPresentationData]> = mockProductUseCase.execute()
        
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
        mockProductUseCase.error = mockError
        // When
        let promise: Promise<[ProductPresentationData]> = mockProductUseCase.execute()
        
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

