//
//  ProductDetailViewTest.swift
//  ProductsAssignmentTests
//
//  Created by Jyoti Kumari on 30/01/24.
//

import XCTest
import SnapshotTesting
import SwiftUI
@testable import ProductsAssignment

final class ProductDetailViewTest: XCTestCase {
    func testProductDetailView() {
        let productDetailView: ProductDetailView = ProductDetailView(productDetail: MockData.mockProduct)
        assertSnapshots(matching: productDetailView.toViewController(), as: [.image])
    }
}

