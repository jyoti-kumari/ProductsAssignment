//
//  ProductsConstants.swift
//  ProductsAssignment
//
//  Created by Jyoti Kumari on 29/01/24.
//

struct StringConstant {
    static let title: String = "Products"
    static let factsLoadFail: String = "Products Loading Failed"
    static let defaultErrorMessage: String = "System Error"
    static let sampleData = ProductData(id: 5, title: "Huawei P30", description: "Huawei’s re-badged P30 Pro New Edition was officially unveiled yesterday in Germany and now the device has made its way to the UK.", price: 499, discountPercentage: 10.58, rating: 4.09, stock: 32, brand: "Huawei", category: "smartphones", thumbnail: "https://cdn.dummyjson.com/product-images/5/thumbnail.jpg")
}

struct URLConstants {
    static let baseURL = "https://dummyjson.com/"
    static let products = "products"
    static let additionalHeadersKey = "Content-Type"
    static let additionalHeaders = "application/json"
}
