//
//  SwitchScreen.swift
//  UIKitTest
//
//  Created by 紹郁 on 2024/10/23.
//

import UIKit

class SwitchScreen: MyViewController {
    
    let mySwitch = UISwitch()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 設置 Switch 的位置和初始狀態
        mySwitch.center = self.view.center  // 將開關放置在螢幕中央
        mySwitch.isOn = true  // 開關預設為開啟
        
        // 添加到視圖中
        self.view.addSubview(mySwitch)
        
        // 為 Switch 添加事件處理
        mySwitch.addTarget(self, action: #selector(switchToggled(_:)), for: .valueChanged)
    }
    
    @objc func switchToggled(_ sender: UISwitch) {
        if sender.isOn {
            print("Switch is ON")
        } else {
            print("Switch is OFF")
        }
    }
}
