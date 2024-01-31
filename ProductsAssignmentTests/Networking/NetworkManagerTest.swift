//
//  NetworkManagerTest.swift
//  ProductsAssignmentTests
//
//  Created by Jyoti Kumari on 30/01/24.
//

import XCTest
import PromiseKit
@testable import ProductsAssignment

class NetworkManagerTest: XCTestCase {
    
    var session: MockURLSession!
    var networkManager: NetworkManager!
    var request: MockRequest!
    
    override func setUp() {
        super.setUp()
        session = MockURLSession()
        request = MockRequest()
        networkManager = NetworkManager(session: session)
        
    }
    
    override func tearDown() {
        session = nil
        networkManager = nil
        request = nil
        super.tearDown()
    }
    // Test successful API request
    func testNetworkManagerRequestSuccess() {
        // Given
        
        session.data = """
            {
                "title": "Test ",
                "description": "This is a description"
            }
            """.data(using: .utf8)
        
        // When
        let expectation = XCTestExpectation(description: "API request")
        let promise: Promise<MockResponse> = networkManager.request(request, responseType: MockResponse.self)
        
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
    func testNetworkManagerRequestFailure() {
        // Given
        let mockError = NSError(domain: "TestErrorDomain", code: 123, userInfo: nil)
        
        session.error = mockError
                
        // When
        let expectation = XCTestExpectation(description: "API request")
        let promise: Promise<MockResponse> = networkManager.request(request, responseType: MockResponse.self)
        
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
    func testNetworkManagerRequestNoData() {
        
        session.data = nil
        
        // When
        let expectation = XCTestExpectation(description: "API request with no data")
        let promise: Promise<MockResponse> = networkManager.request(request, responseType: MockResponse.self)
        
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
    func testNetworkManagerRequestDecodingError() {
        // Given
        let mockData = """
            {
                "invalidKey": "Test Article"
            }
            """.data(using: .utf8)
        
        session.data = mockData
        // When
        let expectation = XCTestExpectation(description: "API request with decoding error")
        let promise: Promise<MockResponse> = networkManager.request(request, responseType: MockResponse.self)
        
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
extension NetworkManagerTest {
    struct MockResponse: Decodable {
        var title: String = ""
        var description: String = ""
    }
}

