//
//  APIManager.swift
//  ProductsAssignment
//
//  Created by Jyoti Kumari on 29/01/24.
//

import Foundation
import PromiseKit

protocol NetworkProtocol {
   func request<T: Decodable>(_ request: RequestProtocol, responseType: T.Type) -> Promise<T>
}

final class NetworkManager: NetworkProtocol {
  private let session: URLSessionProtocol
  
  init(session: URLSessionProtocol = URLSession.shared) {
    self.session = session
  }
    
  // MARK: - Request func
    func request<T: Decodable>(_ service: RequestProtocol, responseType: T.Type) -> Promise<T> {
        return Promise { seal in
            guard let url = buildURL(from: service) else {
                seal.reject(NetworkError.invalidURL)
                return
            }
            session.dataTaskWithURL(url) { data, response, error in
                if let error = error {
                    seal.reject(error)
                    return
                }
                Self.handleResponseData(data, responseType: responseType, seal: seal)
            }.resume()
        }
    }
}

private func buildURL(from service: RequestProtocol) -> URL? {
    let urlComponents = URLComponents(string: service.requestURL)
    return urlComponents?.url
}

// MARK: - Response handlers

extension NetworkManager {
    static func handleResponseData<T: Decodable>(_ data: Data?, responseType: T.Type, seal: Resolver<T>) {
        guard let data = data else {
            seal.reject(NetworkError.noData)
            return
        }
        do {
            let decoder = JSONDecoder()
            let responseObject = try decoder.decode(T.self, from: data)
            seal.fulfill(responseObject)
        } catch {
            seal.reject(NetworkError.decodingError)
        }
    }
}
