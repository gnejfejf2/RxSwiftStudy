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

    

    struct Input {
        
    }
    
    struct Output {
      
//        let daySchedules = BehaviorRelay<[DaysModel]>(value: [])
    }
    
    let output = Output()
    

    let coordinator : DayScheduleViewCoordinator
    
    let networkAPI : NetworkingAPI

    let disposeBag = DisposeBag()
    
    required init(networkAPI : NetworkingAPI = NetworkingAPI.shared , coordinator : DayScheduleViewCoordinator){
        self.networkAPI = networkAPI
        self.coordinator = coordinator
    }
    
    
    func transform(input: Input) -> Output {
        return Output()
    }
  
}
