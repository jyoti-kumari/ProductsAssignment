//
//  FetchProductsUseCaseTests.swift
//  ProductsAssignmentTests
//
//  Created by Jyoti Kumari on 30/01/24.
//

import XCTest
import PromiseKit
@testable import ProductsAssignment

class FetchProductsUseCaseTests: XCTestCase {
    
    // Mock  ProductRepository for testing
    class MockProductRepository: ProductRepositoryProtocol {
        var apiResponse: [ProductData]?
        var error: Error?
        func getProducts() -> PromiseKit.Promise<[ProductData]> {
            if let error = error {
                return Promise(error: error)
            }
            if let productApiResponse = apiResponse {
                return Promise.value(productApiResponse)
            }
            return Promise(error: NetworkError.noData) // Default to no data
        }
    }
    
    var repository: MockProductRepository!

    override func setUp() {
        super.setUp()
        repository = MockProductRepository()
    }
    
    override func tearDown() {
        repository = nil
        super.tearDown()
    }
    
    // Test fetching products successfully
    func testFetchProductSuccess() {
        // Given
        guard let mockApiResponse = MockResponseManager.loadMockResponse(ofType: ProductDTO.self, from: "Products") else {
            return
        }
        repository.apiResponse = ProductMapper.getProduct(dataApiResponse: mockApiResponse)
        
        let useCase = FetchProductsUseCase(productRepository: repository)
        
        // When
        let expectation = XCTestExpectation(description: "Fetch products successfully")
        let promise: Promise<[ProductData]> = useCase.execute()
        
        promise.done { response in
            // Then
            XCTAssertEqual(response.count, 3)
            expectation.fulfill()
        }.catch { error in
            XCTFail("Error should not occur: \(error)")
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    // Test fetching products with an error
    func testFetchProductError() {
        // Given
        let mockError = NSError(domain: "TestErrorDomain", code: 123, userInfo: nil)
        repository.error = mockError
        
        let useCase = FetchProductsUseCase(productRepository: repository)
        
        // When
        let expectation = XCTestExpectation(description: "Fetch products with error")
        let promise: Promise<[ProductData]> = useCase.execute()
        
        promise.done { _ in
            XCTFail("Promise should not fulfill")
        }.catch { error in
            // Then
            XCTAssertEqual(error as NSError, mockError)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    // Test fetching Product with no data
    func testFetchProductNoData() {
        // Given

        let useCase = FetchProductsUseCase(productRepository: repository)
        
        // When
        let expectation = XCTestExpectation(description: "Fetch products with no data")
        let promise: Promise<[ProductData]> = useCase.execute()
        
        promise.done { _ in
            XCTFail("Promise should not fulfill")
        }.catch { error in
            // Then
            XCTAssertTrue(error is NetworkError)
            XCTAssertEqual(error as? NetworkError, NetworkError.noData)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
}

