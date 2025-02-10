//
//  MySelectorScreen.swift
//  UIKitTest
//
//  Created by 紹郁 on 2025/2/10.
//

import UIKit

class MySelectorScreen: MyViewController {
    
    private let titleBar = MyTitleBar()
    private let mySelector = AppSelector()

    private let selectItem: [String] = ["選項01", "選項02", "選項03", "選項04", "選項05"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    private func setSelector() {
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        for item in selectItem {
            let action = UIAlertAction(title: item, style: .default) { [weak self] _ in
                guard let self = self else { return }
                self.mySelector.fieldText = item
                self.mySelector.isSelect = false
            }
            alert.addAction(action)
        }
        
        let cancelAction = UIAlertAction(
            title: String.localizedString(for: .shared(.Cancel)),
            style: .cancel
        ) { [weak self] _ in
            self?.mySelector.isSelect = false
        }
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
    }
}

//MARK: - UI
extension MySelectorScreen {
    private func setupUI() {
        
        let width = UIScreen.main.bounds.width
        
        titleBar.setTitle = "自定義選擇器"
        titleBar.backButtonAction = { [weak self] in self?.popViewController() }
        
        mySelector.setIcon = .unselectList
        mySelector.onTapAction = { [weak self] in self?.setSelector() }
        
        let spacer = MySpacer()
        
        let appScreen = MyStack(arrangedSubviews: [titleBar, mySelector, spacer])
        appScreen.alignment = .center
        appScreen.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(appScreen)
        NSLayoutConstraint.activate([
            appScreen.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            appScreen.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            appScreen.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            appScreen.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            
            titleBar.widthAnchor.constraint(equalToConstant: width),
            titleBar.heightAnchor.constraint(equalTo: appScreen.heightAnchor, multiplier: 0.1),
            
            mySelector.widthAnchor.constraint(equalToConstant: width * 0.9),
            mySelector.heightAnchor.constraint(equalTo: appScreen.heightAnchor, multiplier: 0.135),
            
            spacer.heightAnchor.constraint(equalTo: appScreen.heightAnchor, multiplier: 0.765),
        ])
    }
}
