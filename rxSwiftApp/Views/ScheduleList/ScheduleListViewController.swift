import UIKit
import Then
import SnapKit
import RxSwift
import RxCocoa
import RxDataSources
import RxRelay
import RxGesture


class ScheduleListViewController: UIViewController , ViewSettingProtocol {
    
  
    private let disposeBag = DisposeBag()
    
    var viewModel : ScheduleListViewModel?
   
    override func viewDidLoad() {
        super.viewDidLoad()
        uiDrawing()
        uiSetting()
        uiBinding()
        eventBinding()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationBarSetting()
    }
    
    func uiDrawing() {
        view.backgroundColor = .primaryColorReverse
     
    }
    
    func uiSetting() {
        
    }
    
    func uiBinding() {
        
    }
    
    func eventBinding() {
        
    }
    

}
