//
//  UIViewController_Extension.swift
//  rxSwiftApp
//
//  Created by Hwik on 2022/02/09.
//

import Foundation
import UIKit

extension UIViewController {
    
    func navigationBarTitleSetting(_ title : String){
        navigationController?.navigationBar.topItem?.title = title
    }
    
    func navigationBarSetting(hidden : Bool = false){
        if(hidden) {
            navigationController?.setNavigationBarHidden(true, animated: false)
        }else{
            navigationController?.setNavigationBarHidden(false, animated: false)
            navigationController?.navigationBar.backItem?.title = ""
            navigationController?.navigationBar.tintColor = .primaryColor
        }
    }
}
