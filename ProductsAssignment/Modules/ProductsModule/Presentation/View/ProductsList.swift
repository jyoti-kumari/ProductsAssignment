//
//  ProductsList.swift
//  ProductsAssignment
//
//  Created by Jyoti Kumari on 29/01/24.
//

import SwiftUI

struct ProductsList: View {
    
    var products: [ProductPresentationData]
    var body: some View {
        NavigationStack {
            List(products, id: \.id) { product in
                NavigationLink {
                    ProductDetailView(productDetail: product)
                } label: {
                    ProductRow(product: product)
                }
            }
            .navigationTitle("Products")
            .navigationBarTitleDisplayMode(.inline)
        } 
    }
}

#Preview {
    ProductsList(products: [MockData.mockProduct])
}
