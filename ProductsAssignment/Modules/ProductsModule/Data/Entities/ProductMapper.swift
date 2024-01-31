//
//  ProductMapper.swift
//  ProductsAssignment
//
//  Created by Jyoti Kumari on 29/01/24.
//

struct ProductMapper {
    static func getProduct(dataApiResponse: ProductDTO?) -> [ProductData] {
        guard let products = dataApiResponse?.products else {
            return []
        }
        
        return products.map { product in
            let id = product.id
            let title = product.title
            let description = product.description
            let price = product.price
            let discountPercentage = product.discountPercentage
            let rating = product.rating
            let stock = product.stock
            let brand = product.brand
            let category = product.category
            let thumbnail = product.thumbnail
                        
            return ProductData(id: id ?? 0, title: title ?? "", description: description ?? "", price: price ?? 0.0, discountPercentage: discountPercentage ?? 0.0, rating: rating ?? 0.0, stock: stock ?? 0.0, brand: brand ?? "", category: category ?? "", thumbnail: thumbnail ?? "")
        }
    }
}

