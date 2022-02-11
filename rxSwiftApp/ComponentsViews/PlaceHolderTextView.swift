//
//  placeHolderTextView.swift
//  rxSwiftApp
//
//  Created by Hwik on 2022/02/11.
//

import UIKit


protocol PlaceHolderTextViewDelegate : ComponentSettingProtocol{
  
    func doneButtonTextChange(text : String)
    func placeHolderSetting(_ placeHolder : String?)
}

class PlaceHolderTextView: UITextView  , PlaceHolderTextViewDelegate{
    
    var placeHolder : String?
    var doneAction : FunctionCloure? = nil
    
    private let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    private let doneButton = UIBarButtonItem(title: "확인", style: .done, target: self, action: #selector(doneButtonAction))
    
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        uiSetting()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        uiSetting()
    }
    
    init(placeHolder : String){
        super.init(frame: .zero , textContainer: nil)
        self.placeHolder = placeHolder
        uiSetting()
        
    }
    
    func uiSetting(){
        self.delegate = self
        let toolBarKeyboard = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        toolBarKeyboard.sizeToFit()
        toolBarKeyboard.items = [ flexSpace , doneButton]
        self.inputAccessoryView = toolBarKeyboard
        
        placeHolderSetting(placeHolder)
    }
    
    
    func doneButtonTextChange(text : String){
        doneButton.title = text
    }
    
    @objc func doneButtonAction(){
        doneAction?()
        resignFirstResponder()
    }
    
    
    
}

extension PlaceHolderTextView : UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if self.text == placeHolder {
            textView.text = nil
            textView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            placeHolderSetting(placeHolder)
        }
    }
    
}
