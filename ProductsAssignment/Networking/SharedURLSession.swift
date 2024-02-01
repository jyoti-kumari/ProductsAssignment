//
//  SharedURLSession.swift
//  ProductsAssignment
//
//  Created by Jyoti Kumari on 31/01/24.
//

import Foundation

final class SharedURLSession {
    static var shared: URLSession = {
        let configuration = URLSessionConfiguration.default
        let delegate = SharedSessionDelegate()
        return URLSession(configuration: configuration, delegate: delegate, delegateQueue: OperationQueue.main)
    }()
}

