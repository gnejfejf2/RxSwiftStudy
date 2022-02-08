//
//  CategoryCollectionViewCell.swift
//  rxSwiftApp
//
//  Created by Hwik on 2022/01/19.
//

import UIKit

class DayCollectionViewCell: UICollectionViewCell {
   
    static let identifier = "DayCollectionViewCell"
    
    let titleLabel:UILabel = {
        let label = UILabel()
   
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .primaryColor
        return label
    }()

    //부모 메서드 초기화 시켜줘야 한다.
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        setupUI()
        
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
        
    }





    
    
    
    func bind(mySectionItem : String){
  
        titleLabel.text = mySectionItem
        
        
    }
    
}
// MARK: - UI Setup
extension DayCollectionViewCell {
    private func setupUI() {
        self.contentView.addSubview(titleLabel)
  
      
        
        titleLabel.snp.makeConstraints { make in
  
            make.centerXWithinMargins.centerYWithinMargins.equalTo(contentView)
        }
    }
}
