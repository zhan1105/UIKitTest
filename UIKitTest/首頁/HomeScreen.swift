//
//  HomeScreen.swift
//  UIKitTest
//
//  Created by 紹郁 on 2025/2/6.
//

import UIKit

class HomeScreen: MyViewController {
    
    private let titleBar = MyLabel()
    private let exerciseTable = UITableView()
    
    private let screenItem = ScreenIDItem().screenItem
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        exerciseTable.delegate = self
        exerciseTable.dataSource = self
        
        self.setMyBackgroundColor(.pureWhite)
        setupUI()
    }
}

//MARK: - UI
extension HomeScreen {
    private func setupUI(){
        
        titleBar.text = "UIKitTest"
        titleBar.font = .boldTitle2
        titleBar.textAlignment = .center
        titleBar.backgroundColor = .pureWhite
                        
        exerciseTable.register(ScreenCell.self, forCellReuseIdentifier: "ScreenCell")
        exerciseTable.separatorStyle = .none
        exerciseTable.backgroundColor = .lightGrayWhite
        exerciseTable.translatesAutoresizingMaskIntoConstraints = false
        
        let appScreen = MyStack(arrangedSubviews: [titleBar, exerciseTable])
        appScreen.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(appScreen)
        NSLayoutConstraint.activate([
            appScreen.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            appScreen.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            appScreen.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            appScreen.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            
            titleBar.heightAnchor.constraint(equalTo: appScreen.heightAnchor, multiplier: 0.075),
            exerciseTable.heightAnchor.constraint(equalTo: appScreen.heightAnchor, multiplier: 0.925),
        ])
        
    }
}

//MARK: - TAbleDe
extension HomeScreen: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        screenItem.count
    }
    
    //Table顯示設定
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ScreenCell", for: indexPath) as? ScreenCell else {
            return UITableViewCell()
        }
        
        let index = indexPath.row
        let data = screenItem[index]
        cell.selectionStyle = .none
        
        cell.itemText = data.title
        
        return cell
    }
    
    //Table點擊事件
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let index = indexPath.row
        let data = screenItem[index]
        
        pushViewController(data.itemID)
    }
}
