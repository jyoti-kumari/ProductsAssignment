//
//  ProductRow.swift
//  ProductsAssignment
//
//  Created by Jyoti Kumari on 29/01/24.
//

import SwiftUI

struct ProductRow: View {
    var product: ProductData
    var body: some View {
        HStack {
            ProductImage(imageURL: product.thumbnail)
            VStack(alignment: .leading) {
                Text(product.title)
                    .font(.headline)
                Text(product.brand)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            Spacer()
        }
    }
}

#Preview {
    
    Group {
        ProductRow(product: StringConstant.sampleData)
    }
}
