//
//  CameraOverlayScreen.swift
//  UIKitTest
//
//  Created by 紹郁 on 2024/9/5.
//

import UIKit
import AVFoundation

class CameraOverlayScreen: MyViewController {
    
    var subScreen = CameraOverlayUI()
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkCameraPermission()
        setupUI()
    }
    
    func checkCameraPermission() {
        let cameraAuthorizationStatus = AVCaptureDevice.authorizationStatus(for: .video)
        
        switch cameraAuthorizationStatus {
        case .notDetermined:
            // 第一次請求權限
            AVCaptureDevice.requestAccess(for: .video) { granted in
                if granted {
                    // 使用者允許相機權限
                    DispatchQueue.main.async {
                        self.setupCamera()
                    }
                } else {
                    // 使用者拒絕權限
                    self.showPermissionDeniedAlert()
                }
            }
        case .authorized:
            // 設定相機
            setupCamera()
            
            // 設定疊加視圖
            setupOverlay()
        case .restricted, .denied:
            // 使用者拒絕或無權限使用相機
            showPermissionDeniedAlert()
        @unknown default:
            break
        }
    }
    
    func showPermissionDeniedAlert() {
        let alert = UIAlertController(title: "相機權限被拒絕", message: "請在設定中允許存取相機。", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "確定", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func setupCamera() {
        // 初始化 AVCaptureSession
        captureSession = AVCaptureSession()
        captureSession.sessionPreset = .photo
        
        guard let backCamera = AVCaptureDevice.default(for: .video) else {
            print("無法取得相機")
            return
        }
        
        do {
            let input = try AVCaptureDeviceInput(device: backCamera)
            captureSession.addInput(input)
        } catch {
            print("無法設定相機輸入: \(error)")
            return
        }
        
        // 設定相機預覽
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.videoGravity = .resizeAspectFill
        previewLayer.frame = view.layer.bounds
        view.layer.addSublayer(previewLayer)
        
        // 開始相機 session
        captureSession.startRunning()
    }
    
    func setupOverlay() {
        // 自訂疊加視圖
        let overlayView = UIView(frame: view.bounds)
        overlayView.backgroundColor = UIColor.black.withAlphaComponent(0.3) // 半透明黑色
        overlayView.isUserInteractionEnabled = false // 不影響相機操作
        
        // 在上面加其他 UI 元素，例如一個瞄準框
        let targetView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        targetView.center = view.center
        targetView.layer.borderWidth = 2
        targetView.layer.borderColor = UIColor.red.cgColor
        
        overlayView.addSubview(targetView)
        view.addSubview(overlayView) // 疊加在相機預覽上
    }
}
//MARK: - subView
extension CameraOverlayScreen {
    
    private func setupUI(){
        
        let myTitleBar = MyTitleBar(text: "相機遮罩")
        myTitleBar.backButtonAction = { [weak self] in self?.popViewController() }
        
        let subScreen = CameraOverlayUI()
    }
}
