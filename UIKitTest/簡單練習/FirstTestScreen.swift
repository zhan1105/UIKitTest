//
//  UIKitTestVC.swift
//  UIKitTest
//
//  Created by 紹郁 on 2024/8/13.
//

import UIKit

class FirstTestScreen: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        // 创建 VStackView
//        let vStackView = UIStackView()
//        vStackView.axis = .vertical  // 设置为垂直方向
//        vStackView.distribution = .fillEqually  // 每个子视图的大小均分
//        vStackView.alignment = .center  // 所有子视图居中对齐
//        vStackView.spacing = 50  // 子视图之间的间距
//        vStackView.translatesAutoresizingMaskIntoConstraints = false
//        
//        // 添加子视图到 VStackView 中
//        let label1 = UILabel()
//        label1.text = "Label 1"
//        label1.backgroundColor = .bg
//        label1.font = UIFont.title1
//        
//        let label2 = UILabel()
//        label2.text = "Label 2"
//        label2.backgroundColor = .green
//        
//        let label3 = UILabel()
//        label3.text = "Label 3"
//        label3.backgroundColor = .blue
//        
//        let label4 = UILabel()
//        label4.text = "123456"
//        label4.backgroundColor = .brown
//        label4.font = UIFont.title1
//        
//        vStackView.addArrangedSubview(label1)
//        vStackView.addArrangedSubview(label2)
//        vStackView.addArrangedSubview(label3)
//        vStackView.addArrangedSubview(label4)
//        
//        // 将 VStackView 添加到主视图
//        self.view.addSubview(vStackView)
//        
//        // 设置 VStackView 的 Auto Layout 约束
//        NSLayoutConstraint.activate([
//            vStackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
//            vStackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
//            vStackView.widthAnchor.constraint(equalToConstant: 200),
//            vStackView.heightAnchor.constraint(equalToConstant: 300)  // 调整高度以适应较大的间距
//        ])
        
        let label1 = UILabel()
        label1.text = "Label1"
        label1.backgroundColor = .systemGray
        label1.font = UIFont.preferredFont(forTextStyle: .title1)
        label1.textColor = .black
        label1.textAlignment = .center

        // 將 label1 加入主要畫面中
        self.view.addSubview(label1)

        // 設定 view 的 AutoLayout 約束
        label1.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label1.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 15),
            label1.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -15),
            label1.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            label1.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -15)
        ])
    }
}

//MARK: - SubView
extension FirstTestScreen {
    
    func addView(x: CGFloat = 150, y : CGFloat = 150, width: CGFloat, height: CGFloat, Color: UIColor) {
        
        let testView = UIView()
        testView.frame = CGRect(x: x, y: y, width: width, height: height)
        testView.backgroundColor = Color
        
        self.view.addSubview(testView)
    }
    
    func mainSFImage(systemName: String) {
        let image = UIImage(systemName: systemName)
        let imageView = UIImageView(image: image)
        imageView.frame = CGRect(x: 100, y: 100, width: 50, height: 50)
        imageView.backgroundColor = UIColor.bg
        
        self.view.addSubview(imageView)
    }
}
