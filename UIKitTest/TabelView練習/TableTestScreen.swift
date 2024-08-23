//
//  TabelViewTest.swift
//  UIKitTest
//
//  Created by 紹郁 on 2024/8/15.
//

import UIKit

class TableTestScreen: UIViewController {
    
    var screenIDItem = ScreenIDItem().screenItem

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let table = UITableView()
        table.delegate = self
        table.dataSource = self
        
        table.register(TableCell.self, forCellReuseIdentifier: "Cell")
        table.separatorStyle = .none
        self.view.addSubview(table)
        
        table.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            table.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            table.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            table.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            table.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}

extension TableTestScreen: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        screenIDItem.count
    }
    
    //Table顯示設定
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? TableCell else {
            return UITableViewCell()
        }
        
        let index = indexPath.row
        let data = screenIDItem[index]
        cell.selectionStyle = .none
        
        cell.itemText = data.title
        
        return cell
    }
    
    //Table點擊事件
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let index = indexPath.row
        let data = screenIDItem[index]
        
        pushView(data.itemID)
    }
}
