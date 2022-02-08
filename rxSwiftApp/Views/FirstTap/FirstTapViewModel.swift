//
//  FirstTapViewModel.swift
//  rxSwiftApp
//
//  Created by Hwik on 2022/01/03.
//
import RxSwift
import RxCocoa
import RxRelay
import RxDataSources
import Then
import UIKit

class FirstTapViewModel : ViewModelProtocol {
    
    var network: NetworkingService = NetworkingAPI.shared
    
    weak var coordinator : FirstTabViewCooridnator?

    private let disposeBag = DisposeBag()
    
    struct Input {
        let monthController = PublishSubject<Int>()
        let month = BehaviorRelay<DateComponents>(value: DateComponents())
    }
    
    struct Output {
        let heeaderIndex = PublishRelay<IndexPath>()
        let weekDays = BehaviorRelay<[DaysModel]>(value: [])
        let MonthText = BehaviorRelay<String>(value: "")
        let daySchedules = BehaviorRelay<[DaysModel]>(value: [DaysModel(name: "1월1일", items: ["숨쉬기","가만히있기","숨우우우움","테스트","rkdwl"]),DaysModel(name: "1월2일", items: ["숨쉬기","가만히있기","숨우우우움","테스트","rkdwl"]),DaysModel(name: "1월3일", items: ["숨쉬기","가만히있기","숨우우우움","테스트","rkdwl"]),DaysModel(name: "1월4일", items: ["숨쉬기","가만히있기","숨우우우움","테스트","rkdwl"]),DaysModel(name: "1월5일", items: ["숨쉬기","가만히있기","숨우우우움","테스트","rkdwl"]),DaysModel(name: "1월6일", items: ["숨쉬기","가만히있기","숨우우우움","테스트","rkdwl"]),DaysModel(name: "1월7일", items: ["숨쉬기","가만히있기","숨우우우움","테스트","rkdwl"]),DaysModel(name: "1월8일", items: ["숨쉬기","가만히있기","숨우우우움","테스트","rkdwl"]),DaysModel(name: "1월9일", items: ["숨쉬기","가만히있기","숨우우우움","테스트","rkdwl"]),DaysModel(name: "1월10일", items: ["숨쉬기","가만히있기","숨우우우움","테스트","rkdwl"]),DaysModel(name: "1월11일", items: ["숨쉬기","가만히있기","숨우우우움","테스트","rkdwl"]),DaysModel(name: "1월12일", items: ["숨쉬기","가만히있기","숨우우우움","테스트","rkdwl"]),DaysModel(name: "1월13일", items: ["숨쉬기","가만히있기","숨우우우움","테스트","rkdwl"]),DaysModel(name: "1월14일", items: ["숨쉬기","가만히있기","숨우우우움","테스트","rkdwl"])])
    }
    
    let input = Input()
    let output = Output()
    
    
    let cal = Calendar.current
    
    let now = Date()
    
    
    
    lazy var dateFormatter = DateFormatter().then {
    
        $0.dateFormat = "yyyy년 M월"
    
    }
    
    lazy var components : DateComponents = {
        var dateComponets = DateComponents()
        dateComponets.year = cal.component(.year, from: now)
        dateComponets.month = cal.component(.month, from: now)
        dateComponets.day = 1
        return dateComponets
    }()
    

  
    
   
    
    
    
    init(){
        bindInput()
        bindOutput()
    }
    
    
    func bindInput() {
     
        
        input.month
            .bind(onNext: { [weak self] in  self?.calculation(components: $0 ) })
            .disposed(by: disposeBag)
      
        input.monthController
            .subscribe(onNext: { [weak self] controlInt in
                guard let self = self else { return }
                var month = self.input.month.value
                month.month! += controlInt
                self.input.month.accept(month)
            })
           .disposed(by: disposeBag)

        input.month.accept(components)
        
        
      
    }
    
    func bindOutput() {
        
//
//
//        calculation()
    }
    
    
    
    func calculation(components : DateComponents) { // 월 별 일 수 계산
        var daysCountInMonth = 0 // 해당 월이 며칠까지 있는지
        
        var weekdayAdding = 0 // 시작일
        
        
        // 이번달의 첫날짜를 계산해준다.
        let firstDayOfMonth = cal.date(from: components)
        // 해당 수로 반환이 됩니다. 1은 일요일 ~ 7은 토요일
        let firstWeekday = cal.component(.weekday, from: firstDayOfMonth!)
        
        daysCountInMonth = cal.range(of: .day, in: .month, for: firstDayOfMonth!)!.count
        
        weekdayAdding = 2 - firstWeekday
        // 이 과정을 해주는 이유는 예를 들어 2020년 4월이라 하면 4월 1일은 수요일 즉, 수요일이 달의 첫날이 됩니다.  수요일은 component의 4 이므로 CollectionView에서 앞의 3일은 비울 필요가 있으므로 인덱스가 1일부터 시작할 수 있도록 해줍니다. 그래서 2 - 4 해서 -2부터 시작하게 되어  정확히 3일 후부터 1일이 시작하게 됩니다.
        output.MonthText.accept(dateFormatter.string(from: firstDayOfMonth!))
        
        var tempDays : [String] = []
        for day in weekdayAdding...daysCountInMonth {
    
            if day < 1 { // 1보다 작을 경우는 비워줘야 하기 때문에 빈 값을 넣어준다.
                tempDays.append("")
            } else {
                tempDays.append(String(day))
            }
        }
        
        output.weekDays.accept([DaysModel(name: "요일", items: ["일", "월", "화", "수", "목", "금", "토"]),
                                 DaysModel(name: "날짜", items: tempDays)])
//        ([DaysModel(name: "요일", items: ["일", "월", "화", "수", "목", "금", "토"]),
//                                 DaysModel(name: "날짜", items: tempDays)])
        
        
    }
    
    
}



