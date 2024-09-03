//
//  LoginRespone.swift
//  UIKitTest
//
//  Created by 紹郁 on 2024/9/2.
//

import Foundation

struct LoginRespone: Codable {
    let code: String
    let msg: String
    let data: DataClass
    
    // MARK: - DataClass
    struct DataClass: Codable {
        let token:          String
        let arcNo:          String
        let name:           String
        let birthDate:      String
        let countryCode:    String
        let arcExpiryDate:  String?
        let passportNo:     String
        let phone:          String
        
        enum CodingKeys: String, CodingKey {
            case token          = "token"
            case arcNo          = "arc_no"
            case name           = "name"
            case birthDate      = "birth_date"
            case countryCode    = "country_code"
            case arcExpiryDate  = "arc_expiry_date"
            case passportNo     = "passport_no"
            case phone          = "phone"
        }
    }
}


