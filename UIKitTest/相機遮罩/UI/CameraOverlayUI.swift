//
//  CameraOverlayUI.swift
//  UIKitTest
//
//  Created by 紹郁 on 2024/9/5.
//

import UIKit
import AVFoundation

class CameraOverlayUI: UIView {

    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    
    init(){
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        
    }
}
