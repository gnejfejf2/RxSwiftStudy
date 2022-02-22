
//  pineUnitTest
//
//  Created by Hwik on 2021/11/18.
//
import XCTest
import Moya
import RxTest
import RxSwift

@testable import rxSwiftApp

class rxUnitTest: XCTestCase {
    let disposeBag = DisposeBag()
    
    var view : MainPageViewController!

    var scheduler: TestScheduler!
    // MARK: - GIVEN

    var appMainCoordinator : AppMainCoordinator!
    
    override func setUp() {
        //앱시작
        appMainCoordinator = AppMainCoordinator(UINavigationController())
        //탭바 시작
        appMainCoordinator.tabBarStart()
        //Mock서버셋팅
        let mockNetworkingAPI =  NetworkingAPI(provider: MoyaProvider<NetworkAPI>(stubClosure: { _ in .immediate }))
        //View생성
        view = MainPageViewController()
        //ViewModel 생성
        let viewModel = MainPageViewModel(networkAPI: mockNetworkingAPI)
        //코디네이터 생성
        let coordinator = MainPageViewCoordinator(appMainCoordinator.tabBarCoordinator!, .first)
        
        viewModel.coordinator = coordinator
        view.viewModel = viewModel
        scheduler = TestScheduler(initialClock: 0 , resolution:  0.01)
    }

    
    
    
      
    
    
    func testCalculation() throws {
        
        // MARK: - WHEN
        
        let observer = scheduler.createObserver(String?.self)
        let cal = Calendar.current
        let now = Date()
        
        var dateComponets = DateComponents()
        dateComponets.year = cal.component(.year, from: now)
        dateComponets.month = cal.component(.month, from: now)
        dateComponets.day = 1
      
        
        
        
        
        view.viewModel?.output.weekDays
            .map{
               $0.first?.name
            }
            .bind(to: observer)
            .disposed(by: disposeBag)
        
        scheduler.start()
        
        let exceptEvents: [Recorded<Event<String?>>] = [
            .next(0, "요일")
        ]
//
//        // MARK: - THEN
//
        XCTAssertEqual(observer.events, exceptEvents)
    }
    
   
}
