//
//  Drawable.swift
//  rxSwiftApp
//
//  Created by Hwik on 2022/01/02.
//

import UIKit

protocol Drawable {
    var viewController : UIViewController? { get }
}

extension UIViewController : Drawable {
   
    
    var viewController: UIViewController? { return self }
}
