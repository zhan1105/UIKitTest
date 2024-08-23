//
//  WebViewVC.swift
//  UIKitTest
//
//  Created by 紹郁 on 2024/8/13.
//

import UIKit
import WebKit

class WebViewScreen: UIViewController {
    
    var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let titleBar = addTitleBar
        
        // 初始化 WKWebView
        webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        
        let vStack = UIStackView(arrangedSubviews: [titleBar, webView])
        vStack.axis = .vertical
        vStack.distribution = .fill
        vStack.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(vStack)
        
        NSLayoutConstraint.activate([
            vStack.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            vStack.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            vStack.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            vStack.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        titleBar.heightAnchor.constraint(equalTo: vStack.heightAnchor, multiplier: 0.1).isActive = true
        webView.heightAnchor.constraint(equalTo: vStack.heightAnchor, multiplier: 0.9).isActive = true
        
        // 加載網頁內容
        if let url = URL(string: "https://www.google.com.tw") {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
}

//MARK: - SubView
extension WebViewScreen {
    
    var addTitleBar: UIView {
        
        let backButton = createArrowButton(symbol: .arrow_left, target: self, action: #selector(back))
        
        let titleLabel = addTitleLabel
        
        let nextButton = createArrowButton(symbol: .arrow_right, target: self, action: #selector(pushLayout))
        
        let titleBar = UIStackView(arrangedSubviews: [backButton, titleLabel, nextButton])
        titleBar.axis = .horizontal
        titleBar.distribution = .fill
        titleBar.backgroundColor = .gray
        titleBar.translatesAutoresizingMaskIntoConstraints = false
        
        backButton.widthAnchor.constraint(equalTo: titleBar.widthAnchor, multiplier: 0.15).isActive = true
        titleLabel.widthAnchor.constraint(equalTo: titleBar.widthAnchor, multiplier: 0.7).isActive = true
        nextButton.widthAnchor.constraint(equalTo: titleBar.widthAnchor, multiplier: 0.15).isActive = true
        
        return titleBar
    }
    
    var addTitleLabel: UIView {
        let titleLabel = UILabel()
        titleLabel.text = "標題試做"
        titleLabel.font = UIFont.systemFont(ofSize: UIFont.title1.pointSize, weight: .bold)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        titleLabel.backgroundColor = .clear
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return titleLabel
    }

    func createArrowButton(symbol: SFSymbol, target: Any?, action: Selector) -> UIButton {
        let newButton = UIButton(type: .system)
        
        // 設置 SFSymbol 圖標
        if let image = UIImage(systemName: symbol.rawValue) {
            newButton.setImage(image, for: .normal)
            newButton.tintColor = .white  // 設置圖標顏色
        }
        
        newButton.addTarget(target, action: action, for: .touchUpInside)
        newButton.backgroundColor = .clear
        newButton.translatesAutoresizingMaskIntoConstraints = false
        
        return newButton
    }
}

//MARK: - Model
extension WebViewScreen {
    
    @objc func back(){
        popView()
    }
    
    @objc func pushLayout(){
        pushView("LayoutSB")
    }
}
