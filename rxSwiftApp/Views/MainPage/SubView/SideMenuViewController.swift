//
//  SideMenuController.swift
//  rxSwiftApp
//
//  Created by Hwik on 2022/02/09.
//

import Foundation
import UIKit
import Then
import SnapKit
import RxSwift
import RxCocoa
import RxDataSources
import RxRelay
import RxGesture
import SideMenu

class CustomSideMenuNavigation : SideMenuNavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presentationStyle = .menuSlideIn
        self.presentationStyle.presentingEndAlpha = 0.4
        self.leftSide = true
        //menu.statusBarEndAlpha = 0.4
        self.menuWidth = self.view.frame.width * 0.7
        //menu.menuWidth = 288
        self.isNavigationBarHidden = true
    }
}



class SideMenuViewController: UIViewController , ViewSettingProtocol {
    
    private let disposeBag = DisposeBag()
    
    var viewModel : SideMenuViewModel?
   
    
    
    
    


    lazy var userMainStackView = UIStackView().then{
        $0.axis = .horizontal
        $0.distribution = .fill
       
        $0.alignment = .center
        $0.addArrangedSubview(userNameLabel)
        $0.addArrangedSubview(arrowImageView)
        
    }
    
     var userNameLabel = UILabel().then{
        $0.text = "강지윤님\n안녕하세요"
        $0.numberOfLines = 0
        $0.font = .contentTitleBold
       
    }
    
    var arrowImageView = UIImageView().then{
        $0.image = UIImage(named: "icSRightarrow")?.withRenderingMode(.alwaysTemplate)
        $0.tintColor = .primaryColor
        $0.iconResize(type: .Middle)
        
    }
    
    lazy var buttonScrollView = UIScrollView().then{
        $0.setContentHuggingPriority(UILayoutPriority(249), for: .vertical)
        $0.contentSize = CGSize(width: UIScreen.main.bounds.width, height: 0)
        $0.addSubview(buttonStackView)
        
    }
    
    lazy var buttonStackView = UIStackView().then{
        $0.axis = .vertical
        $0.distribution = .fill
        $0.spacing = 10
        $0.alignment = .leading
        $0.backgroundColor = .clear
        $0.addArrangedSubview(testButton)
        $0.addArrangedSubview(informationButton)
//        $0.addArrangedSubview(buttonScrollView)
    }
    
    var testButton = SideMenuTextView().then{
        $0.text = "신규 튜터링"
        $0.backgroundColor = .clear
    }
    
    var informationButton = SideMenuTextView().then{
        $0.text = "신규 튜터링"
        $0.snp.makeConstraints { make in
            make.height.equalTo(2000)
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        uiDrawing()
        uiSetting()
        uiBinding()
        eventBinding()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationBarSetting(hidden: true)
    }
    
    
    func uiDrawing() {
        view.addSubview(userMainStackView)
        view.addSubview(buttonScrollView)
        
        userMainStackView.snp.makeConstraints { make in
            make.trailing.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(.contentLeadingSpacing)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(Spacing.spacingXxxl.rawValue)
        }
        
        userNameLabel.snp.makeConstraints { make in
            make.height.equalTo(userMainStackView)
        }
        
        buttonScrollView.snp.makeConstraints { make in
            make.top.equalTo(userMainStackView.snp.bottom).offset(.pageTopSpacing)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        buttonStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(buttonScrollView).priority(1000)
            make.height.equalTo(buttonScrollView).priority(250)

        }
        
        informationButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
        }
        
    }
    
    func uiSetting() {
        view.backgroundColor = .primaryColorReverse
        
    }
    
    func uiBinding() {
        
    }
    
    func eventBinding() {
        informationButton.rx.tapGesture()
            .when(.recognized)
            .subscribe(onNext: { [weak self] event in
                
                self?.viewModel?.input.tutoringCreateOpen.accept(event)
            })
            .disposed(by: disposeBag)
    }

}
