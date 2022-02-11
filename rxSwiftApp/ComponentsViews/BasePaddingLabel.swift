//
//  BasePaddingLabel.swift
//  rxSwiftApp
//
//  Created by Hwik on 2022/02/11.
//

import Foundation
import UIKit

class BasePaddingLabel: UILabel {
    private var padding = UIEdgeInsets(top: Spacing.spacingM.rawValue, left: Spacing.spacingXl.rawValue, bottom: Spacing.spacingM.rawValue, right: Spacing.spacingXl.rawValue)

    convenience init(padding: UIEdgeInsets) {
        self.init()
        self.padding = padding
    }

    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: padding))
    }

    override var intrinsicContentSize: CGSize {
        var contentSize = super.intrinsicContentSize
        contentSize.height += padding.top + padding.bottom
        contentSize.width += padding.left + padding.right

        return contentSize
    }
}
