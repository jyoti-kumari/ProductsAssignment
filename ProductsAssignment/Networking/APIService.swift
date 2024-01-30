//
//  APIService.swift
//  ProductsAssignment
//
//  Created by Jyoti Kumari on 29/01/24.
//

import Foundation

enum APIError: Error {
    case invalidURL
    case noData
    case networkError
    case decodingError
}


enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

protocol RequestProtocol {
    var httpMethod: HTTPMethod {get set}
    var requestURL: String {get}
    var requestParams: [String: Any]? {get}
    var additionalHeaders: [String: String]? {get}
    var requestQueryParam: String {get set}
    var apiKey: String {get set}

}

class BaseRequest: RequestProtocol {
    var httpMethod: HTTPMethod = .get
    var requestURL: String = ""
    var requestParams: [String: Any]?
    var additionalHeaders: [String: String]?
    var requestQueryParam: String = ""
    var apiKey: String = ""

    init() {
        self.additionalHeaders = [URLConstants.additionalHeadersKey : URLConstants.additionalHeaders]
    }
}
