//
//  TabBarEnum.swift
//  rxSwiftApp
//
//  Created by Hwik on 2022/01/02.
//

import Foundation

enum TabBarPage {
    case first
    case second
    case third

    init?(index: Int) {
        switch index {
        case 0:
            self = .first
        case 1:
            self = .second
        case 2:
            self = .third
        default:
            return nil
        }
    }
    
    func pageTitleValue() -> String {
        switch self {
        case .first:
            return "first"
        case .second:
            return "second"
        case .third:
            return "third"
        }
    }

    func pageOrderNumber() -> Int {
        switch self {
        case .first:
            return 0
        case .second:
            return 1
        case .third:
            return 2
        }
    }
}
