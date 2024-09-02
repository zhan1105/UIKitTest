//
//  SymbolUI.swift
//  UIKitTest
//
//  Created by 紹郁 on 2024/8/30.
//

import UIKit

class SymbolUI: UIView {
        
    private var mySymbol = MySymbol(symbol: .bell)

    private var firstColorWell: UIColorWell?
    private var secondColorWell: UIColorWell?
    
    var selectedFirstColor = UIColor.black
    var selectedSecondColor = UIColor.black
    
    init(){
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
                
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
        newColorWell.widthAnchor.constraint(equalToConstant: 50).isActive = true
        newColorWell.addTarget(self, action: #selector(colorChanged(_:)), for: .valueChanged)

        let newLabel = MyLabel(text: text)
        newLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let newSpacer = MySpacer()
        newSpacer.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        let newColor = MyStack(arrangedSubviews: [newColorWell, newLabel, newSpacer])
        newColor.axis = .horizontal
        newColor.spacing = 8
        
        if text == "第一色" {
            firstColorWell = newColorWell
        } else if text == "第二色" {
            secondColorWell = newColorWell
        }
        
        return newColor
    }
    
    @objc private func colorChanged(_ sender: UIColorWell) {
        if sender == firstColorWell {
            selectedFirstColor = sender.selectedColor!
        } else if sender == secondColorWell {
            selectedSecondColor = sender.selectedColor!
        }
        
        let paletteConfiguration = UIImage.SymbolConfiguration(paletteColors: [selectedFirstColor, selectedSecondColor])
        // 更新符號圖像的配置
        if let symbolImage = mySymbol.image {
            let updatedImage = symbolImage.withConfiguration(paletteConfiguration)
            mySymbol.image = updatedImage
        }
    }
}
