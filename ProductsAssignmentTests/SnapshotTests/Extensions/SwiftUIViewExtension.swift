//
//  SwiftUIViewExtension.swift
//  ProductsAssignmentTests
//
//  Created by Jyoti Kumari on 30/01/24.
//

import SwiftUI
import SnapshotTesting

extension SwiftUI.View {
    func toViewController() -> UIViewController {
        let viewController = UIHostingController(rootView: self)
        viewController.view.frame = UIScreen.main.bounds
        return viewController
    }
}

extension UIViewController {
    func performSnapshotTests(
            named name: String,
            testName: String = "Snapshot") {
            assertSnapshot(
                matching: self,
                as: .image(precision: 0.99),
                named: name,
                testName: testName)
        }
}
