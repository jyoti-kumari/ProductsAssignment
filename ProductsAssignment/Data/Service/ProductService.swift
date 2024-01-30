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
    private let api: APISetUp
    
    internal init(apiService: ServiceProtocol, api: APISetUp) {
        self.apiService = apiService
        self.api = api
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
        productsRequest.requestURL = api.productsURL.absoluteString
        return productsRequest
    }
}
