//
//  WebViewVC.swift
//  UIKitTest
//
//  Created by 紹郁 on 2024/8/13.
//

import UIKit
import WebKit

class WebViewScreen: MyViewController {
    
    let myTitleBar = MyTitleBar(text: "標題試做")
    var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

//MARK: - SubView
extension WebViewScreen {
    
    private func setupUI(){
        
        let myTitleBar = MyTitleBar(text: "標題試做")
        myTitleBar.backButtonAction = { [weak self] in self?.popViewController() }
        
        // 初始化 WKWebView
        webView = WKWebView()
        webView.backgroundColor = .coralRed
        webView.translatesAutoresizingMaskIntoConstraints = false
        
        let appScreen = MyStack(arrangedSubviews: [myTitleBar, webView])
        appScreen.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(appScreen)
        
        NSLayoutConstraint.activate([
            appScreen.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            appScreen.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            appScreen.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            appScreen.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            
            myTitleBar.heightAnchor.constraint(equalTo: appScreen.heightAnchor, multiplier: 0.1),
            webView.heightAnchor.constraint(equalTo: appScreen.heightAnchor, multiplier: 0.9),
        ])
        
        setURL(url: "https://testaml.mgtt.com.tw/site/familyNetSend/44800014/701AB4101D3097")
    }
}

//MARK: - WebView
extension WebViewScreen {
    
    func setURL(url: String){
        if let url = URL(string: url) {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
}
