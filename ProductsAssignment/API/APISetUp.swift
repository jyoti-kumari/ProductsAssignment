//
//  APISetUp.swift
//  ProductsAssignment
//
//  Created by Jyoti Kumari on 29/01/24.
//

import Foundation

struct APISetUp {
    let environment: Environment
    
    init(environment: Environment) {
        self.environment = environment
    }
}

extension APISetUp {
    var productsURL: URL { URL(string: (URLConstants.baseURL + URLConstants.products))! }
    var moreProductsURL: URL { getURL(path: URLConstants.products) }
}

fileprivate extension APISetUp {
    func getURL(path: String) ->  URL {
        URL(string: "\(environment.baseURL)/\(path)")!
    }
}
