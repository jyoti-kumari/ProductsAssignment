//
//  MockNetworkManager.swift
//  ProductsAssignmentTests
//
//  Created by Jyoti Kumari on 31/01/24.
//

import XCTest
import PromiseKit
@testable import ProductsAssignment

final class MockNetworkManager: ServiceProtocol {
    
    var response: Decodable?
    var error: Error?
    
    func request<T: Decodable>(_ service: RequestProtocol, responseType: T.Type) -> Promise<T> {
        if let error = error {
            return Promise(error: error)
        }
        let response = response
        return Promise.value(response as! T)
    }
}

