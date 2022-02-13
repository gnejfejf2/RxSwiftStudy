//
//  ScheduleListViewModel.swift
//  rxSwiftApp
//
//  Created by Hwik on 2022/02/12.
//
import UIKit
import RxSwift
import RxCocoa
import RxRelay
import RxDataSources

class ScheduleListViewModel : ViewModelProtocol {

    
    struct Input {
        
    }
    
    struct Output {
      
    }
    
    let input = Input()
    let output = Output()
    

    let coordinator : ScheduleListViewCoordinator
    
    var network = NetworkingAPI.shared

    private let disposeBag = DisposeBag()
    
    init(coordinator : ScheduleListViewCoordinator){
        self.coordinator = coordinator
    }
    
    
    func bindInput() {
  
        
        
    }
    
    func bindOutput() {
        
    }
}
