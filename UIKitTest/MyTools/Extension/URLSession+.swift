//
//  URLSession+.swift
//  UIKitTest
//
//  Created by 紹郁 on 2024/9/2.
//

import Foundation

extension URLSession {
    
    enum APIError: Error {
        case invalidURL
        case invalidData
        case invalidCode(Int)
    }
    
    func data(for urlRequest: URLRequest) async throws -> Data {
        let (data, response) = try await self.data(for: urlRequest)
        guard let response = response as? HTTPURLResponse else { throw APIError.invalidURL }
        guard 200...299 ~= response.statusCode else {
            throw APIError.invalidCode(response.statusCode)
        }
        return data
    }
}
