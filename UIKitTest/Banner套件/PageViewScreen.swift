//
//  PageViewScreen.swift
//  UIKitTest
//
//  Created by 紹郁 on 2024/8/19.
//

import UIKit
import FSPagerView

class PageViewScreen: UIViewController {
    
    var imageNameItem = ImageNameItem().imageData
    
    let pagerView = FSPagerView()
    let pageControl = FSPageControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .groupBg
        
        pagerView.dataSource = self
        pagerView.delegate = self
        pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        
        let titleBar = titleBar
        titleBar.backgroundColor = .clear
        
        setPagerView()
        setPageControl()

        let bannerView = UIStackView(arrangedSubviews: [titleBar ,pagerView, pageControl])
        bannerView.axis = .vertical
        bannerView.distribution = .fill
        
        self.view.addSubview(bannerView)
        
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bannerView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            bannerView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            bannerView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            bannerView.heightAnchor.constraint(equalToConstant: 350)
        ])
        
        titleBar.heightAnchor.constraint(equalTo: bannerView.heightAnchor, multiplier: 0.15).isActive = true
        pagerView.heightAnchor.constraint(equalTo: bannerView.heightAnchor, multiplier: 0.75).isActive = true
        pageControl.heightAnchor.constraint(equalTo: bannerView.heightAnchor, multiplier: 0.1).isActive = true
    }
}
//MARK: - SubView
extension PageViewScreen {
    var titleBar: UIView {
        
        let titleLabel = mainLabelView(labelText: "Banner套件練習", font: .title1, isBold: true, _textColor: .black, aligment: .center, background: .clear)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let backButton = mainArrowButtonView(symbol: .arrow_left, target: self, action: #selector(back))
        backButton.tintColor = .black
        backButton.translatesAutoresizingMaskIntoConstraints = false
        
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let titleBarStack = UIStackView(arrangedSubviews: [backButton, titleLabel, view])
        titleBarStack.axis = .horizontal
        titleBarStack.distribution = .fill
        titleBarStack.translatesAutoresizingMaskIntoConstraints = false
        
        backButton.widthAnchor.constraint(equalTo: titleBarStack.widthAnchor, multiplier: 0.15).isActive = true
        titleLabel.widthAnchor.constraint(equalTo: titleBarStack.widthAnchor, multiplier: 0.7).isActive = true
        view.widthAnchor.constraint(equalTo: titleBarStack.widthAnchor, multiplier: 0.15).isActive = true
        
        return titleBarStack
    }

}

//MARK: - Function
extension PageViewScreen {
    
    @objc func back() {
        popView()
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
        
        setPagerTransformer(.cubic)
    }
    
    func setPagerTransformer(_ TransformerType: FSPagerViewTransformerType) {
        pagerView.transformer = FSPagerViewTransformer(type: TransformerType)

        //.crossFading          淡入淡出
        //.zoomOut              縮小
        //.depth                翻頁
        //.linear               線性
        //.overlap              重疊
        //.ferrisWheel          摩天輪
        //.invertedFerrisWheel  倒立摩天輪
        //.coverFlow            封面流程
        //.cubic                立方體
    }
}

//MARK: - PageControl
extension PageViewScreen {
    
    func setPageControl() {
        pageControl.numberOfPages = imageNameItem.count         //設定頁數數量
        pageControl.currentPage = 0                             //設定初始頁
        pageControl.contentHorizontalAlignment = .center        //設定水平位置
        pageControl.setStrokeColor(.red, for: .normal)          //設定邊匡顏色(正常顯示時)
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
