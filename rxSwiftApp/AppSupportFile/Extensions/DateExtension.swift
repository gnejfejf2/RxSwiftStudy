//
//  DateExtension.swift
//  pineapp
//
//  Created by Hwik on 2021/11/09.
//

import Foundation

extension Date {
    
    func getNowTime(dateFormatter : String) -> String{
        let df = DateFormatter()
        df.locale = Locale(identifier: "ko_KR")
        df.timeZone = TimeZone(abbreviation: "KST")
        df.dateFormat = dateFormatter
        
        return df.string(from: self)
    }
}
