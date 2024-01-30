//
//  Request.swift
//  ProductsAssignmentTests
//
//  Created by Jyoti Kumari on 30/01/24.
//

import Foundation
@testable import ProductsAssignment

struct MockRequest: RequestProtocol {
    var requestQueryParam: String = ""
    var apiKey: String = ""
    var httpMethod: HTTPMethod = .get
    var requestParams: [String: Any]?
    var additionalHeaders: [String: String]?
    let requestURL: String = ""
}
