//
//  AppAPi.swift
//  UIKitTest
//
//  Created by 紹郁 on 2024/9/2.
//

import Foundation

extension APIManager {
    
    func getImage() async throws -> [ImageRespone] {
        let data = try await get(url: .getCatData, parameters: nil)
        return try JSONDecoder().decode([ImageRespone].self, from: data)
    }
    
    func getLogin(body: [String: String]?) async throws -> String? {
        
        let data = try await postForm(url: .getLogin, bodyData: body)
        let jsonString = String(data: data, encoding: .utf8)
        
        return jsonString
    }
}
