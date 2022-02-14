
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
    
    var viewModel: MainPageViewModel!
    var scheduler: TestScheduler!
    // MARK: - GIVEN

    override func setUp() {
        let mockNetworkingAPI =  NetworkingAPI(provider: MoyaProvider<NetworkAPI>(stubClosure: { _ in .immediate }))
        viewModel = MainPageViewModel(networkAPI: mockNetworkingAPI)
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
      
        
        
        
        
        viewModel.output.weekDays
            .map{
                print($0.first?.name)
                return $0.first?.name ?? ""
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
