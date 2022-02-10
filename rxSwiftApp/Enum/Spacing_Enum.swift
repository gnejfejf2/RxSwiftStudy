//
//  Spacing_Enum.swift
//  rxSwiftApp
//
//  Created by Hwik on 2022/02/09.
//


import Foundation
import UIKit
import SnapKit

enum Spacing : CGFloat {
    ///2
    case spacingXxs = 2.0
    ///4
    case spacingXs  = 4.0
    ///8
    case spacingS  = 8.0
    ///12
    case spacingM = 12.0
    ///16
    case spacingL  = 16.0
    ///24
    case spacingXl  = 24.0
    ///40
    case spacingXxl = 40.0
    ///52
    case spacingXxxl  = 52.0
    
    case titleSpacing = 20
    
    case contentSpacing = 10
    
    func spacingArray() -> [Spacing]{
        
        var spacingArray : [Spacing] = []
        spacingArray.append(.spacingXxs)
        spacingArray.append(.spacingXs)
        spacingArray.append(.spacingS)
        spacingArray.append(.spacingM)
        spacingArray.append(.spacingL)
        spacingArray.append(.spacingXl)
        spacingArray.append(.spacingXxl)
        spacingArray.append(.spacingXxxl)
    
        return spacingArray
    }
    
}

extension ConstraintConstantTarget where Self == CGFloat  {
  
    static var pageTopSpacing: CGFloat {
        return 10
    }
    
    static var titleLeadingSpacing : CGFloat {
        return 10
    }
    static var titleTrailingSpacing : CGFloat {
        return -10
    }
    static var contentLeadingSpacing: CGFloat {
        return 20
    }
    static var contentTrailingSpacing: CGFloat {
        return -20
    }
}
