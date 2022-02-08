//
//  CategoryCollectionViewCell.swift
//  rxSwiftApp
//
//  Created by Hwik on 2022/01/19.
//

import UIKit

class BannerCollectionViewCell: UICollectionViewCell {
   
    static let identifier = "BannerCollectionViewCell"
    
    let bannerImage = UIButton().then{
        $0.contentMode = .scaleToFill
    }

    //부모 메서드 초기화 시켜줘야 한다.
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        uiSettting()
        
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
        
    }



    func uiSettting() {
        self.contentView.addSubview(bannerImage)
  
      
        
        bannerImage.snp.makeConstraints { make in
            
            make.width.height.equalTo((UIScreen.main.bounds.width - 20) / 7)
            
            make.edges.equalToSuperview()
        }
    }

    
    
    
    
    
}
