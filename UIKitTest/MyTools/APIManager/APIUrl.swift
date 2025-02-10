//
//  APIUrl.swift
//  UIKitTest
//
//  Created by 紹郁 on 2024/9/2.
//

import Foundation

enum Environment {
    case formal
    case test

    var baseUrl: String {
        switch self {
        case .formal:
            return "https://app.mgtt.com.tw/api/"
        case .test:
            return "https://test.mgtt.com.tw/api/"
        }
    }
}

let App: Environment = .test

enum APIUrl {
    case getRate                    // 001.匯率
    case getBanner                  // 002.廣告
    case getRemittanceForm          // 003.匯款方式
    case getChannels                // 004.繳款方式
    case getBanks                   // 005.受款銀行
    case version_update             // 009.APP強制版更
    case remittance_related         // 010.匯款相關(受款人關係 type = 1, 匯款目的 type = 2, 匯款來源 type = 3)
    case appstart                   // 011.App啟動執行
    case getBulletin                // 012.公告
    
    case setDevice                  // 101.上傳設備號碼(暫不啟用)
    case register                   // 102.註冊
    case login                      // 103.登入
    case forgetPassword             // 104.忘記密碼
    case remittance                 // 106.匯款
    case resetPassword              // 109.重設密碼
    case getPhoneCode               // 111.取得手機驗證碼
    case checkPhoneCode             // 112.驗證手機驗證碼
    case checkAch                   // 113.驗證是否能Ach
    case getStore                   // 114.取附近自營點
    
    case getBeneficiaryList         // 120.受款人列表
    case addBeneficiary             // 121.新增受款人
    case deleteBeneficiary          // 122.刪除受款人
    case member_audit               // 123.會員審核狀態
    case getRemittanceList          // 124.匯款清單
    case getRemittanceDetail        // 125.匯款詳情
    case getNotificationList        // 126.推播通知
    case getNotificationDetails     // 127.推播通知詳情
    case getPaymentinfo             // 128.繳款詳情
    case getBonusPoints             // 129.會員紅利點數
    
    var rawValue: String {
        switch self {
        case .getRate:
            return App.baseUrl + "rate"
            
        case .getBanner:
            return App.baseUrl + "banner_new"
            
        case .getRemittanceForm:
            return App.baseUrl + "remittance_form"
            
        case .getChannels:
            return App.baseUrl + "channels"
            
        case .getBanks:
            return App.baseUrl + "banks"
            
        case .version_update:
            return App.baseUrl + "version_update"
            
        case .remittance_related:
            return App.baseUrl + "remittance_related"
            
        case .appstart:
            return App.baseUrl + "appstart"
            
        case .getBulletin:
            return App.baseUrl + "announcement"
            
        case .setDevice:
            return App.baseUrl + "device"
            
        case .register:
            return App.baseUrl + "register_new"
            
        case .login:
            return App.baseUrl + "login_new"
            
        case .forgetPassword:
            return App.baseUrl + "forget_new"
            
        case .remittance:
            return App.baseUrl + "remittance_new"
            
        case .resetPassword:
            return App.baseUrl + "change_pwd_new"
            
        case .getPhoneCode:
            return App.baseUrl + "phone_code"
            
        case .checkPhoneCode:
            return App.baseUrl + "checkPhoneCode"
            
        case .checkAch:
            return App.baseUrl + "checkAch_new"
            
        case .getStore:
            return App.baseUrl + "getStore"
            
        case .getBeneficiaryList:
            return App.baseUrl + "listBeneficiary_new"
            
        case .addBeneficiary:
            return App.baseUrl + "addBeneficiary_new"
            
        case .deleteBeneficiary:
            return App.baseUrl + "deleteBeneficiary_new"
            
        case .member_audit:
            return App.baseUrl + "member_audit"
            
        case .getRemittanceList:
            return App.baseUrl + "remittance_list"
            
        case .getRemittanceDetail:
            return App.baseUrl + "single_remittance_details"
            
        case .getNotificationList:
            return App.baseUrl + "notification_new"
            
        case .getNotificationDetails:
            return App.baseUrl + "notification_details"
            
        case .getPaymentinfo:
            return App.baseUrl + "paymentinfo"
            
        case .getBonusPoints:
            return App.baseUrl + "mempoint"
        }
    }
}

