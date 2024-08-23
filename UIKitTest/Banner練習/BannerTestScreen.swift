//
//  BannerTestScreen.swift
//  UIKitTest
//
//  Created by 紹郁 on 2024/8/16.
//

import UIKit

class BannerTestScreen: UIViewController {
    
    let bannerScrollView = UIScrollView()
    let pageControl = UIPageControl()
    var imageNameItem = ImageNameItem().imageData
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bannerScrollView.showsHorizontalScrollIndicator = false
        bannerScrollView.showsVerticalScrollIndicator = false
        bannerScrollView.delegate = self
        
        let titleBar = titleBar
        let subView = subView
        
        let appView = UIStackView(arrangedSubviews: [titleBar, subView, pageControl])
        appView.axis = .vertical
        appView.distribution = .fill
        
        self.view.addSubview(appView)
        
        appView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            appView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            appView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            appView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            appView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
        ])
        
        titleBar.heightAnchor.constraint(equalTo: appView.heightAnchor, multiplier: 0.1).isActive = true
        subView.heightAnchor.constraint(equalTo: appView.heightAnchor, multiplier: 0.8).isActive = true
        pageControl.heightAnchor.constraint(equalTo: appView.heightAnchor, multiplier: 0.1).isActive = true
        
        // 設定 pageControl
        pageControl.numberOfPages = imageNameItem.count
        pageControl.currentPage = 0   // 預設為第一頁
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        
        showFirstBannerView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        startTimer() // 开始计时器
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stopTimer() // 停止计时器
    }
}

//MARK: - SubView
extension BannerTestScreen {
    
    var titleBar: UIView {
        
        let titleLabel = mainLabelView(labelText: "Banner練習", font: .title1, isBold: true, _textColor: .black, aligment: .center, background: .clear)
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
    
    var subView: UIView {
        
        let bannerWidth = UIScreen.main.bounds.width
        let bannerHeight: CGFloat = 200
        
        bannerScrollView.translatesAutoresizingMaskIntoConstraints = false
        
        // 計算 bannerScrollView 的 contentSize
        let numberOfBanners = imageNameItem.count
        bannerScrollView.contentSize = CGSize(width: CGFloat(numberOfBanners + 2) * bannerWidth, height: bannerHeight)
        bannerScrollView.isPagingEnabled = true
        
        // 建立多個子視圖來展示在 scroll view 中
        for index in 0..<numberOfBanners + 2 {
            let bannerView = UIImageView()
            if index == 0 {
                bannerView.image = UIImage(named: imageNameItem[numberOfBanners - 1].name) // 显示最后一张图片
            } else if index == numberOfBanners + 1 {
                bannerView.image = UIImage(named: imageNameItem[0].name) // 显示第一张图片
            } else {
                bannerView.image = UIImage(named: imageNameItem[index - 1].name)
            }
            
            bannerView.isUserInteractionEnabled = true
            bannerView.contentMode = .scaleAspectFit
            bannerView.frame = CGRect(x: CGFloat(index) * bannerWidth, y: 0, width: bannerWidth, height: bannerHeight)
            
            // 添加點擊手勢
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(bannerTapped(_:)))
            bannerView.addGestureRecognizer(tapGesture)
            bannerScrollView.addSubview(bannerView)
        }
        return bannerScrollView
    }
}

//MARK: - Function
extension BannerTestScreen {
    
    @objc func back() {
        popView()
    }
    
    func showFirstBannerView() {
        let width = bannerScrollView.bounds.width
        bannerScrollView.contentOffset = CGPoint(x: width, y: 0) // 显示第一张图片
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            
            let width = self.bannerScrollView.frame.width
            let currentOffset = self.bannerScrollView.contentOffset.x
            let nextOffset = currentOffset + width
            let totalPages = self.imageNameItem.count
            
            if nextOffset >= width * CGFloat(totalPages + 1) {
                let newOffset = CGPoint(x: width, y: 0)
                self.bannerScrollView.setContentOffset(newOffset, animated: true)
                self.pageControl.currentPage = 0
            } else {
                let newOffset = CGPoint(x: nextOffset, y: 0)
                self.bannerScrollView.setContentOffset(newOffset, animated: true)
                let newPage = Int(nextOffset / width) - 1
                if newPage < totalPages {
                    self.pageControl.currentPage = newPage
                }
            }
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    @objc func bannerTapped(_ sender: UITapGestureRecognizer) {
        guard let tappedImageView = sender.view as? UIImageView,
              let index = bannerScrollView.subviews.firstIndex(of: tappedImageView) else {
            return
        }
        
        let numberOfBanners = imageNameItem.count
        
        // 計算實際的圖片索引
        let imageIndex: Int
        if index == 0 {
            imageIndex = numberOfBanners - 1
        } else if index == numberOfBanners + 1 {
            imageIndex = 0
        } else {
            imageIndex = index - 1
        }
        
        let url = imageNameItem[imageIndex].url
        UIApplication.shared.open(url)
    }
}

extension BannerTestScreen: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = bannerScrollView.bounds.width
        let totalPages = imageNameItem.count
        let currentPage = Int(bannerScrollView.contentOffset.x / width)
        
        if currentPage == 0 {
            bannerScrollView.contentOffset = CGPoint(x: width * CGFloat(totalPages), y: 0)
            pageControl.currentPage = totalPages - 1
        } else if currentPage == totalPages + 1 {
            bannerScrollView.contentOffset = CGPoint(x: width, y: 0)
            pageControl.currentPage = 0
        } else {
            pageControl.currentPage = currentPage - 1
        }
    }
}
