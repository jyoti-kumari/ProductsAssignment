//
//  ProductServiceTests.swift
//  ProductsAssignmentTests
//
//  Created by Jyoti Kumari on 31/01/24.
//

import XCTest
import PromiseKit
@testable import ProductsAssignment

final class ProductServiceTests: XCTestCase {

    var productService: ProductServiceProtocol!
    var mockNetworkManager: MockNetworkManager!

    override func setUp() {
        super.setUp()
        mockNetworkManager = MockNetworkManager()
        productService = ProductService(apiService: mockNetworkManager)
    }
    
    override func tearDown() {
        productService = nil
        mockNetworkManager = nil
        super.tearDown()
    }
    
    func testProductServiceSuccess() {
        let expectation = expectation(description: "Product Service on Success Case")
        mockNetworkManager.response = MockTestData.products     
        
        let promise: Promise<ProductDTO> = productService.getProducts()
        promise.done { response in
            // Then
            XCTAssertEqual(response.products?.count, 30)
            expectation.fulfill()
        }.catch { error in
            XCTFail("Error should not occur: \(error)")
        }
        wait(for: [expectation], timeout: 2.0)
    }

    func testProductServiceFailure() {
        let expectation = expectation(description: "Product Service on Failure Case")
        mockNetworkManager.error = NSError(domain: "FailedError", code: 0)
        let promise: Promise<ProductDTO> = productService.getProducts()
        promise.done { response in
            // Then
            XCTFail("Success not expected")
        }.catch { _ in
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2.0)
    }
}

