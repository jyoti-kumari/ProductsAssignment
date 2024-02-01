//
//  MockData.swift
//  ProductsAssignmentTests
//
//  Created by Jyoti Kumari on 31/01/24.
//
import Foundation
@testable import ProductsAssignment

final class MockTestData {
    
    static var products: ProductDTO {
        try! JSONDecoder().decode(ProductDTO.self, from: productsData)
    }
    
    static var domainProducts: [ProductDomainData] {
        return ProductMapper.getProduct(dataApiResponse: products)
    }
    
    static var productList: [ProductPresentationData] {
        return domainProducts.map { $0.toPresentation() }
    }
    
    static var productsData: Data {
        loadJsonData("Products")
    }
    
    static func loadJsonData(_ fromFile: String) -> Data {
        let path = Bundle(for: self).path(forResource: fromFile, ofType: "json")
        let jsonString = try! String(contentsOfFile: path!, encoding: .utf8)
        let data = jsonString.data(using: .utf8)!
        return data
    }
}

