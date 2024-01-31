//
//  ProductService.swift
//  ProductsAssignment
//
//  Created by Jyoti Kumari on 29/01/24.
//

import Foundation
import PromiseKit

class ProductService {
    
    private let apiService: ServiceProtocol
    
    internal init(apiService: ServiceProtocol) {
        self.apiService = apiService
    }
    
    func getProducts() -> Promise<[ProductData]> {
        return Promise { seal in
            self.apiService.request(getRequest(), responseType: ProductDTO.self)
                .done { response in
                    seal.fulfill(ProductMapper.getProduct(dataApiResponse: response))
                }
                .catch { error in
                    seal.reject(error)
                }
        }
    }
    
    fileprivate func getRequest() -> BaseRequest {
        let productsRequest = BaseRequest()
        productsRequest.requestQueryParam = "country=in"
        productsRequest.requestURL = Configuration.host
        return productsRequest
    }
}
