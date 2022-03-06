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
    
  
    
    let networkAPI : NetworkingAPI
    let coordinator : ScheduleListViewCoordinator
    let disposeBag = DisposeBag()
    
    required init(networkAPI : NetworkingAPI = NetworkingAPI.shared , coordinator : ScheduleListViewCoordinator){
        self.networkAPI = networkAPI
        self.coordinator = coordinator
    }
    
    func transform(input: Input) -> Output {
        
        return Output()
    }
}

