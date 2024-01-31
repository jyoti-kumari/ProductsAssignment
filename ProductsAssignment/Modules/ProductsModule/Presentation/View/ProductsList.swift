//
//  ProductsList.swift
//  ProductsAssignment
//
//  Created by Jyoti Kumari on 29/01/24.
//

import SwiftUI

struct ProductsList: View {
    
    var products: [ProductData]
    var body: some View {
        NavigationSplitView {
            List(products, id: \.id) { product in
                NavigationLink {
                    ProductDetailView(productDetail: product)
                } label: {
                    ProductRow(product: product)
                }
            }
            .navigationTitle("Products")
            .navigationBarTitleDisplayMode(.inline)
        } detail: {
            Text("Select Product")
        }
    }
}

#Preview {
    ProductsList(products: [MockData.mockProduct])
}
