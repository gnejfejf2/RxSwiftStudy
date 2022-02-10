//
//  File.swift
//  rxSwiftApp
//
//  Created by Hwik on 2022/01/03.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import RxRelay
import RxDataSources

class DayScheduleViewModel : ViewModelProtocol {

    
    struct Output {
      
        let daySchedules = BehaviorRelay<[DaysModel]>(value: [])
    }
    
    let output = Output()
    

    let coordinator : DayScheduleViewCoordinator
    
    var network = NetworkingAPI.shared

    private let disposeBag = DisposeBag()
    
    init(coordinator : DayScheduleViewCoordinator){
        self.coordinator = coordinator
    }
    
    
    func bindInput() {
  
        
        
    }
    
    func bindOutput() {
        
    }
}
