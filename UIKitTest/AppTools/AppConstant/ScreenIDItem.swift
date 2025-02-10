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
   
    let screenItem: [ScreenItem] = [("簡易練習",TestScreen()),
                                    ("語系切換", SwitchLanguageScreen()),
                                    ("WebView練習", WebViewScreen()),
                                    ("GoogleMap練習", MapScreen()),
                                    ("下拉式選單", DownMenuScreen()),
                                    ("自定義輸入框", MyTextFieldScreen()),
                                    ("OTP自動填入", OTPScreen()),
                                    ("自定義選擇器", MySelectorScreen()),
                                    ("Banner套件", PageViewScreen()),
                                    ("FaceID", FaceRecognitionScreen()),
                                    ("Symbol應用", SymbolScreen()),
                                    
//                                    ("API應用", APITestScreen()),
//                                    ("網路圖片應用", ImageUrlScreen()),
//                                    ("側選單應用", SideMenuScreen()),
//                                    ("Loading動畫", LoadingAnimationScreen()),
//                                    ("相機遮罩", CameraOverlayScreen()),
//                                    ("ScrollView練習", ScrollViewTestScreen()),
//                                    ("TabView", TabBarScreen()),
//                                    ("Switch練習", SwitchScreen()),
//                                    ("截圖試做功能", ScreenShotScreen()),
//                                    ("三段式條碼生成", BarcodeScreen()),
    ]
}
