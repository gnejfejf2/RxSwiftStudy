//
//  ScheduleComponent.swift
//  rxSwiftApp
//
//  Created by Hwik on 2022/02/13.
//

import Foundation
import UIKit
import Then
import SnapKit

class ScheduleComponent : UIStackView {
    
    //
    lazy var topStackView = UIStackView().then{
        $0.axis = .vertical
        $0.distribution = .fillEqually
        $0.spacing = 5
//        $0.alignment = .fill
        $0.backgroundColor = .primaryColorReverse
        $0.isLayoutMarginsRelativeArrangement = true
        $0.directionalLayoutMargins = NSDirectionalEdgeInsets(top: Spacing.spacingS.rawValue, leading: Spacing.spacingM.rawValue, bottom: Spacing.spacingS.rawValue, trailing:  Spacing.spacingM.rawValue)
        
        $0.addArrangedSubview(topInformationStackView)
        $0.addArrangedSubview(progressTitleLabel)
    }
    
    
    lazy var topInformationStackView = UIStackView().then{
        $0.axis = .horizontal
        $0.distribution = .fill
        $0.alignment = .center
        $0.backgroundColor = .primaryColorReverse
     
        $0.addArrangedSubview(tutoringTitleLabel)
        $0.addArrangedSubview(tuteeTitleLabel)
    }
    
    var tutoringTitleLabel = UILabel().then {
        $0.textColor = .primaryColor
        $0.font = .contentTitleBold
        $0.text = "수학 과외수업"
    }
   
    var tuteeTitleLabel = UILabel().then {
        $0.textColor = .primaryColor
        $0.font = .contentTitle
        $0.text = "수강생 : 강지윤"
    }
    
    var progressTitleLabel = UILabel().then {
        $0.textColor = .primaryColor
        $0.font = .subContents
        $0.text = "11 / 20 회"
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        uiSetting()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        uiSetting()
    }

    func uiSetting(){
        self.addSubview(topStackView)
        self.backgroundColor = .primaryColorReverse

        topStackView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }

}

