//
//  dayScheduleCollectionViewCell.swift
//  rxSwiftApp
//
//  Created by Hwik on 2022/02/09.
//

import UIKit

class DayScheduleCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "DayScheduleCollectionViewCell"
    
    lazy var titleLabel = UILabel().then {
        $0.textColor = .primaryColor
    }
    
    
    //부모 메서드 초기화 시켜줘야 한다.
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        uiDrawing()
        
        
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
        
    }

 
    
    

    func uiSetting(_ content : String ) {
      
        self.titleLabel.text = content
      
      
    }
    
}
// MARK: - UI Setup
extension DayScheduleCollectionViewCell {
    private func uiDrawing() {
        self.contentView.addSubview(titleLabel)
        self.backgroundColor = .primaryColorReverse
        titleLabel.snp.makeConstraints { make in
            make.centerXWithinMargins.centerYWithinMargins.equalTo(contentView)
        }
    }
}
