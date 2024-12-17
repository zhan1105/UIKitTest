//
//  Image+.swift
//  UIKitTest
//
//  Created by 紹郁 on 2024/12/3.
//

import UIKit

extension UIImage {
    /// 確保圖片轉換為 CGImage
    private func ensureCGImage() -> CGImage? {
        if let cgImage = self.cgImage {
            return cgImage
        }
        guard let ciImage = self.ciImage else {
            print("圖片既不是 CGImage 也不是 CIImage")
            return nil
        }
        
        let context = CIContext()
        guard let renderedCGImage = context.createCGImage(ciImage, from: ciImage.extent) else {
            print("無法渲染 CIImage 為 CGImage")
            return nil
        }
        return renderedCGImage
    }

    /// 分割圖片為多段
    func splitIntoThreeParts() -> [UIImage]? {
        guard let cgImage = self.ensureCGImage() else {
            print("無法獲取 CGImage")
            return nil
        }
        
        let width = cgImage.width
        let height = cgImage.height
        let partWidth = width / 3 // 確保分割為三等分
        var images: [UIImage] = []

        for i in 0..<3 {
            let rect = CGRect(x: i * partWidth, y: 0, width: partWidth, height: height)
            
            guard let croppedCGImage = cgImage.cropping(to: rect) else {
                print("裁剪失敗，範圍：\(rect)")
                return nil
            }
            
            images.append(UIImage(cgImage: croppedCGImage))
        }

        return images
    }
}
