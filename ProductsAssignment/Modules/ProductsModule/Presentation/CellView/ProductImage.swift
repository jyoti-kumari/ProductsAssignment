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
            .placeholder(Image("default").resizable())
            .resizable()
            .frame(width: 50, height: 50)
            .aspectRatio(contentMode: .fill)
    }
}

#Preview {
    ProductImage(imageURL: MockData.mockProduct.thumbnail)
}
