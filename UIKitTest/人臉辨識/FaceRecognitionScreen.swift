//
//  FaceRecognitionScreen.swift
//  UIKitTest
//
//  Created by 紹郁 on 2024/8/29.
//

import UIKit
import LocalAuthentication

class FaceRecognitionScreen: UIViewController {
        
    let faceRecognitionUI = FaceRecognitionUI()
    var message = FaceRecognitionUI().message
    
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
                            print("Face ID 認證成功，回傳ID: \(policyDomainStateString)")
                                                
                            // 在這裡可以使用回傳ID進行額外的處理
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
        
        faceRecognitionUI.backButtonAction = { [weak self] in self?.popView() }
        faceRecognitionUI.verifyButtonAction = { [weak self] in self?.authenticateWithFaceID() }
        faceRecognitionUI.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(faceRecognitionUI)
        NSLayoutConstraint.activate([
            faceRecognitionUI.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            faceRecognitionUI.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            faceRecognitionUI.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            faceRecognitionUI.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
}
