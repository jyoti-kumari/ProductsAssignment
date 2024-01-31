//
//  ProductDTO.swift
//  ProductsAssignment
//
//  Created by Jyoti Kumari on 29/01/24.
//

struct ProductDTO: Decodable {
    let total: Int?
    let skip: Int?
    let limit: Int?
    let products: [ProductItemDTO]?
}

struct ProductItemDTO: Decodable {
    let id: Int?
    let title: String?
    let description: String?
    let price: Float?
    let discountPercentage: Float?
    let rating: Float?
    let stock: Float?
    let brand: String?
    let category: String?
    let thumbnail: String?
    let images: [String]?
}
