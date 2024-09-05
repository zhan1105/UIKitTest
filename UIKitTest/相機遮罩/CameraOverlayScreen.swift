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
    var photoOutput: AVCapturePhotoOutput!
    var currentCameraPosition: AVCaptureDevice.Position = .back
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkCameraPermission()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // 更新 previewLayer 的框架
        previewLayer.frame = subScreen.targetView.layer.bounds
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
            setupUI()
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
        
        configureCamera(for: .back) // 初始設置為後鏡頭
        
        photoOutput = AVCapturePhotoOutput()
        
        // 確保添加輸出到會話中
        if captureSession.canAddOutput(photoOutput) {
            captureSession.addOutput(photoOutput)
        } else {
            print("無法添加 Photo Output 到 Capture Session")
            return
        }
        
        // 設定相機預覽
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.videoGravity = .resizeAspectFill
        // 確保在 layoutSubviews 中設置框架
        previewLayer.frame = subScreen.targetView.layer.bounds
        subScreen.targetView.layer.addSublayer(previewLayer) // 改為將預覽層添加到 targetView
        
        // 開始相機 session
        captureSession.startRunning()
        
        // 確認 AVCaptureConnection 是否有效
        if let connection = photoOutput.connection(with: .video), connection.isEnabled {
            print("有效的相機連接已建立")
        } else {
            print("無法建立相機連接")
        }
    }
    
    func configureCamera(for position: AVCaptureDevice.Position) {
        guard let currentInput = captureSession.inputs.first as? AVCaptureDeviceInput else { return }
        captureSession.removeInput(currentInput)
        
        let discoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera],
                                                                mediaType: .video,
                                                                position: .unspecified)
        
        let devices = discoverySession.devices
        guard let newCamera = devices.first(where: { $0.position == position }) else { return }
        
        do {
            let newInput = try AVCaptureDeviceInput(device: newCamera)
            if captureSession.canAddInput(newInput) {
                captureSession.addInput(newInput)
                currentCameraPosition = position
            }
        } catch {
            print("無法設定相機輸入: \(error)")
        }
    }
    
    func switchCamera() {
        let newPosition: AVCaptureDevice.Position = (currentCameraPosition == .back) ? .front : .back
        configureCamera(for: newPosition)
    }
    
    func Photograph() {
        let photoSettings = AVCapturePhotoSettings()
        
        if let connection = photoOutput.connection(with: .video) {
            connection.videoOrientation = .landscapeRight // 設置為設備的方向
        }
        
        photoOutput.capturePhoto(with: photoSettings, delegate: self)
    }
}
//MARK: - subView
extension CameraOverlayScreen {
    
    private func setupUI(){
        
        let myTitleBar = MyTitleBar(text: "相機遮罩")
        myTitleBar.backButtonAction = { [weak self] in self?.popViewController() }
        
        subScreen.cameraButton.buttonAction = { [weak self] in self?.Photograph() }
        subScreen.switchButton.buttonAction = { [weak self] in self?.switchCamera() }
        
        let appScreen = MyStack(arrangedSubviews: [myTitleBar, subScreen])
        appScreen.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(appScreen)
        NSLayoutConstraint.activate([
            appScreen.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            appScreen.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            appScreen.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            appScreen.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            
            myTitleBar.heightAnchor.constraint(equalTo: appScreen.heightAnchor, multiplier: 0.1),
            subScreen.heightAnchor.constraint(equalTo: appScreen.heightAnchor, multiplier: 0.9)
        ])
    }
}

// MARK: - AVCapturePhotoCaptureDelegate
extension CameraOverlayScreen: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if let error = error {
            print("拍照錯誤: \(error)")
            return
        }
        
        guard let photoData = photo.fileDataRepresentation(),
              let fullImage = UIImage(data: photoData) else {
            return
        }
        
        // 獲取 targetView 的範圍
        let targetFrame = subScreen.targetView.frame
        
        // 計算預覽層的比例（如果預覽層和實際捕捉的畫面大小不一致）
        let previewLayerSize = previewLayer.bounds.size
        let fullImageSize = fullImage.size
        
        // 計算比例因子
        let scaleX = fullImageSize.width / previewLayerSize.width
        let scaleY = fullImageSize.height / previewLayerSize.height
        
        // 計算裁剪區域（轉換 targetView 的 frame 到圖片上的區域）
        let cropRect = CGRect(x: targetFrame.origin.x * scaleX,
                              y: targetFrame.origin.y * scaleY,
                              width: targetFrame.width * scaleX,
                              height: targetFrame.height * scaleY)
        
        // 裁剪圖片
        if let croppedImage = cropImage(fullImage, toRect: cropRect) {
            // 將裁剪後的圖片顯示在 imageView 中
            subScreen.showImageView.image = croppedImage
        }
    }
    
    // 裁剪圖片的輔助函數
    func cropImage(_ image: UIImage, toRect rect: CGRect) -> UIImage? {
        guard let cgImage = image.cgImage?.cropping(to: rect) else {
            print("無法裁剪圖片")
            return nil
        }
        return UIImage(cgImage: cgImage)
    }
}

