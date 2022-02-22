//
//  CalenderViewCell.swift
//  rxSwiftApp
//
//  Created by Hwik on 2022/02/03.
//

import UIKit
import Then

class CalendarViewDayCell: UICollectionViewCell {
    
    static let identifier = "CalendarViewDayCell"
    
    private var contentLabel = UILabel().then{
        
        $0.font = .contentsBold
        $0.textColor = .primaryColor
        $0.textAlignment = .center
    }
    
    

    //부모 메서드 초기화 시켜줘야 한다.
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        
        
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
        
    }

    func uiSetting(_ day : String , _ row : Int) {
        self.contentView.addSubview(contentLabel)
        self.contentLabel.text = day
      
        contentLabel.textColor = .primaryColor
        
        contentLabel.snp.makeConstraints { make in
  
//            make.width.equalTo(UIScreen.main.bounds.width / 7)
            make.edges.equalToSuperview()
            
           
        }
    }

    
}
