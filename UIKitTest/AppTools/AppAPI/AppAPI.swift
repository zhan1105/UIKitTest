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
    
    func getLogin(body: [String: Any]?) async throws -> LoginRespone {
        
        let data = try await postJson(url: .getLogin, bodyData: body)
        
        // 輸出 JSON 資料以便於調試
        if let jsonString = String(data: data, encoding: .utf8) {
            print("Received JSON: \(jsonString)")
        }
        
        return try JSONDecoder().decode(LoginRespone.self, from: data)
    }
}
