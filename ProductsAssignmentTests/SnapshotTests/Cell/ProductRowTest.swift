//
//  ProductRowTest.swift
//  ProductsAssignmentTests
//
//  Created by Jyoti Kumari on 30/01/24.
//

import XCTest
import SnapshotTesting
import SwiftUI
@testable import ProductsAssignment

final class ProductRowTest: XCTestCase {
    func testProductRow() {
        let productRow: ProductRow = ProductRow(product: MockData.mockProduct)
        assertSnapshots(matching: productRow.toViewController(), as: [.image])
    }
}


