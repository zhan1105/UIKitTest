//
//  DropDownScreen.swift
//  UIKitTest
//
//  Created by 紹郁 on 2024/8/19.
//

import UIKit
import iOSDropDown

class DropDownScreen: UIViewController {
    
    var imageNameItem = ImageNameItem().imageData
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let titleBar = titleBar
        
        let dropDown = DropDown()
        dropDown.optionArray = ["Google Map", "YouTube", "官網"]
        dropDown.optionIds = [1, 2, 3]
        dropDown.optionImageArray = imageNameItem.map{ $0.name }
        dropDown.selectedRowColor = .groupBg
        dropDown.rowHeight = 50
        dropDown.checkMarkEnabled = false
        dropDown.text = "選擇一個"
        dropDown.font = UIFont.title2
        dropDown.backgroundColor = .groupBg
        dropDown.textAlignment = .center
        
        dropDown.didSelect{(selectedText , index ,id) in
            print("Selected String: \(selectedText) \n index: \(index)")
        }
        dropDown.translatesAutoresizingMaskIntoConstraints = false

        let spaceView = UIView()
        spaceView.backgroundColor = .clear
        spaceView.translatesAutoresizingMaskIntoConstraints = false
        
        let appView = UIStackView(arrangedSubviews: [titleBar, dropDown, spaceView])
        appView.axis = .vertical
        appView.distribution = .fill
        
        self.view.addSubview(appView)
        
        appView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            appView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            appView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            appView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            appView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            
            dropDown.topAnchor.constraint(equalTo: titleBar.bottomAnchor, constant: 15),
            dropDown.leadingAnchor.constraint(equalTo: appView.leadingAnchor, constant: 15),
            dropDown.trailingAnchor.constraint(equalTo: appView.trailingAnchor, constant: -15),
            dropDown.bottomAnchor.constraint(equalTo: spaceView.topAnchor, constant: -15)
        ])
        
        titleBar.heightAnchor.constraint(equalTo: appView.heightAnchor, multiplier: 0.1).isActive = true
        dropDown.heightAnchor.constraint(equalTo: appView.heightAnchor, multiplier: 0.15).isActive = true
        spaceView.heightAnchor.constraint(equalTo: appView.heightAnchor, multiplier: 0.75).isActive = true
        
        
    }
}
//MARK: - SubView
extension DropDownScreen {
    var titleBar: UIView {
        
        let titleLabel = mainLabelView(labelText: "DropDown套件", font: .title1, isBold: true, _textColor: .black, aligment: .center, background: .clear)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let backButton = mainArrowButtonView(symbol: .arrow_left, target: self, action: #selector(back))
        backButton.tintColor = .black
        backButton.translatesAutoresizingMaskIntoConstraints = false
        
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let titleBarStack = UIStackView(arrangedSubviews: [backButton, titleLabel, view])
        titleBarStack.axis = .horizontal
        titleBarStack.distribution = .fill
        titleBarStack.translatesAutoresizingMaskIntoConstraints = false
        
        backButton.widthAnchor.constraint(equalTo: titleBarStack.widthAnchor, multiplier: 0.15).isActive = true
        titleLabel.widthAnchor.constraint(equalTo: titleBarStack.widthAnchor, multiplier: 0.7).isActive = true
        view.widthAnchor.constraint(equalTo: titleBarStack.widthAnchor, multiplier: 0.15).isActive = true
        
        return titleBarStack
    }

}

//MARK: - Function
extension DropDownScreen {
    
    @objc func back() {
        popView()
    }
}
