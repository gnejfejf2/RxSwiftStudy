//
//  TitleLabel.swift
//  rxSwiftApp
//
//  Created by Hwik on 2022/02/09.
//

import UIKit

class TitleLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        uiSetting()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        uiSetting()
    }

    
    func uiSetting(){
        self.font = .contentTitleBold
        self.textColor = .primaryColor
    }
}

