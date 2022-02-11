//
//  DonePickerView.swift
//  rxSwiftApp
//
//  Created by Hwik on 2022/02/10.
//

import UIKit


protocol DonePickerDelegate : ComponentSettingProtocol{
    
    var doneAction : FunctionCloure? { get }
   
}

class DonePickerView : UITextField , DonePickerDelegate{

    let pickerView = UIPickerView()
    
    var doneAction : FunctionCloure? = nil
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        uiSetting()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        uiSetting()
   }

    
    func uiSetting(){
        let toolBarKeyboard = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        toolBarKeyboard.sizeToFit()
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        let buttonDoneBar = UIBarButtonItem(title: "확인", style: .done, target: self, action: #selector(doneButtonAction))
        toolBarKeyboard.items = [flexSpace , buttonDoneBar]
        
        self.tintColor = UIColor.clear
        
        self.inputAccessoryView = toolBarKeyboard
        self.inputView = pickerView
    }
    
    
    
    @objc func doneButtonAction(){
        doneAction?()
        resignFirstResponder()
    }
    
}
