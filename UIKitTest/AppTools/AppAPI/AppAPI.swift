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
    
    func getLogin(body: [String: String]?) async throws -> Any? {
        
        let data = try await postForm(url: .getLogin, body: body)
        
        do {
            let dataState = try JSONDecoder().decode(ApiRespone.self, from: data)
            if dataState.code == "00" {
                let dataRespone = try JSONDecoder().decode(LoginRespone.self, from: data)
                return dataRespone
            } else {
                let dataString = String(data: data, encoding: .utf8)
                return dataString
            }
        } catch {
            print("解碼失敗：\(error)")
            throw error
        }
    }
}
