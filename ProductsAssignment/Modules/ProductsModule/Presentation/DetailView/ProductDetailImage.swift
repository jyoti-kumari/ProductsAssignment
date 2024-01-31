//
//  ProductDetailImage.swift
//  ProductsAssignment
//
//  Created by Jyoti Kumari on 29/01/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct ProductDetailImage: View {
    var imageURL: String
    var body: some View {
        WebImage(url: URL(string: imageURL))
            .placeholder(Image("default").resizable())
            .resizable()
            .frame(height: 200)
            
    }
}


#Preview {
    ProductDetailImage(imageURL: MockData.mockProduct.thumbnail)
}

