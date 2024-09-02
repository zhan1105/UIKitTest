//
//  ScreenIDItem.swift
//  UIKitTest
//
//  Created by 紹郁 on 2024/8/15.
//

import UIKit
import Foundation

typealias ScreenItem = (title: String, itemID: UIViewController)

struct ScreenIDItem {
   
    let screenItem: [ScreenItem] = [("簡單練習",FirstTestScreen()),
                                    ("語系切換", SwitchLanguageScreen()),
                                    ("WebView練習", WebViewScreen()),
                                    ("Banner套件", PageViewScreen()),
                                    ("下拉式選單", DownMenuScreen()),
                                    ("GoogleMap練習", MapScreen()),
                                    ("OTP自動填入", OTPScreen()),
                                    ("文字判斷", TextSettingScreen()),
                                    ("FaceID", FaceRecognitionScreen()),
                                    ("Symbol應用", SymbolScreen()),
                                    ("API應用", APITestScreen())
    ]
}
