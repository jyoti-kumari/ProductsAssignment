//
//  ProductImage.swift
//  ProductsAssignment
//
//  Created by Jyoti Kumari on 29/01/24.
//

import SwiftUI

struct ProductImage: View {
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
        .frame(width: 50, height: 50)
    }
}

#Preview {
    ProductImage(imageURL: StringConstant.sampleData.thumbnail)
}
