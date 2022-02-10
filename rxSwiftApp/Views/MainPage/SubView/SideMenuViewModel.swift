//
//  SideMenuViewModel.swift
//  rxSwiftApp
//
//  Created by Hwik on 2022/02/09.
//

import Foundation
import Foundation
import UIKit
import RxSwift
import RxCocoa
import RxRelay
import RxDataSources

class SideMenuViewModel : ViewModelProtocol {

    struct Input {
        let tutoringCreateOpen = PublishRelay<UITapGestureRecognizer>()
    }
   
    struct Output {
      
        let daySchedules = BehaviorRelay<[DaysModel]>(value: [])
    }
    let input = Input()
    let output = Output()
    
    
    var network = NetworkingAPI.shared

    let coordinator : SideMenuViewCoordinator
    
    private let disposeBag = DisposeBag()
    
    init(coordinator : SideMenuViewCoordinator){
        self.coordinator = coordinator
        bindInput()
        bindOutput()
    }
    
    
    func bindInput() {
        input.tutoringCreateOpen
            .subscribe { [weak self] _ in
                self?.coordinator.tutoringCreateViewOpen()
            }.disposed(by: disposeBag)
        
        
    }
    
    func bindOutput() {
        
    }
}
