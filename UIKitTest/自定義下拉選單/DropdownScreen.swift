//
//  DropdownScreen.swift
//  UIKitTest
//
//  Created by 紹郁 on 2024/9/10.
//

import UIKit

class DropdownScreen: MyViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
}
//MARK: - subView
extension DropdownScreen {
    private func setupUI(){
        
        let myTitleBar = MyTitleBar(text: "自定義下拉式選單")
        myTitleBar.backButtonAction = { [weak self] in self?.popViewController() }
        
        
    }
}
