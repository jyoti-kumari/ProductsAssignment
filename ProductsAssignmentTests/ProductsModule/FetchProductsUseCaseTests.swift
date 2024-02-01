//
//  FetchProductsUseCaseTests.swift
//  ProductsAssignmentTests
//
//  Created by Jyoti Kumari on 31/01/24.
//

import XCTest

import PromiseKit
@testable import ProductsAssignment

final class FetchProductsUseCaseTests: XCTestCase {
    
    var productsUseCase: FetchProductsUseCaseProtocol!
    var mockProductsRepository: MockProductsRepository!
    
    override func setUp() {
        super.setUp()
        mockProductsRepository = MockProductsRepository()
        productsUseCase = FetchProductsUseCase(productRepository: mockProductsRepository)
    }
    
    override func tearDown() {
        mockProductsRepository = nil
        productsUseCase = nil
        super.tearDown()
    }
    
    func testProductUseCaseSuccess() {
        let expectation = expectation(description: "ProductsUseCase Success Case")
        mockProductsRepository.products = MockTestData.domainProducts
        
        let promise: Promise<[ProductPresentationData]> = productsUseCase.execute()
        
        promise.done { response in
            // Then
            XCTAssertEqual(response.count, 30)
            expectation.fulfill()
        }.catch { error in
            XCTFail("Error should not occur: \(error)")
        }
        wait(for: [expectation], timeout: 2.0)
    }
    
    func testProductUseCaseFailure() {
        let expectation = expectation(description: "ProductUseCase Failure Case")
        mockProductsRepository.error = NSError(domain: "Failed_Error", code: 0)
        let promise: Promise<[ProductPresentationData]> = productsUseCase.execute()
        
        promise.done { _ in
            // Then
            XCTFail("Success not expected")
        }.catch { _ in
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2.0)
    }
}
