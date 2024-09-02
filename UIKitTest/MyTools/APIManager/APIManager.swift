//
//  HttpClient.swift
//  UIKitTest
//
//  Created by 紹郁 on 2024/9/2.
//

import Foundation

final class APIManager {
    static let shared = APIManager()
    
    private let session = URLSession(configuration: .default)
    
    private init() {}
}

extension APIManager {
    
    func get(url: APIUrl, parameters: [String: String]?) async throws -> Data {
        var urlString = url.rawValue
        
        if let parameters = parameters {
            let queryString = parameters.map { "\($0.key)=\($0.value)" }.joined(separator: "&")
            urlString.append("?\(queryString)")
        }
        
        guard let url = URL(string: urlString) else {
            throw URLSession.APIError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.timeoutInterval = 30
        
        // 使用先前擴展的 URLSession 的 data 方法
        let data = try await session.data(for: request)
        
        return data
    }
}
