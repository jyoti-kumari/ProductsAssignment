//
//  APIService.swift
//  ProductsAssignment
//
//  Created by Jyoti Kumari on 29/01/24.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case networkError
    case decodingError
}


enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

struct URLConstants {
    static let additionalHeadersKey = "Content-Type"
    static let additionalHeaders = "application/json"
}

protocol RequestProtocol {
    var httpMethod: HTTPMethod {get set}
    var requestURL: String {get}
    var requestParams: [String: Any]? {get}
    var additionalHeaders: [String: String]? {get}
    var requestQueryParam: String {get set}

}

final class BaseRequest: RequestProtocol {
    var httpMethod: HTTPMethod = .get
    var requestURL: String = ""
    var requestParams: [String: Any]?
    var additionalHeaders: [String: String]?
    var requestQueryParam: String = ""

    init() {
        self.additionalHeaders = [URLConstants.additionalHeadersKey : URLConstants.additionalHeaders]
    }
}
