//
//  PageViewScreen.swift
//  UIKitTest
//
//  Created by 紹郁 on 2025/2/6.
//

import UIKit
import FSPagerView

class PageViewScreen: MyViewController {
        
    private let titlebar = MyTitleBar()
    
    private let pagerView = FSPagerView()
    private let pageControl = FSPageControl()
    
    private let changeButton = MyPackageButton()
    private let pagerSelector = AppSelector()
    
    private var imageNameItem = ImageNameItem().imageData
    
    typealias PagerType = (title: String, type: FSPagerViewTransformerType)
    private let pagerItem: [PagerType] = [("淡入淡出",  .crossFading), ("縮小", .zoomOut), ("翻頁", .depth),
                                          ("線性", .linear), ("重疊", .overlap), ("摩天輪", .ferrisWheel),
                                          ("倒立摩天輪", .invertedFerrisWheel), ("封面流程", .coverFlow), ("立方體", .cubic)]
    override func viewDidLoad() {
        super.viewDidLoad()
                
        pagerView.delegate = self
        pagerView.dataSource = self
        pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        
        setPagerView()
        setPageControl()
        
        setupUI()
    }
    
    private func setPagerStyle(){
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        for item in pagerItem {
            let action = UIAlertAction(title: item.title, style: .default) { [weak self] _ in
                guard let self = self else { return }
                self.pagerSelector.fieldText = item.title
                self.pagerView.transformer = FSPagerViewTransformer(type: item.type)
                self.pagerSelector.isSelect = false
            }
            alert.addAction(action)
        }
        
        let cancelAction = UIAlertAction(
            title: String.localizedString(for: .shared(.Cancel)),
            style: .cancel
        ) { [weak self] _ in
            self?.pagerSelector.isSelect = false
        }
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
    }
}

//MARK: - UI
extension PageViewScreen {
   
    private func setupUI(){
        
        let width = UIScreen.main.bounds.width
        
        titlebar.setTitle = "Banner套件練習"
        titlebar.backButtonAction = { [weak self] in self?.popViewController()}
        
        pagerSelector.fieldText = pagerItem.last?.title ?? ""
        pagerSelector.onTapAction = { [weak self] in self?.setPagerStyle() }
        
        let spacer = MySpacer()
        
        let appScreen = MyStack(arrangedSubviews: [titlebar ,pagerView, pageControl, pagerSelector, spacer])
        appScreen.alignment = .center
        appScreen.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(appScreen)
        NSLayoutConstraint.activate([
            appScreen.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            appScreen.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            appScreen.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            appScreen.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            
            titlebar.widthAnchor.constraint(equalTo: appScreen.widthAnchor),
            titlebar.heightAnchor.constraint(equalTo: appScreen.heightAnchor, multiplier: 0.075),
            
            pagerView.widthAnchor.constraint(equalTo: appScreen.widthAnchor),
            pagerView.heightAnchor.constraint(equalTo: appScreen.heightAnchor, multiplier: 0.325),
            
            pageControl.widthAnchor.constraint(equalTo: appScreen.widthAnchor),
            pageControl.heightAnchor.constraint(equalTo: appScreen.heightAnchor, multiplier: 0.05),
            
            pagerSelector.widthAnchor.constraint(equalTo: appScreen.widthAnchor, constant: -width * 0.05),
            pagerSelector.heightAnchor.constraint(equalTo: appScreen.heightAnchor, multiplier: 0.1),
            
            spacer.heightAnchor.constraint(equalTo: appScreen.heightAnchor, multiplier: 0.45),
        ])
    }
}

//MARK: - Function
extension PageViewScreen {
    
    @objc func back() {
        popViewController()
    }
}

//MARK: - PagerView
extension PageViewScreen {
    
    func setPagerView(){
        pagerView.automaticSlidingInterval = 3.0                //設定自動切換時間為3.0秒
        pagerView.isInfinite = true                             //是否為無限循環item
        pagerView.decelerationDistance = 0                      //設定減速距離
        pagerView.itemSize = CGSize(width: self.view.frame.width, height: 250)    //設定item大小
        pagerView.interitemSpacing = 0                         //設定item間距
        pagerView.translatesAutoresizingMaskIntoConstraints = false
        
        pagerView.transformer = FSPagerViewTransformer(type: .cubic)
    }
}

//MARK: - PageControl
extension PageViewScreen {
    
    func setPageControl() {
        pageControl.numberOfPages = imageNameItem.count         //設定頁數數量
        pageControl.currentPage = 0                             //設定初始頁
        pageControl.contentHorizontalAlignment = .center        //設定水平位置
        pageControl.setStrokeColor(.oceanBlue, for: .normal)    //設定邊匡顏色(正常顯示時)
        pageControl.setStrokeColor(.gray, for: .selected)       //設定邊匡顏色(選中時)
        pageControl.setFillColor(.bg, for: .normal)             //設定畫面填充顏色(正常顯示時)
        pageControl.setFillColor(.gray, for: .selected)         //設定畫面填充顏色(選中時)
        pageControl.translatesAutoresizingMaskIntoConstraints = false
    }
}

//MARK: - Banner設定相關
extension PageViewScreen : FSPagerViewDataSource,FSPagerViewDelegate{
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return imageNameItem.count
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        
        cell.imageView?.image = UIImage(named: imageNameItem[index].name)
        pageControl.currentPage = index
        
        return cell
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        pagerView.deselectItem(at: index, animated: true)
        
        let url = imageNameItem[index].url
        UIApplication.shared.open(url)
    }
    
    func pagerViewWillEndDragging(_ pagerView: FSPagerView, targetIndex: Int) {
        pageControl.currentPage = targetIndex
    }
}
