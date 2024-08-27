//
//  UIView+.swift
//  UIKitTest
//
//  Created by 紹郁 on 2024/8/15.
//

import UIKit

extension UIViewController {
    
    func mainLabelView(labelText: String, font: UIFont?, isBold: Bool, _textColor: UIColor?, aligment: NSTextAlignment, background: UIColor?) -> UILabel {
        let myLabel = UILabel()
        myLabel.text = labelText
        myLabel.font = UIFont.systemFont(ofSize: font?.pointSize ?? UIFont.preferredFont(forTextStyle: .title1).pointSize, weight: isBold ? .bold : .medium)
        myLabel.textColor = _textColor
        myLabel.textAlignment = aligment
        myLabel.backgroundColor = background
        
        return myLabel
    }
    
    func mainSFSymbolImage(symbol: SFSymbol, background: UIColor) -> UIImageView {
        
        let myImageView = UIImageView()
        
        myImageView.image = UIImage(systemName: symbol.rawValue)
        myImageView.contentMode = .scaleAspectFit
        myImageView.backgroundColor = background
        
        return myImageView
    }
    
    func mainImageView(imageName: String, background: UIColor) -> UIImageView {
        
        let myImageView = UIImageView()
        
        myImageView.image = UIImage(named: imageName)
        myImageView.contentMode = .scaleAspectFit
        myImageView.backgroundColor = background
        
        return myImageView
    }
    
    func mainArrowButtonView(symbol: SFSymbol, target: Any?, action: Selector) -> UIButton {
        
        let newButton = UIButton(type: .system)
        
        // 設置 SFSymbol 圖標
        if let image = UIImage(systemName: symbol.rawValue) {
            newButton.setImage(image, for: .normal)
            newButton.tintColor = .white  // 設置圖標顏色
        }
        
        newButton.addTarget(target, action: action, for: .touchUpInside)
        newButton.backgroundColor = .clear
        
        return newButton
    }
    
    func mainTitleBar(title: String) -> UIStackView {
        
        let titleLabel = mainLabelView(labelText: title, font: .title1, isBold: true, _textColor: .black, aligment: .center, background: .clear)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let backButton = mainArrowButtonView(symbol: .arrow_left, target: self, action: #selector(backView))
        backButton.tintColor = .black
        backButton.translatesAutoresizingMaskIntoConstraints = false
        
        let spacer = mainSpacer()
        
        let titleBarStack = UIStackView(arrangedSubviews: [backButton, titleLabel, spacer])
        titleBarStack.axis = .horizontal
        titleBarStack.distribution = .fill
        titleBarStack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            backButton.widthAnchor.constraint(equalTo: titleBarStack.widthAnchor, multiplier: 0.15),
            titleLabel.widthAnchor.constraint(equalTo: titleBarStack.widthAnchor, multiplier: 0.7),
            spacer.widthAnchor.constraint(equalTo: titleBarStack.widthAnchor, multiplier: 0.15)
        ])
        
        return titleBarStack
    }
    
    @objc func backView() {
        popView()
    }
    
    func mainSpacer() -> UIView {
        
        let newSpacerView = UIView()
        newSpacerView.backgroundColor = .clear
        newSpacerView.translatesAutoresizingMaskIntoConstraints = false
        
        return newSpacerView
    }
    
    func showMessage(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "確定", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}


