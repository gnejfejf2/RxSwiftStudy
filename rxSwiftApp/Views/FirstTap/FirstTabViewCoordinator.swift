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


class FirstTabViewCooridnator : TabViewCoordinator , FirstTabProtocol {
    
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
        let view = FirstTabViewController()
        let viewModel = FirstTapViewModel()
        viewModel.coordinator = self
        view.viewModel = viewModel
       
//        view.tabBarItem = UITabBarItem(title: tabBarPage.pageTitleValue(), image: UIImage(systemName: "homekit"), tag: tabBarPage.pageOrderNumber())
        navigatonController.pushViewController(view, animated: true)
    }
    
    func simpleViewOpen(){
        
        let coordinator = SimpleViewCoordinator()
        coordinator.parentCoordinator = self
        coordinator.start()
        
    }
    
}
