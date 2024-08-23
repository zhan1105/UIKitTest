//
//  MapScreen.swift
//  UIKitTest
//
//  Created by 紹郁 on 2024/8/20.
//

import UIKit
import GoogleMaps
import CoreLocation

class MapScreen: UIViewController {
    
    var mapView: GMSMapView!
    let myLocationMgr = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        myLocationMgr.distanceFilter = kCLLocationAccuracyNearestTenMeters
        myLocationMgr.desiredAccuracy = kCLLocationAccuracyBest
        myLocationMgr.delegate = self
        checkLocationAuthorization()
    }
}
//MARK: - SubView
extension MapScreen {
    
    private func setupUI() {
        
        let titleBar = mainTitleBar(title: "GoogleMap練習")

        mapView = GMSMapView() // 初始化 mapView

        let appScreen = UIStackView(arrangedSubviews: [titleBar, mapView])
        appScreen.axis = .vertical
        appScreen.distribution = .fill
        
        self.view.addSubview(appScreen)
        
        appScreen.translatesAutoresizingMaskIntoConstraints = false
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
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2DMake(24.1430501, 120.7073933)
        marker.map = mapView
        marker.title = "美家人力"
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
            let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude, longitude: location.coordinate.longitude, zoom: 15)
            mapView.animate(to: camera)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("定位失敗: \(error.localizedDescription)")
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

