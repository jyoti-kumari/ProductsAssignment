//
//  ProductDetailImageTest.swift
//  ProductsAssignmentTests
//
//  Created by Jyoti Kumari on 30/01/24.
//

import XCTest
import SnapshotTesting
import SwiftUI
@testable import ProductsAssignment

final class ProductDetailImageTest: XCTestCase {
    func testProductDetailImage() {
        let productDetailImage: ProductDetailImage = ProductDetailImage(imageURL: MockData.mockProduct.thumbnail)
        assertSnapshots(matching: productDetailImage.toViewController(), as: [.image])
    }
}

