//
//  MyImageUrl.swift
//  UIKitTest
//
//  Created by 紹郁 on 2024/9/3.
//

import UIKit

class MyImageUrl: UIImageView {

    private var imageURL: URL?
    private var hasDownloadedImage = false
    private var shouldCache: Bool

    // 初始化方法，接收 URL 和是否啟用緩存的選項
    init(imageURL: URL?, shouldCache: Bool = true) {
        self.imageURL = imageURL
        self.shouldCache = shouldCache
        super.init(frame: .zero)
        setupUI()
        if let url = imageURL {
            if shouldCache && hasDownloadedImage {
                // 如果已經下載過且緩存啟用，則不重新下載
                return
            }
            loadImage(from: url)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        self.contentMode = .scaleAspectFit
        self.translatesAutoresizingMaskIntoConstraints = false
    }

    private func loadImage(from url: URL) {
        // 創建一個 URLSession 來下載圖片
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return }
            
            // 檢查是否有錯誤
            if let error = error {
                print("下載圖片時發生錯誤: \(error)")
                return
            }
            
            // 檢查響應狀態
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print("響應錯誤")
                return
            }
            
            // 確保有數據
            guard let data = data, let image = UIImage(data: data) else {
                print("無法轉換數據為圖片")
                return
            }
            
            // 在主線程上設置圖片
            DispatchQueue.main.async {
                self.image = image
                // 設置緩存狀態
                if self.shouldCache {
                    self.hasDownloadedImage = true
                }
            }
        }
        
        // 開始下載
        task.resume()
    }
}
