//
//  ProductRow.swift
//  ProductsAssignment
//
//  Created by Jyoti Kumari on 29/01/24.
//

import SwiftUI

struct ProductRow: View {
    var product: ProductPresentationData
    var body: some View {
        HStack {
            ProductImage(imageURL: product.thumbnail)
            .frame(width: 50, height: 50)
            
            VStack(alignment: .leading) {
                Text(product.title)
                    .font(.headline)
                Text(product.brand)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
    }
}

#Preview {
    
    Group {
        ProductRow(product: MockData.mockProduct)
    }
}
