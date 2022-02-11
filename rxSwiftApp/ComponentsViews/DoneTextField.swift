//
//  DoneTextField.swift
//  rxSwiftApp
//
//  Created by Hwik on 2022/02/10.
//

import Foundation
import UIKit


protocol DoneTextFieldDelegate : ComponentSettingProtocol{
    var doneAction : FunctionCloure? { get }
    func cancelButtonTextChange(text : String)
    func doneButtonTextChange(text : String)
}

class DoneTextField: UITextField , DoneTextFieldDelegate {
    
    
    
    var doneAction : FunctionCloure? = nil
    private let cancelButton = UIBarButtonItem(title: "취소", style: .plain , target: self, action: #selector(cancelButtonAction))
    private let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    private let doneButton = UIBarButtonItem(title: "확인", style: .done, target: self, action: #selector(doneButtonAction))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        uiSetting()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        uiSetting()
    }
    
    func uiSetting(){
        self.delegate = self
    
        
        let toolBarKeyboard = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        toolBarKeyboard.sizeToFit()
        toolBarKeyboard.items = [cancelButton , flexSpace , doneButton]
        self.inputAccessoryView = toolBarKeyboard
    }
  
    
    @objc func cancelButtonAction(){
      resignFirstResponder()
    }
    
    @objc func doneButtonAction(){
        doneAction?()
        resignFirstResponder()
    }
    
    
    func cancelButtonTextChange(text : String){
        cancelButton.title = text
    }
   
    func doneButtonTextChange(text : String){
        doneButton.title = text
    }
    
}

extension DoneTextField : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        doneAction?()
        resignFirstResponder()
        return true
    }
}
