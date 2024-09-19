//
//  MyViewController.swift
//  UIKitTest
//
//  Created by 紹郁 on 2024/8/30.
//

import UIKit

class MyViewController: UIViewController {
    
    private var loadingView: MyLoading?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .pureWhite
    }
    
    
    func showMessage(title: String, message: String, for textField: UITextField) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "確定", style: .default, handler: nil))
        self.present(alert, animated: true, completion: {
            textField.becomeFirstResponder()
            self.highlightTextField(textField)
        })
    }
    
    func highlightTextField(_ textField: UITextField) {
        textField.layer.borderColor = UIColor.red.cgColor
        textField.layer.borderWidth = 1.0
        UIView.animate(withDuration: 0.3) {
            textField.layer.borderColor = UIColor.red.cgColor
        }
    }
    
    func clearHighlight(for textField: UITextField) {
        textField.layer.borderColor = UIColor.clear.cgColor
        textField.layer.borderWidth = 0
    }
    
    func fetchData() {
        // 顯示 Loading 畫面
        showLoading()
        
        // 模擬資料載入過程
        DispatchQueue.global().async {
            sleep(2) // 模擬網絡請求
            
            DispatchQueue.main.async {
                // 隱藏 Loading 畫面
                self.dismissLoading()
            }
        }
    }
    
    func showLoading() {
        if loadingView == nil {
            loadingView = MyLoading()
        }
        loadingView?.show(in: self.view)
    }
    
    func dismissLoading() {
        loadingView?.hide()
    }
}
