//
//  ProductImage.swift
//  ProductsAssignment
//
//  Created by Jyoti Kumari on 29/01/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct ProductImage: View {
    var imageURL: String
    var body: some View {
        WebImage(url: URL(string: imageURL))
            .resizable()
            .placeholder(Image("default"))
            .indicator(.activity)
            .transition(.fade(duration: 0.5))
            .scaledToFit()
    }
}

#Preview {
    ProductImage(imageURL: MockData.mockProduct.thumbnail)
}
