//
//  NSLayoutConstraintVC.swift
//  UIKitTest
//
//  Created by 紹郁 on 2024/8/13.
//

import UIKit

class LayoutConstraintScreen: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        let redView = UIView()
        //        redView.backgroundColor = .red
        //        redView.translatesAutoresizingMaskIntoConstraints = false
        //
        //        self.view.addSubview(redView)
        //
        //        let constraints = [
        //            redView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 15),
        //            redView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -15),
        //            redView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
        //            redView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -15)
        //        ]
        //
        //        // 激活约束
        //        NSLayoutConstraint.activate(constraints)
        
        addView()
    }
}

extension LayoutConstraintScreen {
    
    func addView() {
        let redView = UIView()
        let blueView = UIView()
        let greenView = UIView()
        
        redView.backgroundColor = .red
        blueView.backgroundColor = .blue
        greenView.backgroundColor = .green
        
        redView.translatesAutoresizingMaskIntoConstraints = false
        blueView.translatesAutoresizingMaskIntoConstraints = false
        greenView.translatesAutoresizingMaskIntoConstraints = false
        
        let vStackView = UIStackView(arrangedSubviews: [redView, blueView, greenView])
        vStackView.axis = .vertical
        vStackView.distribution = .fill
        vStackView.translatesAutoresizingMaskIntoConstraints = false

        self.view.addSubview(vStackView)
        
        NSLayoutConstraint.activate([
            vStackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
            vStackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0),
            vStackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0),
            vStackView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
        
        redView.heightAnchor.constraint(equalTo: vStackView.heightAnchor, multiplier: 0.15).isActive = true
        blueView.heightAnchor.constraint(equalTo: vStackView.heightAnchor, multiplier: 0.7).isActive = true
        greenView.heightAnchor.constraint(equalTo: vStackView.heightAnchor, multiplier: 0.15).isActive = true
    }
}
