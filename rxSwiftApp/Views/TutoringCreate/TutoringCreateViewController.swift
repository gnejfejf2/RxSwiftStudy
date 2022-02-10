//
//  SimpleViewController.swift
//  rxSwiftApp
//
//  Created by Hwik on 2022/01/02.
//

import UIKit
import Then
import SnapKit
import RxSwift
import RxCocoa
import RxDataSources
import RxRelay
import RxGesture


class TutoringCreateViewController: UIViewController , ViewSettingProtocol {
    
    lazy var mainScrollView = UIScrollView().then{
        
        $0.contentSize = CGSize(width: UIScreen.main.bounds.width, height: 0)
        
        $0.addSubview(mainStackView)
        
    }
    
    
    lazy var mainStackView = UIStackView().then{
        $0.axis = .vertical
        $0.distribution = .fill
        $0.spacing = 10
        $0.alignment = .center
        $0.backgroundColor = .brown
        $0.isLayoutMarginsRelativeArrangement = true
        
        $0.addArrangedSubview(tutoringTitleLabel)
        $0.addArrangedSubview(tutoringTextField)
        $0.addArrangedSubview(studentTitleLabel)
        $0.addArrangedSubview(studentTextField)
        $0.addArrangedSubview(paymentMethodTitleLabel)
        $0.addArrangedSubview(startDateTitleLabel)
        $0.addArrangedSubview(studentRemarksTitleLabel)
        $0.addArrangedSubview(studentRemarksTextView)
    }
    
    var tutoringTitleLabel = TitleLabel().then{
        $0.text = "수업 이름"
        $0.textAlignment = .left
    }
    var tutoringTextField = DoneTextField().then{
        $0.placeholder = "수업 이름을 적어주세요"
        $0.textAlignment = .left
    }
    
    var studentTitleLabel = TitleLabel().then{
        $0.text = "수강생"
        $0.textAlignment = .left
    }
    
    var studentTextField = DoneTextField().then{
        $0.placeholder = "수강생을 적어주세요"
        $0.textAlignment = .left
    }
    
    var paymentMethodTitleLabel = TitleLabel().then{
        $0.text = "비용관리"
        $0.textAlignment = .left
    }
    
    var startDateTitleLabel = TitleLabel().then{
        $0.text = "시작일"
        $0.textAlignment = .left
    }
    var studentRemarksTitleLabel = TitleLabel().then{
        $0.text = "수강생 특징"
        $0.textAlignment = .left
    }
    var studentRemarksTextView = UITextView().then{
        $0.text = "수강생을 적어주세요"
        $0.textColor = .primaryColor
        $0.textAlignment = .left
    }
    
    lazy var titles : [UIView] = [tutoringTitleLabel,studentTitleLabel,paymentMethodTitleLabel,startDateTitleLabel,studentRemarksTitleLabel]
    lazy var contents : [UIView] = [tutoringTextField,studentTextField,studentRemarksTextView]
    
    lazy var bottomConstraint = mainStackView.bottomAnchor.constraint(equalTo: self.mainScrollView.bottomAnchor)
    
    private let disposeBag = DisposeBag()
    
    var viewModel : TutoringCreateViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        uiDrawing()
        uiSetting()
        uiBinding()
        eventBinding()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationBarSetting()
        notificationCenterRegister()
        
    }
    override func viewDidDisappear(_ animated: Bool) {
        notificationCenterDelete()
    }
    
    func uiDrawing() {
        view.backgroundColor = .primaryColorReverse
        
        view.addSubview(mainScrollView)
        
        
        mainScrollView.snp.makeConstraints { make in
            make.bottom.equalTo(view)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(.pageTopSpacing)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        
        mainStackView.snp.makeConstraints { make in
            make.top.trailing.leading.equalTo(mainScrollView)
            make.width.equalTo(mainScrollView).priority(1000)
            make.height.equalTo(mainScrollView).priority(250)
        }
        bottomConstraint.isActive = true
        
      
        titles.forEach{
            $0.snp.makeConstraints { make in
                make.trailing.equalToSuperview().offset(.titleTrailingSpacing)
                make.leading.equalToSuperview().offset(.titleLeadingSpacing)
            }
        }
        
        contents.forEach{
            $0.snp.makeConstraints { make in
                make.trailing.equalToSuperview().offset(.contentTrailingSpacing)
                make.leading.equalToSuperview().offset(.contentLeadingSpacing)
            }
        }
        
    }
    
    func uiSetting() {
        
        navigationBarSetting()
        navigationBarTitleSetting("신규 튜터링")
        
    }
    
    func uiBinding() {
        
    }
    
    func eventBinding() {
        
    }
    
    
    
    func notificationCenterRegister(){
        NotificationCenter.default.addObserver(self,selector: #selector(keyboardWillShow),name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self,selector: #selector(keyboardWillHide),name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    func notificationCenterDelete(){
        NotificationCenter.default.removeObserver(UIResponder.keyboardWillShowNotification)
        NotificationCenter.default.removeObserver(UIResponder.keyboardWillHideNotification)
    }
    
    @objc func keyboardWillShow(_ notification : NSNotification){
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            UIView.animate(withDuration: 0.3, animations: { [weak self] in
                self?.bottomConstraint.constant = -(keyboardSize.height + Spacing.spacingL.rawValue)
            })
        }
    }
    @objc func keyboardWillHide(_ notification: NSNotification){
        bottomConstraint.constant = 0
    }
}

