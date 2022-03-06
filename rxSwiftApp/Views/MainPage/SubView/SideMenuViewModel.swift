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
//        let tutoringCreateOpen = PublishRelay<UITapGestureRecognizer>()
    }
   
    struct Output {
      
//        let daySchedules = BehaviorRelay<[DaysModel]>(value: [])
    }
   
    
    var networkAPI : NetworkingAPI

    let coordinator : SideMenuViewCoordinator
    
    let disposeBag = DisposeBag()
    
    required init(networkAPI: NetworkingAPI = NetworkingAPI.shared, coordinator: SideMenuViewCoordinator){
        self.networkAPI = networkAPI
        self.coordinator = coordinator
      
    }
    
    func transform(input: Input) -> Output {
        Output()
    }
    
   
    
    
}
