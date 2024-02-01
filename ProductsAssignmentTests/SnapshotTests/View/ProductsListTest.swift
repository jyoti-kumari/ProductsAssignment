//
//  ProductsListTest.swift
//  ProductsAssignmentTests
//
//  Created by Jyoti Kumari on 30/01/24.
//

import XCTest
import SnapshotTesting
import SwiftUI
@testable import ProductsAssignment

final class ProductsListTest: XCTestCase {
    func testProductsListView() {
        let productsList: ProductsList = ProductsList(products: [MockData.mockProduct])
        let viewController = productsList.toViewController()
        viewController.performSnapshotTests(named: "productsList")
    }
}
