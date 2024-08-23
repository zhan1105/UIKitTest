//
//  UINavigation+.swift
//  UIKitTest
//
//  Created by 紹郁 on 2024/8/14.
//

import UIKit

var _NVC : UINavigationController?

extension UIViewController {
    
    //MARK: - 切換畫面(有動畫)
    func pushView(_ storyboardId : String){
        if let vc = storyboard?.instantiateViewController(withIdentifier: storyboardId){
            if navigationController == nil{
                _NVC?.pushViewController(vc, animated: true)
            }else{
                navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    //MARK: - 切換畫面(無動畫)
    func overPushView(_ storyboardId : String){
        if let vc = storyboard?.instantiateViewController(withIdentifier: storyboardId){
            if navigationController == nil{
                _NVC?.pushViewController(vc, animated: false)
            }else{
                navigationController?.pushViewController(vc, animated: false)
            }
        }
    }
    
    //MARK: - 返回前一頁
    func popView() {
        navigationController?.popViewController(animated: true)
    }
}
