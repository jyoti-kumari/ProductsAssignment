//
//  RepositoryInterface.swift
//  ProductsAssignment
//
//  Created by Jyoti Kumari on 08/02/24.
//


protocol ProductRepositoryProtocol {
    func getProducts() -> Promise<[ProductDomainData]>
}
