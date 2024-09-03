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
        
        let testButton = MyButton(text: "測試")
        testButton.buttonAction = { [weak self] in
            Task {
//                await self?.getImage()
                await self?.testLogin()
            }
        }
        
        // 添加按鈕到視圖中
        view.addSubview(testButton)
        // 設置按鈕的布局 (假設你有 Auto Layout 的約束)
        testButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            testButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            testButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            testButton.widthAnchor.constraint(equalToConstant: 100),
            testButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func getImage() async {
        let sut = APIManager.shared
        
        do {
            let image = try await sut.getImage()
            print(image[0].id)
        } catch {
            print("Error fetching image: \(error)")
        }
    }
    
    func testLogin() async {
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
