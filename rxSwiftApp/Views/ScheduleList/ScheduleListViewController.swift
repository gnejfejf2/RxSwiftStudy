import UIKit
import Then
import SnapKit
import RxSwift
import RxCocoa
import RxDataSources
import RxRelay
import RxGesture


class ScheduleListViewController : SuperViewControllerSetting<ScheduleListViewModel> {
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
      
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationBarSetting()
    }
    
   

}
