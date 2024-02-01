//
//  ProductImage.swift
//  ProductsAssignment
//
//  Created by Jyoti Kumari on 29/01/24.
//

import SwiftUI

struct ProductImage: View {
    @ObservedObject private var imageViewModel: ImageViewModel
    
    init(imageURL: String?) {
        imageViewModel = ImageViewModel(urlString: imageURL)
    }
    
    var body: some View {
        Image(uiImage: imageViewModel.image ?? UIImage())
            .resizable()
    }
}

#Preview {
    ProductImage(imageURL: MockData.mockProduct.thumbnail)
}
