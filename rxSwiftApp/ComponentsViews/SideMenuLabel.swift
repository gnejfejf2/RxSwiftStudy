//
//  SideMenuTextView.swift
//  rxSwiftApp
//
//  Created by Hwik on 2022/02/11.
//

import UIKit

class SideMenuTextView : BasePaddingLabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        uiSetting()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        uiSetting()
    }

    
    func uiSetting(){
        self.font = .contentTitle
        self.textColor = .primaryColor
        
        
    }

}
