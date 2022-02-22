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
    }
    
    
}
