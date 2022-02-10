//
//  BottomTableViewCell.swift
//  rxSwiftApp
//
//  Created by Hwik on 2022/02/08.
//

import UIKit
import Then

class DayScheduleViewCell: UITableViewCell {

    static let identifier = "DayScheduleViewCell"
    
    lazy var titleLabel = UILabel().then {
        $0.textColor = .primaryColor
    }
    
    
    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

 
    
    

    func uiSetting(_ content : String ) {
      
        self.titleLabel.text = content
      
      
    }
    
}
// MARK: - UI Setup
extension DayScheduleViewCell {
    private func setupUI() {
        self.contentView.addSubview(titleLabel)
        self.backgroundColor = .primaryColorReverse
        titleLabel.snp.makeConstraints { make in
            make.centerXWithinMargins.centerYWithinMargins.equalTo(contentView)
        }
    }
}
