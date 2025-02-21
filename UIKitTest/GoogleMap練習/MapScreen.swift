//
//  MapScreen.swift
//  UIKitTest
//
//  Created by 紹郁 on 2025/2/6.
//

import UIKit
import GoogleMaps
import CoreLocation

class MapScreen: MyViewController {
    
    private let titleBar = MyTitleBar()

    private var mapView: GMSMapView!
    private let myLocationMgr = CLLocationManager()
    
    private var latitude = String()
    private var longitude = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myLocationMgr.distanceFilter = kCLLocationAccuracyNearestTenMeters
        myLocationMgr.desiredAccuracy = kCLLocationAccuracyBest
        myLocationMgr.delegate = self
        
        DispatchQueue.main.async {
            self.checkLocationAuthorization() // 確保在主線程檢查授權
        }
    }
}

//MARK: - UI
extension MapScreen {
    
    private func setupUI() {
        
        titleBar.setTitle = "GoogleMap練習"
        titleBar.backButtonAction = { [weak self] in self?.popViewController()}

        mapView = GMSMapView() // 初始化 mapView

        let appScreen = MyStack(arrangedSubviews: [titleBar, mapView])
        appScreen.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(appScreen)
        NSLayoutConstraint.activate([
            appScreen.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            appScreen.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            appScreen.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            appScreen.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            
            titleBar.heightAnchor.constraint(equalTo: appScreen.heightAnchor, multiplier: 0.1),
            mapView.heightAnchor.constraint(equalTo: appScreen.heightAnchor, multiplier: 0.9)
        ])
        
        setupInitialMapView()
    }
    
    private func setupInitialMapView() {
        
        mapView.isMyLocationEnabled = true
        mapView.delegate = self
        
        if let location = myLocationMgr.location {
            latitude = String(describing: location.coordinate.latitude)
            longitude = String(describing: location.coordinate.longitude)
            
            updateMapToUserLocation(location)
        } else {
            print("zhan: location is nil")
        }
    }
    
    private func updateMapToUserLocation(_ location: CLLocation) {
        let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude, longitude: location.coordinate.longitude, zoom: 15)
        mapView.animate(to: camera)
    }
    
    private func setMarker(title: String, lat: String, lng: String) {
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2DMake(24.147934, 120.684509)
        marker.map = mapView
        marker.title = "一中街夜市"
        marker.snippet = "測試用"
    }
}
//MARK: - CLLocationManager
extension MapScreen: CLLocationManagerDelegate {
    
    func checkLocationAuthorization() {
        switch myLocationMgr.authorizationStatus {
        case .notDetermined:
            myLocationMgr.requestWhenInUseAuthorization() // 第一次啟動應用程式時，需向用戶請求授權
            
        case .restricted, .denied:
            let alertController = UIAlertController(title: "定位權限已關閉",
                                                    message:"如要變更權限，請至 設定 > 隱私權 > 定位服務 開啟",
                                                    preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "確認", style: .default, handler: nil)
            alertController.addAction(okAction)
            
            self.present(alertController, animated: true, completion: nil)
            
        case .authorizedWhenInUse, .authorizedAlways:
            myLocationMgr.startUpdatingLocation() // 開始更新位置
        @unknown default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            setupUI()

            updateMapToUserLocation(location)
            myLocationMgr.stopUpdatingLocation() // 停止更新，避免不必要的呼叫
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("定位失敗: \(error.localizedDescription)")
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
}
//MARK: - GoogleMap
extension MapScreen: GMSMapViewDelegate {
    
    // didTap：按下圖釘觸發
//    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
//
//        let url = URL(string: "https://maps.app.goo.gl/51fKdFH4Qdu8xp1f7")
//
//        let alert = UIAlertController(title: "美家人力", message: "您確定要前往此地點嗎？", preferredStyle: .alert)
//
//        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
//        alert.addAction(cancelAction)
//
//        let okAction = UIAlertAction(title: "前往", style: .default, handler: { _ in
//            if let url = url {
//                UIApplication.shared.open(url)
//            }
//        })
//        alert.addAction(okAction)
//
//        present(alert, animated: true, completion: nil)
//
//        return true
//    }
    
    // didTapInfoWindowOf：點擊資訊視窗時觸發
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        
        // 指定的URL
        if let url = URL(string: "https://maps.app.goo.gl/51fKdFH4Qdu8xp1f7") {
            UIApplication.shared.open(url)
        }
    }
}
