//
//  FaceRecognitionScreen.swift
//  UIKitTest
//
//  Created by 紹郁 on 2025/2/10.
//

import UIKit
import LocalAuthentication

class FaceRecognitionScreen: MyViewController {
        
    private let titlebar = MyTitleBar()
    private let faceRecognitionUI = FaceRecognitionUI()
    private var message = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    func authenticateWithFaceID() {
        
        let context = LAContext()
        var error: NSError?
        
        // 檢查是否支持生物識別（Face ID 或 Touch ID）
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "使用 Face ID 進行身份驗證"
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                DispatchQueue.main.async { [self] in
                    if success {
                        // 認證成功，獲取回傳ID，轉換為 String
                        if let policyDomainState = context.evaluatedPolicyDomainState {
                            let policyDomainStateString = policyDomainState.base64EncodedString()
                                                
                            message = "Face ID 認證成功，回傳ID: \(policyDomainStateString)"
                        }
                    } else {
                        // 認證失敗，顯示錯誤信息
                        if let error = authenticationError as? LAError {
                            switch error.code {
                            case .appCancel:
                                message = "應用程式取消認證"
                            case .userCancel:
                                message = "用戶取消認證"
                            case .authenticationFailed:
                                message = "認證失敗"
                            case .biometryNotEnrolled:
                                message = "未設定 Face ID 或 Touch ID"
                            case .biometryLockout:
                                message = "生物識別被鎖定，需要用戶解鎖"
                            default:
                                message = "未知的錯誤"
                            }
                        }
                    }
                    faceRecognitionUI.messageLabel.text = message
                }
            }
        } else {
            // 不支持生物識別，顯示相應的錯誤信息
            if let error = error {
                message = "生物識別不可用: \(error.localizedDescription)"
            }
        }
    }
}

//MARK: - subView
extension FaceRecognitionScreen {
    
    private func setupUI() {
        
        titlebar.setTitle = "FaceID驗證"
        titlebar.backButtonAction = { [weak self] in self?.popViewController() }
        
        faceRecognitionUI.verifyButton.buttonAction = { [weak self] in self?.authenticateWithFaceID() }
        
        let appScreen = MyStack(arrangedSubviews: [titlebar, faceRecognitionUI])
        
        self.view.addSubview(appScreen)
        
        appScreen.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            appScreen.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            appScreen.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            appScreen.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            appScreen.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            
            titlebar.heightAnchor.constraint(equalTo: appScreen.heightAnchor, multiplier: 0.1),
            faceRecognitionUI.heightAnchor.constraint(equalTo: appScreen.heightAnchor, multiplier: 0.9)
        ])
    }
}
