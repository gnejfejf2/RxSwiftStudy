//
//  TutoringViewModel.swift
//  rxSwiftApp
//
//  Created by Hwik on 2022/02/09.
//

import UIKit
import RxSwift
import RxCocoa
import RxRelay
import RxDataSources

struct paymentTypeModel {
    var name : String
    var typeValue : Int
}

class TutoringCreateViewModel : ViewModelProtocol {

    struct Input {
        var pickerIndex : Int = 0
    }
    
    struct Output {
        let selectedIndex = BehaviorRelay<Int>(value: 0)
        let daySchedules = BehaviorRelay<[DaysModel]>(value: [])
        let pickerData = [paymentTypeModel(name: "무료", typeValue: 0),paymentTypeModel(name: "월결제", typeValue: 1),paymentTypeModel(name: "횟수차감", typeValue: 2)]
    }
    
    let input = Input()
    let output = Output()
    

    let coordinator : TutoringCreateViewCoordinator
    
    var network = NetworkingAPI.shared

    private let disposeBag = DisposeBag()
    
    init(coordinator : TutoringCreateViewCoordinator){
        self.coordinator = coordinator
        bindInput()
        bindOutput()
        
    }
    
    
    func bindInput() {

        
    }
    
    func bindOutput() {
        
    }
}
