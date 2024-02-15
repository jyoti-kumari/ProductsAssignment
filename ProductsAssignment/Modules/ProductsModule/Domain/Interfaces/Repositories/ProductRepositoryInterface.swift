//
//  RepositoryInterface.swift
//  ProductsAssignment
//
//  Created by Jyoti Kumari on 08/02/24.
//

import PromiseKit

protocol ProductRepositoryProtocol {
    func getProducts() -> Promise<[ProductDomainData]>
}
