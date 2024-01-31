//
//  APIManagerTest.swift
//  ProductsAssignmentTests
//
//  Created by Jyoti Kumari on 30/01/24.
//

import XCTest
import PromiseKit
@testable import ProductsAssignment

class APIManagerTest: XCTestCase {
    
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
                "title": "Test ",
                "description": "This is a description"
            }
            """.data(using: .utf8)
        
        let sessionManager = NetworkManager(session: session)
        
        let request = MockRequest()
        
        // When
        let expectation = XCTestExpectation(description: "API request")
        let promise: Promise<MockResponse> = sessionManager.request(request, responseType: MockResponse.self)
        
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
        
        let sessionManager = NetworkManager(session: session)
        let request = MockRequest()
        
        // When
        let expectation = XCTestExpectation(description: "API request")
        let promise: Promise<MockResponse> = sessionManager.request(request, responseType: MockResponse.self)
        
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
        
        let sessionManager = NetworkManager(session: session)
        let request = MockRequest()
        
        // When
        let expectation = XCTestExpectation(description: "API request with no data")
        let promise: Promise<MockResponse> = sessionManager.request(request, responseType: MockResponse.self)
        
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
    // Test API request with decoding error
    func testAPIRequestDecodingError() {
        // Given
        let mockData = """
            {
                "invalidKey": "Test Article"
            }
            """.data(using: .utf8)
        
        session.data = mockData
        
        let sessionManager = NetworkManager(session: session)
        let request = MockRequest()
        
        // When
        let expectation = XCTestExpectation(description: "API request with decoding error")
        let promise: Promise<MockResponse> = sessionManager.request(request, responseType: MockResponse.self)
        
        promise.done { _ in
            XCTFail("Promise should not fulfill")
        }.catch { error in
            // Then
            XCTAssertTrue(error is NetworkError)
            XCTAssertEqual(error as? NetworkError, NetworkError.decodingError)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
}

// Mock implementations for testing
extension APIManagerTest {
    struct MockResponse: Decodable {
        var title: String = ""
        var description: String = ""
    }
}
