//
//  ProductDetailImage.swift
//  ProductsAssignment
//
//  Created by Jyoti Kumari on 29/01/24.
//

import SwiftUI

struct ProductDetailImage: View {
    var imageURL: String
    var body: some View {
        AsyncImage(url: URL(string: imageURL)) { image in
                image
                .resizable()
        } placeholder: {
            Image("default")
            .resizable()
            .scaledToFill()
        }
        .frame(height: 200)
    }
}


#Preview {
    ProductDetailImage(imageURL: MockData.mockProduct.thumbnail)
}

