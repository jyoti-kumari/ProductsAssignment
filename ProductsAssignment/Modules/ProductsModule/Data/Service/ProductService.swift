//
//  ProductService.swift
//  ProductsAssignment
//
//  Created by Jyoti Kumari on 29/01/24.
//

import Foundation
import PromiseKit

protocol ProductServiceProtocol {
    func getProducts() -> Promise<ProductDTO>
}

final class ProductService: ProductServiceProtocol {
    
    private let apiService: NetworkProtocol
    
    init(apiService: NetworkProtocol) {
        self.apiService = apiService
    }
    
    func getProducts() -> Promise<ProductDTO> {
        return apiService.request(getRequest(), responseType: ProductDTO.self)
    }
    
    fileprivate func getRequest() -> BaseRequest {
        let productsRequest = BaseRequest()
        productsRequest.requestQueryParam = "country=in"
        productsRequest.requestURL = Configuration.host
        return productsRequest
    }
}
