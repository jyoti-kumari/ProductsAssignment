//
//  ContentView.swift
//  ProductsAssignment
//
//  Created by Jyoti Kumari on 29/01/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModelProtocol = ProductsModule().createProductsListView()
    
    var body: some View {
        ZStack {
            ProductsList(products: viewModelProtocol.products)
            if viewModelProtocol.isLoading {
                ProgressView()
            }
        }
        .onAppear {
            if viewModelProtocol.products.isEmpty {
                Task {
                    viewModelProtocol.getProducts()
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
