//
//  SFSymbolTest.swift
//  UIKitTest
//
//  Created by 紹郁 on 2024/8/14.
//

import UIKit

class SFSymbolScreen: UIViewController {
    
    var firstColor: UIColor = .black
    var secondColor: UIColor = .black
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let titleBar = titleBar
        let subView = subView
        
        let appView = UIStackView(arrangedSubviews: [titleBar, subView])
        appView.axis = .vertical
        appView.distribution = .fill
        
        self.view.addSubview(appView)
        
        appView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            appView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            appView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            appView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            appView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
        ])
        
        titleBar.heightAnchor.constraint(equalTo: appView.heightAnchor, multiplier: 0.1).isActive = true
        subView.heightAnchor.constraint(equalTo: appView.heightAnchor, multiplier: 0.9).isActive = true
    }
    
    @objc func back() {
        popView()
    }
    
    func updateSymbolColors() {
        let paletteConfiguration = UIImage.SymbolConfiguration(paletteColors: [firstColor, secondColor])
        
        if let subViewStack = self.view.subviews.compactMap({ $0 as? UIStackView }).first,
           let symbolImageView = subViewStack.arrangedSubviews.first as? UIImageView {
            symbolImageView.image = UIImage(systemName: "bell.badge", withConfiguration: paletteConfiguration)
        }
    }
}

extension SFSymbolScreen {
    
    var titleBar: UIView {
        
        let titleLabel = mainLabelView(labelText: "SFSymbol調色練習", font: .title1, isBold: true, _textColor: .black, aligment: .center, background: .clear)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let backButton = mainArrowButtonView(symbol: .arrow_left, target: self, action: #selector(back))
        backButton.tintColor = .black
        backButton.backgroundColor = .clear
        backButton.translatesAutoresizingMaskIntoConstraints = false
        
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let titleBarStack = UIStackView(arrangedSubviews: [backButton, titleLabel, view])
        titleBarStack.axis = .horizontal
        titleBarStack.distribution = .fill
        titleBarStack.backgroundColor = .groupBg
        titleBarStack.translatesAutoresizingMaskIntoConstraints = false
        
        backButton.widthAnchor.constraint(equalTo: titleBarStack.widthAnchor, multiplier: 0.15).isActive = true
        titleLabel.widthAnchor.constraint(equalTo: titleBarStack.widthAnchor, multiplier: 0.7).isActive = true
        view.widthAnchor.constraint(equalTo: titleBarStack.widthAnchor, multiplier: 0.15).isActive = true
        
        return titleBarStack
    }

    var subView: UIView {
        
        let symbolImage = UIImageView()
        let paletteConfiguration = UIImage.SymbolConfiguration(paletteColors: [firstColor, secondColor])
        symbolImage.image = UIImage(systemName: "bell.badge", withConfiguration: paletteConfiguration)
        symbolImage.contentMode = .scaleAspectFit
        symbolImage.translatesAutoresizingMaskIntoConstraints = false
        
        let firstColorView = firstColorView
        let secondColorView = secondColorView
        
        let subViewStack = UIStackView(arrangedSubviews: [symbolImage, firstColorView, secondColorView])
        subViewStack.axis = .vertical
        subViewStack.distribution = .fill
        subViewStack.translatesAutoresizingMaskIntoConstraints = false
        
        symbolImage.heightAnchor.constraint(equalTo: subViewStack.heightAnchor, multiplier: 0.7).isActive = true
        firstColorView.heightAnchor.constraint(equalTo: subViewStack.heightAnchor, multiplier: 0.15).isActive = true
        secondColorView.heightAnchor.constraint(equalTo: subViewStack.heightAnchor, multiplier: 0.15).isActive = true
        
        return subViewStack
    }
    
    var firstColorView: UIView {
        
        let firstPalette = UIColorWell()
        firstPalette.selectedColor = firstColor
        firstPalette.title = "主色"
        firstPalette.backgroundColor = .clear
        firstPalette.translatesAutoresizingMaskIntoConstraints = false
        firstPalette.addTarget(self, action: #selector(firstColorChanged), for: .valueChanged)
        
        let firstLabel = mainLabelView(labelText: "主色", font: .title1, isBold: true, _textColor: firstColor, aligment: .left, background: .clear)
        firstLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let firstView = UIStackView(arrangedSubviews: [firstPalette, firstLabel])
        firstView.axis = .horizontal
        firstView.distribution = .fill
        firstView.backgroundColor = .groupBg
        firstView.translatesAutoresizingMaskIntoConstraints = false
        
        firstPalette.widthAnchor.constraint(equalTo: firstView.widthAnchor, multiplier: 0.3).isActive = true
        firstLabel.widthAnchor.constraint(equalTo: firstView.widthAnchor, multiplier: 0.7).isActive = true
        
        return firstView
    }
    
    var secondColorView: UIView {
        
        let secondPalette = UIColorWell()
        secondPalette.selectedColor = secondColor
        secondPalette.title = "配色"
        secondPalette.backgroundColor = .clear
        secondPalette.translatesAutoresizingMaskIntoConstraints = false
        secondPalette.addTarget(self, action: #selector(secondColorChanged), for: .valueChanged)
        
        let secondLabel = mainLabelView(labelText: "主配色", font: .title2, isBold: true, _textColor: secondColor, aligment: .left, background: .clear)
        secondLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let secondView = UIStackView(arrangedSubviews: [secondPalette, secondLabel])
        secondView.axis = .horizontal
        secondView.distribution = .fill
        secondView.backgroundColor = .groupBg
        secondView.translatesAutoresizingMaskIntoConstraints = false
        
        secondPalette.widthAnchor.constraint(equalTo: secondView.widthAnchor, multiplier: 0.3).isActive = true
        secondLabel.widthAnchor.constraint(equalTo: secondView.widthAnchor, multiplier: 0.7).isActive = true
        
        return secondView
    }
    
    @objc func firstColorChanged(_ sender: UIColorWell) {
        if let selectedColor = sender.selectedColor {
            firstColor = selectedColor
            updateSymbolColors()
        }
    }

    @objc func secondColorChanged(_ sender: UIColorWell) {
        if let selectedColor = sender.selectedColor {
            secondColor = selectedColor
            updateSymbolColors()
        }
    }
}
