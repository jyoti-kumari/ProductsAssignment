//
//  ProductImageTest.swift
//  ProductsAssignmentTests
//
//  Created by Jyoti Kumari on 30/01/24.
//

import XCTest
import SnapshotTesting
import SwiftUI
@testable import ProductsAssignment

final class ProductImageTest: XCTestCase {
    func testProductImage() {
        let productImage: ProductImage = ProductImage(imageURL: MockData.mockProduct.thumbnail)
        let viewController = productImage.toViewController()
        viewController.performSnapshotTests(named: "ProductImage")
    }
}
