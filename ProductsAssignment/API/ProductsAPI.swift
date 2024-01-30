//
//  ProductsAPI.swift
//  ProductsAssignment
//
//  Created by Jyoti Kumari on 29/01/24.
//

import Foundation

struct ProductEnvironment: Environment {
    let baseURL: String = URLConstants.baseURL
}

extension APISetUp {
    static var dev: Self {
        APISetUp(environment: ProductEnvironment())
    }
}
