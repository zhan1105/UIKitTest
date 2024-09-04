//
//  APITestScreen.swift
//  UIKitTest
//
//  Created by 紹郁 on 2024/9/2.
//

import UIKit

class APITestScreen: MyViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    
}
//MARK: - subView
extension APITestScreen {
    
    private func setupUI(){
        
        let myTitleBar = MyTitleBar(text: "API應用")
        myTitleBar.backButtonAction = { [weak self] in self?.popViewController() }
        
        let subScreen = APITestUI()
        subScreen.checkButton.buttonAction = { [weak self] in
            Task {
//                await self?.getImage()
                await self?.testLogin()
            }
        }
        
        let appScreen = MyStack(arrangedSubviews: [myTitleBar, subScreen])
        
        // 添加按鈕到視圖中
        view.addSubview(appScreen)
        // 設置按鈕的布局 (假設你有 Auto Layout 的約束)
        appScreen.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            appScreen.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            appScreen.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            appScreen.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            appScreen.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            
            myTitleBar.heightAnchor.constraint(equalTo: appScreen.heightAnchor, multiplier: 0.1),
            subScreen.heightAnchor.constraint(equalTo: appScreen.heightAnchor, multiplier: 0.9),
        ])
    }
}

//MARK: - API
extension APITestScreen {
    
    private func getImage() async {
        let sut = APIManager.shared
        
        do {
            let image = try await sut.getImage()
            print(image[0].url)
        } catch {
            print("Error fetching image: \(error)")
        }
    }
    
    private func testLogin() async {
        let sut = APIManager.shared
        
        do {
            // 假設你有一些登入所需的參數
            let body: [String: String] = [
                "arc_no": "NA80012021",
                "password": "12345678",
                "no": "caaBb7r8S8OITb7N-17lDi:APA91bH7CDlPbeOXHUXfW9WStMdq2Ok70OqBNZwmw7PcJXpxBIo0pRVAa4TBiehQl9rDMX2rRLTdAyhKjws-jad6T_QQk-3jK7Lh2k10w3-XnN8CzlO0G3SrSAltcP31ZNda3KSNeA9Z"
            ]
            
            // 使用 postLogin 進行 POST 請求
            let loginResponse = try await sut.getLogin(body: body)
            print("結果：\(loginResponse ?? "錯誤")")
            
        } catch {
            // 處理錯誤
            print("Failed to log in: \(error.localizedDescription)")
        }
    }
}
