//
//  NetworkScreen.swift
//  UIKitTest
//
//  Created by 紹郁 on 2025/2/11.
//

import UIKit

class NetworkScreen: MyViewController {
    
    private let titleBar = MyTitleBar()
    private let imageTable = UITableView()
    
    private var networkItem = [NetworkItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageTable.delegate = self
        imageTable.dataSource = self
        
        setupUI()
        
        Task { await self.getCatApi() }
    }
}

//MARK: - UI
extension NetworkScreen {
    private func setupUI() {
        
        titleBar.setTitle = "API圖片應用"
        titleBar.backButtonAction = { [weak self] in self?.popViewController() }
        titleBar.isShowOptionsButton = true
        titleBar.optionsButtonText = "換一批"
        titleBar.optionsButtonAction = { [weak self] in
            guard let self = self else { return }
            Task { await self.getCatApi() }
        }
        
        imageTable.register(NetworkCell.self, forCellReuseIdentifier: "NetworkCell")
        imageTable.translatesAutoresizingMaskIntoConstraints = false
        
        let appScreen = MyStack(arrangedSubviews: [titleBar, imageTable])
        appScreen.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(appScreen)
        NSLayoutConstraint.activate([
            appScreen.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            appScreen.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            appScreen.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            appScreen.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            
            titleBar.heightAnchor.constraint(equalTo: appScreen.heightAnchor, multiplier: 0.1),
            imageTable.heightAnchor.constraint(equalTo: appScreen.heightAnchor, multiplier: 0.9),
        ])
    }
}

//MARK: - TableViewDelegate
extension NetworkScreen: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return networkItem.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NetworkCell", for: indexPath) as? NetworkCell else {
            return UITableViewCell()
        }
        
        let index = indexPath.row
        let data = networkItem[index]
        
        cell.setImageURL = data.url
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height / 2
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let index = indexPath.row
        
        
        tableView.reloadData()
    }
}

//MARK: - API
extension NetworkScreen {
    private func getCatApi() async {
        
        showLoading()
        
        networkItem.removeAll()
        
        let parameters: [String: String] = [
            "limit":        "10",
            "breed_ids":    "beng"
        ]
        
        do {
            let data = try await APIManager.shared.get(url: APIUrl.getCatAPI, parameters: parameters)
            let dataResponse = try JSONDecoder().decode([NetworkItem].self, from: data)
            
            DispatchQueue.main.async {
                self.networkItem.append(contentsOf: dataResponse)
                self.imageTable.reloadData()
            }
            
        } catch {
            MyPrint("CatApi_Error，請求失敗或解碼失敗：\(error.localizedDescription)")
        }
        
        dismissLoading()
    }
}
