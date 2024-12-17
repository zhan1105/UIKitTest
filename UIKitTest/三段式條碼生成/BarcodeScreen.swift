//
//  BarcodeScreen.swift
//  UIKitTest
//
//  Created by 紹郁 on 2024/12/3.
//

import UIKit

class BarcodeScreen: UIViewController {
    
    let stackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupStackView()
        displayBarcodes()
    }
    
    private func setupStackView() {
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9)
        ])
    }
    
    private func displayBarcodes() {
        // 條碼及對應文字
        let barcodesWithTexts = [
            ("130930K5G", "130930K5G"),
            ("001090J0542D7938", "001090J0542D7938"),
            ("124681000001650", "124681000001650")
        ]
        
        for (barcode, text) in barcodesWithTexts {
            let barcodeView = createBarcodeView(for: barcode, with: text)
            stackView.addArrangedSubview(barcodeView)
        }
    }
    
    private func createBarcodeView(for barcode: String, with text: String) -> UIView {
        let container = UIStackView()
        container.axis = .vertical
        container.spacing = 8
        container.alignment = .center
        
        // 條碼圖片
        let barcodeImageView = UIImageView()
        if let barcodeImage = UIImage.generateBarcode(from: barcode, size: CGSize(width: 450, height: 150)) {
            barcodeImageView.image = barcodeImage
        }
        barcodeImageView.contentMode = .scaleAspectFit
        
        // 條碼文字
        let label = UILabel()
        label.text = text
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        
        // 添加到容器
        container.addArrangedSubview(barcodeImageView)
        container.addArrangedSubview(label)
        
        return container
    }
}

extension UIImage {
    static func generateBarcode(from string: String, size: CGSize) -> UIImage? {
        guard let filter = CIFilter(name: "CICode128BarcodeGenerator") else { return nil }
        filter.setValue(string.data(using: .ascii), forKey: "inputMessage")
        
        guard let outputImage = filter.outputImage else { return nil }
        let transform = CGAffineTransform(scaleX: size.width / outputImage.extent.width,
                                          y: size.height / outputImage.extent.height)
        let scaledImage = outputImage.transformed(by: transform)
        
        return UIImage(ciImage: scaledImage)
    }
}
