//
//  SymbolUI.swift
//  UIKitTest
//
//  Created by 紹郁 on 2024/8/30.
//

import UIKit

class SymbolUI: UIView {
    
    init(){
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        
        let mySymbol = MySymbol(symbol: .bell)
        
        let firstColor = creatColorStack(color: .black, text: "第一色")
        let secondColor = creatColorStack(color: .black, text: "第二色")

        let spacer = MySpacer()
        
        let subScreen = MyStack(arrangedSubviews: [mySymbol, firstColor, secondColor, spacer])
        
        addSubview(subScreen)
        
        subScreen.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            subScreen.topAnchor.constraint(equalTo: topAnchor),
            subScreen.bottomAnchor.constraint(equalTo: bottomAnchor),
            subScreen.leadingAnchor.constraint(equalTo: leadingAnchor),
            subScreen.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            mySymbol.heightAnchor.constraint(equalTo: subScreen.heightAnchor, multiplier: 0.4),
            
            firstColor.heightAnchor.constraint(equalTo: subScreen.heightAnchor, multiplier: 0.1),
            firstColor.leadingAnchor.constraint(equalTo: subScreen.leadingAnchor, constant: 15),
            firstColor.trailingAnchor.constraint(equalTo: subScreen.trailingAnchor, constant: -15),
            
            secondColor.heightAnchor.constraint(equalTo: subScreen.heightAnchor, multiplier: 0.1),
            secondColor.leadingAnchor.constraint(equalTo: subScreen.leadingAnchor, constant: 15),
            secondColor.trailingAnchor.constraint(equalTo: subScreen.trailingAnchor, constant: -15),
            
            spacer.heightAnchor.constraint(equalTo: subScreen.heightAnchor, multiplier: 0.4),
        ])
    }
    
    func creatColorStack(color: UIColor, text: String) -> UIStackView {
        let newColorWell = UIColorWell()
        newColorWell.selectedColor = color
        newColorWell.translatesAutoresizingMaskIntoConstraints = false
        newColorWell.widthAnchor.constraint(equalToConstant: 50).isActive = true // 直接給定固定寬度
        
        let newLabel = MyLabel(text: text)
        newLabel.translatesAutoresizingMaskIntoConstraints = false

        let newSpacer = MySpacer()
        newSpacer.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        let newColor = MyStack(arrangedSubviews: [newColorWell, newLabel, newSpacer])
        newColor.axis = .horizontal
        newColor.spacing = 8 // 給子視圖之間設置間距

        return newColor
    }
}
