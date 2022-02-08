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

class SimpleViewModel : ViewModelProtocol {

    var network = NetworkingAPI.shared

    
    let activating = BehaviorSubject<[Pois]>(value: [])
   
    struct Output {
        let pois = BehaviorRelay<[Pois]>(value: [])
        let isLoading = BehaviorRelay<Bool>(value: false)
        let errorRelay = PublishRelay<Error>()
    }
    
    let output = Output()
    
    
    private let disposeBag = DisposeBag()
    
    init(){
        
        let param : [String : Any] = [
            "searchKeyword" : "중국집",
            "district" : 42150,
            "lon" : 126.97207775,
            "lat" : 37.5458176,
            "count" : 50,
            "withBest" : "Y",
            "sort" : "2"
        
        ]
       print(param)
      
        
//        network.request(.poiSearch(param: param))
//            .asObservable()
//            .map(PoiSearchResponse.self)
//            .map{ _ in true }
//            .bind(to: output.isLoading)
//            .disposed(by: disposeBag)
//        
//        network.request(.poiSearch(param: param))
//            .asObservable()
//            .map(PoiSearchResponse.self)
//            .map{ $0.data! }
//            .bind(to: output.pois)
//            .disposed(by: disposeBag)
       
     
       
    }
    
    
    func bindInput() {
        
        DispatchQueue.main.asyncAfter(deadline: Dispatch.DispatchTime.now() + 10) { [weak self] in
            print(self?.output.pois.value)
           // self?.networking = false
        }
    }
    
    func bindOutput() {
        
    }
}
