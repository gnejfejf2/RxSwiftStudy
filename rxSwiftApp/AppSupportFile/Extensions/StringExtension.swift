//
//  StringExtension.swift
//  pineapp
//
//  Created by Hwik on 2021/12/22.
//
import UIKit

extension String {
    
    func localized(comment: String = "") -> String {
        return NSLocalizedString(self, comment: comment)
    }
    
}
