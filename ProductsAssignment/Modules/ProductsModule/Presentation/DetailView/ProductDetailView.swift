//
//  ProductDetailView.swift
//  ProductsAssignment
//
//  Created by Jyoti Kumari on 29/01/24.
//

import SwiftUI

struct ProductDetailView: View {
    var productDetail
    : ProductPresentationData
    var body: some View {
        ScrollView {
            ProductDetailImage(imageURL: productDetail.thumbnail)
            VStack(alignment: .leading) {
                Text(productDetail.title)
                    .font(.title)
                
                Text(productDetail.brand)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                Divider()
                Text(productDetail.description)
            }
        }
        .padding(.leading, 15)
        .padding(.trailing, 15)
        .navigationTitle(productDetail.category)
        .navigationBarTitleDisplayMode(.inline)
    }
    
}

#Preview {
    ProductDetailView(productDetail: MockData.mockProduct)
}
