//
//  UIView_Extension.swift
//  rxSwiftApp
//
//  Created by Hwik on 2022/02/09.
//

import Foundation
import UIKit

extension UIImageView {
    func iconResize(type : IconSize , padding : CGFloat = 0){
//        self.clipsToBounds =
        self.image?.resizableImage(withCapInsets: UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding) , resizingMode: .stretch)
        self.frame = CGRect(x: 0, y: 0, width: type.rawValue + padding + padding, height: type.rawValue + padding + padding)
        self.contentMode = .scaleAspectFill
        self.snp.remakeConstraints { make in
            make.width.equalTo(type.rawValue + padding + padding)
            make.height.equalTo(type.rawValue + padding + padding)
        }
        self.sizeToFit()
    }
    
}
