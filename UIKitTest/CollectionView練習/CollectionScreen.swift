//
//  CollectionViewScreen.swift
//  UIKitTest
//
//  Created by 紹郁 on 2025/2/14.
//

import UIKit

class CollectionScreen: MyViewController {
    
    private let titleBar = MyTitleBar()
    private var myCollectionView: UICollectionView!
    
    private let skillsItem = SkillsItem().skillData
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setMyBackgroundColor(bottomColor: .lightGrayWhite)
        setupUI()
    }
}

//MARK: - UI
extension CollectionScreen {
    private func setupUI() {
        
        let width = UIScreen.main.bounds.width
        let safeAreaHeight = view.safeAreaLayoutGuide.layoutFrame.height
        
        titleBar.setTitle = "CollectionView練習"
        titleBar.backButtonAction = { [weak self] in self?.popViewController() }
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: width * 0.5, height: safeAreaHeight * 0.25) // 設定 cell 大小
//        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0  // 設定行距
        layout.minimumInteritemSpacing = 0  // 設定間距
        
        myCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        myCollectionView.register(CollectionCell.self, forCellWithReuseIdentifier: "CollectionCell")
        myCollectionView.delegate = self
        myCollectionView.dataSource = self
        myCollectionView.showsHorizontalScrollIndicator = false
        
        myCollectionView.backgroundColor = .lightGrayWhite
        myCollectionView.translatesAutoresizingMaskIntoConstraints = false
                
        let appScreen = MyStack(arrangedSubviews: [titleBar, myCollectionView])
        appScreen.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(appScreen)
        NSLayoutConstraint.activate([
            appScreen.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            appScreen.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            appScreen.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            appScreen.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            
            titleBar.heightAnchor.constraint(equalTo: appScreen.heightAnchor, multiplier: 0.1),
            myCollectionView.heightAnchor.constraint(equalTo: appScreen.heightAnchor, multiplier: 0.9),
        ])
    }
}

//MARK: - CollectionViewDelegate
extension CollectionScreen: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return skillsItem.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as! CollectionCell
        
        let index = indexPath.row
        let data = skillsItem[index]
        
        cell.setTitle = data.title
        cell.setImage = data.icon
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("row: \(indexPath.row)")
    }
}
