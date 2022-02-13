//
//  EmptyView.swift
//  rxSwiftApp
//
//  Created by Hwik on 2022/02/12.
//

import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa

protocol EmptyViewActionProtocol {
    
    func protocolAction()
    
}

class EmptyView: UIView  {

    lazy var topStackView = UIStackView().then{
       
        $0.axis = .vertical
        $0.distribution = .fill
        $0.spacing = 10
        $0.alignment = .center
       
      
        
        $0.addArrangedSubview(contentLabel)
        $0.addArrangedSubview(actionButton)
    }
    
    var contentLabel = UILabel().then{
        $0.font = .contentTitleBold
        $0.tintColor = .primaryColor
        $0.textAlignment = .right
        $0.contentMode = .scaleAspectFill
    }
    
    var actionButton = UIButton().then{
        $0.titleLabel?.font = .subContentsBold
        $0.setTitleColor(.primaryColor, for: .normal)
        $0.contentHorizontalAlignment = .left
        $0.layer.cornerRadius = 5
        $0.layer.borderColor = UIColor.lightGray.cgColor
        $0.layer.borderWidth = 1
        
        $0.contentEdgeInsets = UIEdgeInsets(top: Spacing.spacingS.rawValue, left: Spacing.spacingM.rawValue, bottom: Spacing.spacingS.rawValue, right:  Spacing.spacingM.rawValue)
    }
    
    private let disposeBag = DisposeBag()
    
    var delegate : EmptyViewActionProtocol?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        uiSetting()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        uiSetting()
    }
    
    


}

extension EmptyView {
    
    private func uiSetting(){
        backgroundColor = .primaryColorReverse
        addSubview(topStackView)
        
        actionButton.rx.tap
            .bind(onNext:  {
                [weak self] _ in  self?.delegate?.protocolAction()
            })
            .disposed(by: disposeBag)
        
        topStackView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        
        
    }
    
}
