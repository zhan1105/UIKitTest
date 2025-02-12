//
//  NetworkItem.swift
//  UIKitTest
//
//  Created by 紹郁 on 2025/2/11.
//

import Foundation

struct NetworkItem: Codable {
    let id:         String
    let url:        String
    let width:      Int
    let height:     Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case url
        case width
        case height
    }
}
