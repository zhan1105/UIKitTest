//
//  CameraScreen.swift
//  UIKitTest
//
//  Created by 紹郁 on 2025/2/11.
//

import UIKit
import AVFoundation

class CameraScreen: UIViewController {
    
    private let titleBar = CameraBackUI()
    private let cameraView = CameraViewUI()
    
    private var captureSession: AVCaptureSession!
    private var previewLayer: AVCaptureVideoPreviewLayer!
    private var photoOutput: AVCapturePhotoOutput!
    private var currentCameraPosition: AVCaptureDevice.Position = .back
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        cameraView.setShowImage = nil
    }
    
    //拍照
    func Photograph() {
        let photoSettings = AVCapturePhotoSettings()
        
        if let connection = photoOutput.connection(with: .video) {
            connection.videoOrientation = .portrait // 設置為設備的方向
        }
        
        photoOutput.capturePhoto(with: photoSettings, delegate: self)
    }
}
//MARK: - UI
extension CameraScreen {
    private func setupUI() {
        
        titleBar.backgroundColor = .charcoalBlack.withAlphaComponent(0.7)
        titleBar.backButtonAction = { [weak self] in self?.popViewController() }
                
        cameraView.setButtonAction(for: .Camera){ [weak self] in
            self?.Photograph()
        }
        
        cameraView.setButtonAction(for: .CameraTurn){ [weak self] in
            self?.switchCamera()
        }
                
        let appScreen = MyStack(arrangedSubviews: [titleBar, cameraView])
        appScreen.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(appScreen)
        NSLayoutConstraint.activate([
            appScreen.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            appScreen.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            appScreen.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            appScreen.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            
            titleBar.heightAnchor.constraint(equalTo: appScreen.heightAnchor, multiplier: 0.1),
            cameraView.heightAnchor.constraint(equalTo: appScreen.heightAnchor, multiplier: 0.9),
        ])
        setBackgroundColor()
    }
    
    private func setBackgroundColor(){
        
        view.backgroundColor = .charcoalBlack
        
        let topColorView = UIView()
        topColorView.backgroundColor = .charcoalBlack.withAlphaComponent(0.7)
        topColorView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(topColorView)
        
        let bottomColorView = UIView()
        bottomColorView.backgroundColor = .charcoalBlack.withAlphaComponent(0.7)
        bottomColorView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bottomColorView)
        
        let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let stateHeight = scene?.statusBarManager?.statusBarFrame.height
        let bottomSafeAreaHeight = scene?.windows.first?.safeAreaInsets.bottom
        
        NSLayoutConstraint.activate([
            topColorView.topAnchor.constraint(equalTo: view.topAnchor),
            topColorView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topColorView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topColorView.heightAnchor.constraint(equalToConstant: stateHeight!),
            
            bottomColorView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bottomColorView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomColorView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomColorView.heightAnchor.constraint(equalToConstant: bottomSafeAreaHeight!),
        ])
        
        checkCameraPermission()
    }
}

//MARK: - CameraPermission
extension CameraScreen {
    func checkCameraPermission() {
        let cameraAuthorizationStatus = AVCaptureDevice.authorizationStatus(for: .video)
        
        switch cameraAuthorizationStatus {
        case .notDetermined:
            // 第一次請求權限
            AVCaptureDevice.requestAccess(for: .video) { granted in
                DispatchQueue.main.async {
                    if granted {
                        self.setupCamera()
                    }
                }
            }
        case .authorized:
            // 已獲得權限，設置相機
            self.setupCamera()
        case .restricted, .denied:
            // 無權限時顯示權限提示，但不進行其他行為
            showPermissionAlert()
        @unknown default:
            break
        }
    }
    
    func showPermissionAlert() {
        let alertController = UIAlertController(
            title: "相機權限已禁用",
            message: "請在設定中啟用相機權限以使用拍照功能",
            preferredStyle: .alert
        )
        
        let settingsAction = UIAlertAction(title: "前往設定", style: .default) { _ in
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                return
            }
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, options: [:], completionHandler: nil)
            }
        }
        
        let cancelAction = UIAlertAction(title: "取消", style: .cancel) {_ in
            self.popViewController()
        }
        
        alertController.addAction(settingsAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
}

//MARK: - Camera設定
extension CameraScreen {
    func setupCamera() {
        // 初始化 AVCaptureSession
        captureSession = AVCaptureSession()
        if captureSession.canSetSessionPreset(.high) {
            captureSession.sessionPreset = .high
        } else if captureSession.canSetSessionPreset(.medium) {
            captureSession.sessionPreset = .medium
        } else {
            captureSession.sessionPreset = .low
        }
        
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
        
        previewLayer.frame = self.view.bounds
        
        self.view.layer.insertSublayer(previewLayer, at: 0)
        
        DispatchQueue.global(qos: .background).async {
            self.captureSession.startRunning()
        }
        
        // 確認 AVCaptureConnection 是否有效
        if let connection = photoOutput.connection(with: .video), connection.isEnabled {
            connection.videoOrientation = .portrait
            print("有效的相機連接已建立")
        } else {
            print("無法建立相機連接")
        }
    }
}

//MARK: - Camera切換前後相機
extension CameraScreen {
    
    func switchCamera() {
        let newPosition: AVCaptureDevice.Position = (currentCameraPosition == .back) ? .front : .back
        configureCamera(for: newPosition)
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
}

//MARK: - AVCapturePhotoCaptureDelegate
extension CameraScreen: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if let error = error {
            print("拍照錯誤: \(error)")
            return
        }
        
        guard let photoData = photo.fileDataRepresentation(),
              let fullImage = UIImage(data: photoData)?.fixOrientation() else {
            return
        }
        
        let fullImageWidth = fullImage.size.width
        let fullImageHeight = fullImage.size.height
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        
        //TODO: 裁切圖片仍需調整
        let targetFrame = cameraView.cameraView.frame
        
        let targetHeight = targetFrame.size.height
        
        let scaleX = fullImageWidth / screenWidth
        let scaleY = fullImageHeight / screenHeight
        
        let targetScaleX = screenWidth * 0.075 * scaleX
        let targetScaleY = screenHeight * 0.15 * scaleY
        let targetScaleWidth = screenWidth * 0.85 * scaleX
        let targetScaleHeight = targetHeight * scaleY
        
        let scaledTargetFrame = CGRect(x: targetScaleX,
                                       y: targetScaleY,
                                       width: targetScaleWidth,
                                       height: targetScaleHeight)
        
//        DispatchQueue.global(qos: .background).async {
//            self.captureSession.stopRunning()
//        }
        
        if let croppedImage = cropImage(fullImage, toRect: scaledTargetFrame) {
            cameraView.setShowImage = croppedImage
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
