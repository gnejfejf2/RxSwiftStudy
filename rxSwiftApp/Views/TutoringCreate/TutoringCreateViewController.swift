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
        $0.spacing = 15
        $0.alignment = .center
        
        $0.isLayoutMarginsRelativeArrangement = true
        
        $0.addArrangedSubview(tutoringTitleLabel)
        $0.addArrangedSubview(tutoringTextField)
        $0.addArrangedSubview(tuteeTitleLabel)
        $0.addArrangedSubview(tuteeTextField)
        $0.addArrangedSubview(paymentMethodTitleLabel)
        $0.addArrangedSubview(paymentMethodTextField)
        $0.addArrangedSubview(paymentMethodStackView)
        $0.addArrangedSubview(startDateTitleLabel)
        $0.addArrangedSubview(startDatePicker)
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
    
    var tuteeTitleLabel = TitleLabel().then{
        $0.text = "수강생"
        $0.textAlignment = .left
    }
    
    var tuteeTextField = DoneTextField().then{
        $0.placeholder = "수강생을 적어주세요"
        $0.textAlignment = .left
    }
    
    var paymentMethodTitleLabel = TitleLabel().then{
        $0.text = "비용관리"
        $0.textAlignment = .left
    }
    
    var paymentMethodTextField = DonePickerView().then{
        $0.textAlignment = .left
    }
    
    lazy var paymentMethodStackView = UIStackView().then {
    
        $0.axis = .horizontal
        $0.distribution = .fillProportionally
        $0.alignment = .leading
        $0.addArrangedSubview(paymentDateTitleLabel)
        $0.addArrangedSubview(paymentDateTextField)
        $0.addArrangedSubview(progressCountTitleLabel)
        $0.addArrangedSubview(progressCountTextField)
        $0.addArrangedSubview(totalCountTitleLabel)
        $0.addArrangedSubview(totalCountCountTextField)
    }
    
    var paymentDateTitleLabel = TitleLabel().then{
        $0.text = "결제일"
        $0.setContentHuggingPriority(UILayoutPriority(249), for: .horizontal)
        $0.textAlignment = .left
    }
    
    lazy var paymentDateTextField = DoneTextField().then{
        $0.placeholder = "ex 24"
        $0.textAlignment = .left
        $0.setContentHuggingPriority(UILayoutPriority(250), for: .horizontal)
        $0.keyboardType = .numberPad
        $0.delegate = self
    }
    
    var progressCountTitleLabel = TitleLabel().then{
        $0.text = "진행한 횟수"
        $0.setContentHuggingPriority(UILayoutPriority(249), for: .horizontal)
        $0.textAlignment = .left
    }
    
    lazy var progressCountTextField = DoneTextField().then{
        $0.placeholder = "ex 24"
        $0.textAlignment = .left
        $0.setContentHuggingPriority(UILayoutPriority(250), for: .horizontal)
        $0.keyboardType = .numberPad
        $0.delegate = self
    }
    
    var totalCountTitleLabel = TitleLabel().then{
        $0.text = "총 횟수"
        $0.textAlignment = .left
    }
    
    lazy var totalCountCountTextField = DoneTextField().then{
        $0.placeholder = "ex 24"
        $0.textAlignment = .left
        $0.keyboardType = .numberPad
        $0.delegate = self
    }
    
    var startDateTitleLabel = TitleLabel().then{
        $0.text = "시작일"
        $0.textAlignment = .left
       
    }
  
    lazy var startDatePicker = UIDatePicker().then{
        if #available(iOS 13.4, *) {
            $0.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
        $0.datePickerMode = .date
        $0.locale = Locale(identifier: "ko-KR")
        $0.timeZone = .autoupdatingCurrent
        $0.addTarget(self, action: #selector(handleDatePicker(_:)), for: .editingDidEnd)
        
    }
    
    
    
    var studentRemarksTitleLabel = TitleLabel().then{
        $0.text = "수강생 특징"
        $0.textAlignment = .left
    }
    
    var studentRemarksTextView = PlaceHolderTextView(placeHolder : "수강생을 적어주세요").then{
        $0.textAlignment = .left
    }
    
  
    
    
    let pickerData = [paymentTypeModel(name: "무료", typeValue: 0),paymentTypeModel(name: "월결제", typeValue: 1),paymentTypeModel(name: "횟수차감", typeValue: 2)]
    var pickerIndex : Int = 0
    
    
    lazy var titles : [UIView] = [tutoringTitleLabel,tuteeTitleLabel,paymentMethodTitleLabel,startDateTitleLabel,studentRemarksTitleLabel , paymentMethodStackView]
    lazy var contents : [UIView] = [tutoringTextField,tuteeTextField,paymentMethodTextField,studentRemarksTextView ]
    
    
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
     
        
        startDatePicker.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(50)
        }
        
        studentRemarksTextView.snp.makeConstraints { make in
            make.height.equalTo(300)
        }
        
        paymentMethodStackView.snp.makeConstraints { make in
            make.height.equalTo(paymentDateTitleLabel.snp.height)
        }
        
        
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
        
        
        tutoringTextField.doneAction = { [weak self] in
            self?.tuteeTextField.becomeFirstResponder()
        }
        
        tuteeTextField.doneAction = { [weak self] in
            self?.paymentMethodTextField.becomeFirstResponder()
        }
        
        paymentMethodTextField.pickerView.delegate = self
        
        paymentMethodTextField.doneAction = { [weak self] in
            guard let self = self else { return }
            self.viewModel?.output.selectedIndex.accept(self.pickerIndex)
        }
        
        
        
        
        
       
        
    }
    
    func uiBinding() {
       
        viewModel?.output.selectedIndex
            .map{ [weak self] in self?.pickerData[$0].name }
            .bind(to : paymentMethodTextField.rx.text)
            .disposed(by: disposeBag)

        viewModel?.output.selectedIndex
            .subscribe(onNext:  { [weak self] in self?.paymentTextFieldSetting($0) } )
            .disposed(by: disposeBag)
            
    }
    
    func eventBinding() {
        
    }
    
 
    func paymentTextFieldSetting(_ index : Int){
        
        if(index == 0){
            paymentMethodStackView.isHidden = true
        }else if(index == 1){
            paymentMethodStackView.isHidden = false
            
            paymentDateTitleLabel.isHidden = false
            paymentDateTextField.isHidden = false
            progressCountTitleLabel.isHidden = true
            progressCountTextField.isHidden = true
            totalCountTitleLabel.isHidden = true
            totalCountCountTextField.isHidden = true
        }else if(index == 2){
            paymentMethodStackView.isHidden = false
            paymentDateTitleLabel.isHidden = true
            paymentDateTextField.isHidden = true
            progressCountTitleLabel.isHidden = false
            progressCountTextField.isHidden = false
            totalCountTitleLabel.isHidden = false
            totalCountCountTextField.isHidden = false
        }
        
    }
    
    
    @objc private func handleDatePicker(_ sender: UIDatePicker) {
        print(sender.date.getYYYYMMDD())
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



extension TutoringCreateViewController : UIPickerViewDelegate , UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row].name
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerIndex = row
    }
}

extension TutoringCreateViewController : UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return textChecking(textField, string)
    }
    
    
    func textChecking(_ textField: UITextField , _ string : String) -> Bool{
        if(string == ""){
            return true
        }
        
        
        if(!textNumberChecking(string)){
            return false
        }
        
        if !textCountChecking(textField.text, maxCount: 2){
            return false
        }
        

        
        if(textField == paymentDateTextField){
            return textDateChecking(textField : textField , text: string)
        }else{
            return true
        }
    }
    
    
    func textNumberChecking(_ string : String) -> Bool {
        if string.rangeOfCharacter(from: NSCharacterSet.decimalDigits) != nil {
            return true
        }else {
            return false
        }
    }
//
    func textCountChecking(_ string : String? , maxCount : Int ) -> Bool{
        if((string?.count ?? 0) >= maxCount ){
            return false
        }else{
            return true
        }
    }
    
    func textDateChecking(textField: UITextField , text : String , _ startDate : Int = 1 , _ endDate : Int = 31) -> Bool{
        var totalText = ""
        
        if let previousText = textField.text {
            totalText = previousText + text
        }else{
            totalText = text
        }
        
        
        
        guard let date = Int(totalText) else { return false }
        
        if(date >= startDate && date <= endDate){
            return true
        }else{
            return false
        }
    }
   
    
}
