//
//  ProductData.swift
//  ProductsAssignment
//
//  Created by Jyoti Kumari on 29/01/24.
//


struct ProductDomainData {
    let id: Int
    let title: String
    let description: String
    let price: Float
    let discountPercentage: Float
    let rating: Float
    let stock: Float
    let brand: String
    let category: String
    let thumbnail: String
}

extension ProductDomainData {
    
    func toPresentation() -> ProductPresentationData {
        return .init(id: id, title: title, description: description, price: price, brand: brand, category: category, thumbnail: thumbnail)
    }
}
