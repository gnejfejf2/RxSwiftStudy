//
//  ImageTitleButton.swift
//  rxSwiftApp
//
//  Created by Hwik on 2022/02/09.
//

import UIKit
import Then
import SnapKit

class ImageTitleButton: UIStackView {
    
    
    
    
    var iconImageView = UIImageView().then{
        $0.image = UIImage(named: "menuIcon")?.withRenderingMode(.alwaysTemplate)
        $0.tintColor = .primaryColor
        $0.iconResize(type: .Middle)
    }
    
    var titleLabel = UILabel().then{
        $0.font = .contents
        $0.textAlignment = .right
        $0.textColor = .primaryColor
        $0.text = "123123123"
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        uiSetting()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        uiSetting()
    }
    
    
    
    func uiSetting() {
        self.axis = .horizontal
        self.spacing = Spacing.spacingXs.rawValue
        self.distribution = .fill
        self.alignment = .center
        self.isLayoutMarginsRelativeArrangement = true
        self.directionalLayoutMargins = NSDirectionalEdgeInsets(top: Spacing.spacingS.rawValue, leading: Spacing.spacingM.rawValue, bottom: Spacing.spacingS.rawValue, trailing:  Spacing.spacingM.rawValue)
        self.backgroundColor = .primaryColorReverse
        self.addArrangedSubview(iconImageView)
        self.addArrangedSubview(titleLabel)
       
        
 
        
        
        
    }
    
    func colorSetting(color : UIColor){
        iconImageView.tintColor = color
        titleLabel.textColor = color
    }
    
}
