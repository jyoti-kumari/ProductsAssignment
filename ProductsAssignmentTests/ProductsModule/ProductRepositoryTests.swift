//
//  ProductRepositoryTests.swift
//  ProductsAssignmentTests
//
//  Created by Jyoti Kumari on 31/01/24.
//


import XCTest
import PromiseKit
@testable import ProductsAssignment

final class ProductRepositoryTests: XCTestCase {
    
    var productRepository: ProductRepositoryProtocol!
    var mockProductService: MockProductService!
    
    override func setUp() {
        super.setUp()
        mockProductService = MockProductService()
        productRepository = ProductRepository(apiService: mockProductService)
    }
    
    override func tearDown() {
        mockProductService = nil
        productRepository = nil
        super.tearDown()
    }

    func testProductRepositorySuccess() {
        let expectation = expectation(description: "Product Repository of Success Case")
        mockProductService.response = MockTestData.products
        
        let promise: Promise<ProductDTO> = mockProductService.getProducts()
        promise.done { response in
            // Then
            XCTAssertEqual(response.products?.count, 30)
            expectation.fulfill()
        }.catch { error in
            XCTFail("Error should not occur: \(error)")
        }
        wait(for: [expectation], timeout: 2.0)
    }
    
    func testProductRepositoryFailure() {
        let expectation = expectation(description: "Product Repositoy of Failure Case")
        mockProductService.error = NetworkError.networkError

        let promise: Promise<ProductDTO> = mockProductService.getProducts()
        promise.done { response in
            // Then
            XCTFail("Success not expected")
        }.catch { _ in
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2.0)
    }
    
}
