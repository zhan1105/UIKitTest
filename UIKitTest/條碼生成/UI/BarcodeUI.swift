//
//  BarcodeUI.swift
//  UIKitTest
//
//  Created by 紹郁 on 2025/2/12.
//

import UIKit

class BarcodeUI: UIView {
    
    private let barcodeTitle_First = MyLabel()
    private let barcodeField_First = AppField()
    
    private let barcodeTitle_Second = MyLabel()
    private let barcodeField_Second = AppField()

    private let barcodeTitle_Third = MyLabel()
    private let barcodeField_Third = AppField()

    private let generateButton = MyPackageButton()
    private let clearButton = MyPackageButton()
    
    var setGenerateButtonAction: (() -> Void)? {
        didSet {
            generateButton.buttonAction = setGenerateButtonAction
        }
    }
    
    var setClearButtonAction: (() -> Void)? {
        didSet {
            clearButton.buttonAction = setClearButtonAction
        }
    }
    
    func setDelegate(_ delegate: UITextFieldDelegate) {
        let fields: [AppField] = [barcodeField_First, barcodeField_Second, barcodeField_Third]
        fields.forEach { $0.setDelegate(delegate) }
    }
    
    func getFieldText() -> [String: String] {
        let fields: [AppField] = [barcodeField_First, barcodeField_Second, barcodeField_Third]
        var result: [String: String] = [:]

        fields.forEach { field in
            if let text = field.fieldText {
                result[text] = text  // 假設 AppField 有 identifier 屬性作為 Key
            }
        }
        
        return result
    }
    
    func select_Field(_ textField: UITextField, isSelected: Bool) {
        switch textField {
        case barcodeField_First.newTextField:
            barcodeField_First.isSelect = isSelected
        case barcodeField_Second.newTextField:
            barcodeField_Second.isSelect = isSelected
        case barcodeField_Third.newTextField:
            barcodeField_Third.isSelect = isSelected
        default:
            break
        }
    }
    
    func isEmpty_Field() {
        let fields: [AppField] = [barcodeField_First, barcodeField_Second, barcodeField_Third]
        let isEmpty = fields.contains { $0.fieldText?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true }
        
        generateButton.buttonBackground = !isEmpty ? .oceanBlue : .softGray
        generateButton.buttonEnabled = !isEmpty
    }
    
    func clearField() {
        let fields: [AppField] = [barcodeField_First, barcodeField_Second, barcodeField_Third]
        fields.forEach { $0.fieldText = "" }
        
        self.isEmpty_Field()
    }
    
    init(width: CGFloat, height: CGFloat){
        super.init(frame: .zero)
        setupUI(width: width, height: height)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder: BarcodeUI) has not been implemented")
    }
    
    private func setupUI(width: CGFloat, height: CGFloat){
    
        let barcodeTitle: [MyLabel] = [barcodeTitle_First, barcodeTitle_Second, barcodeTitle_Third]
        barcodeTitle.enumerated().forEach { (index, labels) in
            labels.text = "第\(index + 1)段條碼"
            labels.font = .boldCallout
            labels.textAlignment = .left
            
            labels.widthAnchor.constraint(equalToConstant: width * 0.9).isActive = true
            labels.heightAnchor.constraint(equalToConstant: height * 0.05).isActive = true
        }
        
        let barcodeField: [AppField] = [barcodeField_First, barcodeField_Second, barcodeField_Third]
        barcodeField.enumerated().forEach { (index, fields) in
            fields.showFieldIcon = false
            fields.setKeyboardType = .asciiCapable
            fields.setAutocapitalizationType = .allCharacters
            fields.setPlaceholder = "請設定第\(index + 1)段條碼"
            
            fields.widthAnchor.constraint(equalToConstant: width * 0.9).isActive = true
            fields.heightAnchor.constraint(equalToConstant: height * 0.095).isActive = true
        }
        
        generateButton.buttonText = "生成"
        generateButton.buttonEnabled = false
        generateButton.buttonBackground = .softGray
        
        clearButton.buttonText = "清除"
        clearButton.textColor = .pureWhite
        clearButton.buttonBackground = .coralRed
        
        let myPackageButton: [MyPackageButton] = [generateButton, clearButton]
        myPackageButton.forEach {
            $0.viewPadding(to: width * 0.05)
            
            $0.widthAnchor.constraint(equalToConstant: width).isActive = true
            $0.heightAnchor.constraint(equalToConstant: height * 0.1125).isActive = true
        }
       
        let subScreen = MyStack(arrangedSubviews: [barcodeTitle_First,      barcodeField_First,
                                                   barcodeTitle_Second,     barcodeField_Second,
                                                   barcodeTitle_Third,      barcodeField_Third,
                                                   generateButton,          clearButton])
        subScreen.alignment = .center
        subScreen.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(subScreen)
        NSLayoutConstraint.activate([
            subScreen.topAnchor.constraint(equalTo: topAnchor),
            subScreen.bottomAnchor.constraint(equalTo: bottomAnchor),
            subScreen.leadingAnchor.constraint(equalTo: leadingAnchor),
            subScreen.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
}
