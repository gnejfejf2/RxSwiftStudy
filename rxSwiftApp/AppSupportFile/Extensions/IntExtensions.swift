//
//  IntExtension.swift
//  hwikgo
//
//  Created by kang jiyoun on 2021/08/27.
//

import Foundation

extension Int {
    var withCommas: String {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        return nf.string(from: NSNumber(value: self))!
    }
    
    func getKmMToString() -> String{
        
        if self >= 1000 {
            return "\(ceil(Double(self) / 1000.0 * 10.0) / 10)km"
        } else {
            return "\(self)m"
        }
    }
    
    func getAvailableMinute() -> String {
        let availableMM = self % 60
        let avaliableHH = Int(floor(Double(self) / 60.0))
        var availableString : String = "약 "
        if avaliableHH > 0 {
            availableString += "\(avaliableHH)시간 "
        }
        if avaliableHH > 0 && availableMM == 0 {
            availableString += "주행가능"
        } else {
            availableString += "\(availableMM)분 주행가능"
        }
        
        return availableString
        
    }
    
    
    
}
