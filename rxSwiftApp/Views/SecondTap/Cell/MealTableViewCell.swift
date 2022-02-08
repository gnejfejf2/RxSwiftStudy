//
//  MealTableViewCell.swift
//  rxSwiftApp
//
//  Created by Hwik on 2022/01/19.
//

import UIKit
import Then

class MealTableViewCell: UITableViewCell {

    static let identifier = "MealTableViewCell"
    
    lazy var titleLabel = UILabel().then {
        $0.textColor = .black
    }
    
    
    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

 
    
    

    func bind(mySectionItem : Meal){
        contentView.backgroundColor = .white
        titleLabel.text = mySectionItem.name
        
        
    }
    
}
// MARK: - UI Setup
extension MealTableViewCell {
    private func setupUI() {
        self.contentView.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.centerXWithinMargins.centerYWithinMargins.equalTo(contentView)
        }
    }
}
