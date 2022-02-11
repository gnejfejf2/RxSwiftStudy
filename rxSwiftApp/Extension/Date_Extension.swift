//
//  Date_Extension.swift
//  rxSwiftApp
//
//  Created by Hwik on 2022/02/10.
//

import Foundation

extension Date {
    
    func getYYYYMMDD() -> String{
        let myDateFormatter = DateFormatter()
        myDateFormatter.dateFormat = "yyyy년 MM월 dd일" // 2020년 08월 13일 오후 04시 30분
        myDateFormatter.locale = Locale(identifier:"ko_KR") // PM, AM을 언어에 맞게 setting (ex: PM -> 오후)
        let convertStr = myDateFormatter.string(from: self)
        
        return convertStr
    }
}
