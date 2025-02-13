//
//  BarcodeScreen.swift
//  UIKitTest
//
//  Created by 紹郁 on 2025/2/12.
//

import UIKit

class BarcodeScreen: MyViewController {
    
    private let titleBar = MyTitleBar()

    private let scrollView = UIScrollView()
    private var contentView: BarcodeUI!
    
    private var barcodeImageView = [UIView]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    private func displayBarcodes() {
        
        titleBar.isShowOptionsButton = true
        
        // 條碼及對應文字
        let barcodesWithTexts = contentView.getFieldText()
        
        barcodeImageView.removeAll()
        
        for (barcode, text) in barcodesWithTexts {
            let barcodeView = createBarcodeView(for: barcode, with: text)
            
            barcodeImageView.append(contentsOf: [barcodeView])
        }
        
        let barcodeAlert = BarcodeAlert()
        barcodeAlert.addArrangedSubviews(barcodeImageView)
        self.overlayAlert(barcodeAlert)
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
        label.font = UIFont.body
        label.textAlignment = .center
        
        // 添加到容器
        container.addArrangedSubview(barcodeImageView)
        container.addArrangedSubview(label)
        
        return container
    }
}

//MARK: - UI
extension BarcodeScreen {
    private func setupUI() {
        
        let width = UIScreen.main.bounds.width
        let safeAreaHeight = view.safeAreaLayoutGuide.layoutFrame.height
        
        titleBar.setTitle = "條碼生成"
        titleBar.backButtonAction = { [weak self] in self?.popViewController() }
        
        titleBar.optionsButtonText = "顯示"
        titleBar.optionsButtonAction = { [weak self] in
            guard let self = self else { return }
            self.displayBarcodes()
        }
        
        contentView = BarcodeUI(width: width, height: safeAreaHeight)
        contentView.setDelegate(self)
        contentView.setGenerateButtonAction = { [weak self] in
            guard let self = self else { return }
            self.displayBarcodes()
        }
        
        contentView.setClearButtonAction = { [weak self] in
            guard let self = self else { return }
            self.titleBar.isShowOptionsButton = false
            self.contentView.clearField()
        }
        
        let appScreen = MyStack(arrangedSubviews: [titleBar, scrollView])
        appScreen.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(appScreen)
        NSLayoutConstraint.activate([
            appScreen.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            appScreen.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            appScreen.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            appScreen.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            
            titleBar.heightAnchor.constraint(equalTo: appScreen.heightAnchor, multiplier: 0.1),
            scrollView.heightAnchor.constraint(equalTo: appScreen.heightAnchor, multiplier: 0.9),
        ])
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
}

//MARK: - UITextFieldDelegate
extension BarcodeScreen: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let currentText = textField.text ?? ""

        let Characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890"
        let allowedCharacters = CharacterSet(charactersIn: Characters)
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        contentView.isEmpty_Field()
    }
    
    func updateFieldSelection(for textField: UITextField, isSelected: Bool) {
        contentView.select_Field(textField, isSelected: isSelected)
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        updateFieldSelection(for: textField, isSelected: true)
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        updateFieldSelection(for: textField, isSelected: false)
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
