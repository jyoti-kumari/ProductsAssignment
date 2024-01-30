//
//  ProductServiceTest.swift
//  ProductsAssignmentTests
//
//  Created by Jyoti Kumari on 30/01/24.
//

import XCTest
import PromiseKit
@testable import ProductsAssignment

class ProductServiceTest: XCTestCase {
    var session: MockURLSession!
    
    override func setUp() {
        super.setUp()
        session = MockURLSession()
    }
    
    override func tearDown() {
        session = nil
        super.tearDown()
    }
    
    // Test successful API request
    func testAPIRequestSuccess() {
        // Given
        
        session.data = """
            {
                "total": 100,
                "skip": 0,
                "limit": 30,
              "products": [
                    {
                      "id": 30,
                      "title": "Key Holder",
                      "description": "Attractive DesignMetallic materialFour key hooksReliable & DurablePremium Quality",
                      "price": 30,
                      "discountPercentage": 2.92,
                      "rating": 4.92,
                      "stock": 54,
                      "brand": "Golden",
                      "category": "home-decoration",
                      "thumbnail": "https://cdn.dummyjson.com/product-images/30/thumbnail.jpg",
                      "images": [
                        "https://cdn.dummyjson.com/product-images/30/1.jpg",
                        "https://cdn.dummyjson.com/product-images/30/2.jpg",
                        "https://cdn.dummyjson.com/product-images/30/3.jpg",
                        "https://cdn.dummyjson.com/product-images/30/thumbnail.jpg"
                      ]
                    }]
            }
            """.data(using: .utf8)
        
        let sessionManager = APIManager(session: session)
        let service = ProductService(apiService: sessionManager, api: .test)
        
        // When
        let expectation = XCTestExpectation(description: "API request")
        let promise: Promise<[ProductData]> = service.getProducts()
        promise.done { response in
            // Then
            XCTAssertNotNil(response)
            expectation.fulfill()
        }.catch { error in
            XCTFail("Error should not occur: \(error)")
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    // Test API request failure
    func testAPIRequestFailure() {
        // Given
        let mockError = NSError(domain: "TestErrorDomain", code: 123, userInfo: nil)
        
        session.error = mockError
        
        let sessionManager = APIManager(session: session)
        let service = ProductService(apiService: sessionManager, api: .test)
        
        // When
        let expectation = XCTestExpectation(description: "API request")
        let promise: Promise<[ProductData]> = service.getProducts()
        
        promise.done { _ in
            XCTFail("Promise should not fulfill")
        }.catch { error in
            // Then
            XCTAssertEqual(error as NSError, mockError)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    // Test API request with no data
    func testAPIRequestNoData() {
        
        session.data = nil
        
        let sessionManager = APIManager(session: session)
        let service = ProductService(apiService: sessionManager, api: .test)
        
        // When
        let expectation = XCTestExpectation(description: "API request with no data")
        let promise: Promise<[ProductData]> = service.getProducts()
        
        promise.done { _ in
            XCTFail("Promise should not fulfill")
        }.catch { error in
            // Then
            XCTAssertTrue(error is APIError)
            XCTAssertEqual(error as? APIError, APIError.noData)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
}

extension APISetUp {
    static var test: Self {
        APISetUp(environment: ProductEnvironment())
    }
}


