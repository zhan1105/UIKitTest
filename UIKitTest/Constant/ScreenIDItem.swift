//
//  ScreenIDItem.swift
//  UIKitTest
//
//  Created by 紹郁 on 2024/8/15.
//

import Foundation

typealias ScreenItem = (title: String, itemID: String)

struct ScreenIDItem {
   
    let screenItem: [ScreenItem] = [("簡單練習", "firstTestSB"), 
                                    ("排版練習", "LayoutSB"),
                                    ("語系切換練習", "SwitchSB"),
                                    ("WebView練習", "WebViewSB"), 
                                    ("SFSymbol調色", "SFSymbolSB"),
                                    ("Banner練習", "BannerSB"),
                                    ("Banner套件","PagerSB"),
                                    ("下拉式選單", "DownMenuSB"),
                                    ("DropDown套件", "DropDownSB"),
                                    ("GoogleMap練習", "GoogleMapSB"),
                                    ("OTP自動填入", "OTPSB"),
                                    ("文字判斷", ""),
                                    ("XibExample", "XibSB")]
}
