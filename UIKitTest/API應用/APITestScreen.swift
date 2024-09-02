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
                await self?.test()
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
    
    func test() async {
        let sut = APIManager.shared
        
        do {
            let image = try await sut.getImage()
            print(image[1].url)
        } catch {
            print("Error fetching image: \(error)")
        }
        
    }
}
