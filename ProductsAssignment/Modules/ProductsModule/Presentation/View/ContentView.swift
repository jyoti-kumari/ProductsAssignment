//
//  ContentView.swift
//  ProductsAssignment
//
//  Created by Jyoti Kumari on 29/01/24.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = AppDIRegistry().productViewModel
    
    var body: some View {
        ZStack {
            ProductsList(products: viewModel.products)
            if viewModel.isLoading {
                ProgressView()
            }
        }
        .onAppear {
            if viewModel.products.isEmpty {
                Task {
                    viewModel.getProducts()
                }
            }
        }
        .alert(isPresented: $viewModel.showError) {
            return Alert(title: Text(StringConstant.alertMessageTitle),
                    message: Text(viewModel.errorMessage),
                         dismissButton: .default(Text(StringConstant.alertButtonTitle)) {
                    }
                )
        }
    }
}

#Preview {
    ContentView()
}
