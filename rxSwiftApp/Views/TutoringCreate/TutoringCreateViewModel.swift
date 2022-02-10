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

class TutoringCreateViewModel : ViewModelProtocol {

    
    struct Output {
      
        let daySchedules = BehaviorRelay<[DaysModel]>(value: [])
    }
    
    let output = Output()
    

    let coordinator : TutoringCreateViewCoordinator
    
    var network = NetworkingAPI.shared

    private let disposeBag = DisposeBag()
    
    init(coordinator : TutoringCreateViewCoordinator){
        self.coordinator = coordinator
    }
    
    
    func bindInput() {
  
        
        
    }
    
    func bindOutput() {
        
    }
}
