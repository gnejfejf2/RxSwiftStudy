//
//  FirstTapViewCoordinator.swift
//  rxSwiftApp
//
//  Created by Hwik on 2022/01/02.
//

import UIKit

protocol FirstTabProtocol {
    func simpleViewOpen()
}


class MainPageViewCoordinator : TabViewCoordinator , FirstTabProtocol {
    
    var tabBarPage: TabBarPage
    
    var tabBarCoordinator: TabBarMasterCoordinator
    
    var navigatonController : UINavigationController =  UINavigationController()
    
    var childCoordinator : [Coordinator] = []
    
    var tabBaseRouter : Router
    
    init(_ tabBarCoordinator : TabBarMasterCoordinator , _ page : TabBarPage){
        self.tabBarCoordinator = tabBarCoordinator
        self.tabBarPage = page
        self.tabBaseRouter = Router(navigationController: navigatonController, navigationBarHidden: true)
    }
    
    func start() {
        let view = MainPageViewController()
        let viewModel = MainPageViewModel()
        viewModel.coordinator = self
        view.viewModel = viewModel
       
//        view.tabBarItem = UITabBarItem(title: tabBarPage.pageTitleValue(), image: UIImage(systemName: "homekit"), tag: tabBarPage.pageOrderNumber())
        navigatonController.pushViewController(view, animated: true)
    }
    
    func simpleViewOpen(){
        
        let coordinator = DayScheduleViewCoordinator()
        coordinator.parentCoordinator = self
        coordinator.start()
        
    }
    
    func sideMenuOpen(){
        let coordinator = SideMenuViewCoordinator()
        coordinator.parentCoordinator = self
        coordinator.start()
        
//        let view = LoginSideMenuController.instantiate()
//        view.viewModel = LoginSideMenuViewModel(coordinator: self)
//        //커스텀 네비게이션이랑 사이드메뉴 뷰컨트롤러 연결
//        let menu = CustomSideMenuNavigation(rootViewController: view)
//        self.router.sideMenuPresent(menu, isAnimated: true, onDismiss: nil)
    }
    
    
}
