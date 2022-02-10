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
        self.presentationStyle.backgroundColor = .black
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
   
    lazy var topStackView = UIStackView().then{
        $0.axis = .vertical
        $0.distribution = .fill
        $0.spacing = 10
        $0.alignment = .leading
        $0.backgroundColor = .primaryColorReverse
        $0.addArrangedSubview(informationButton)
    }

    var informationButton = ImageTitleButton().then{
        $0.titleLabel.text = "정보"
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
        view.addSubview(topStackView)
        
        topStackView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
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
