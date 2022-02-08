import UIKit


class ThirdTabViewCoordinator : TabViewCoordinator {
    var tabBarPage: TabBarPage
    
    var tabBarCoordinator : TabBarMasterCoordinator
    
    var navigatonController : UINavigationController =  UINavigationController()
    
    var childCoordinator: [Coordinator] = []
    
    var tabBaseRouter: Router
    
    init(_ tabBarCoordinator : TabBarMasterCoordinator , _ page : TabBarPage){
        self.tabBarCoordinator = tabBarCoordinator
        self.tabBarPage = page
        self.tabBaseRouter = Router(navigationController: navigatonController, navigationBarHidden: true)
    }
    
    
    func start() {
        let view = ThirdTabViewController()
        view.tabBarItem = UITabBarItem(title: tabBarPage.pageTitleValue(), image: UIImage(systemName: "homekit"), tag: tabBarPage.pageOrderNumber())
        tabBaseRouter.push(view, isAnimated: false, onNavigationBack: nil)
        
    }
}
