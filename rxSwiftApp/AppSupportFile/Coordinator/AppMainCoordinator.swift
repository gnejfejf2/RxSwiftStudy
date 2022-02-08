//
//  AppMainCoordinator.swift
//  rxSwiftApp
//
//  Created by Hwik on 2022/01/02.
//

import UIKit


//앱 댈리게이트에서 사용할 최초의 코디네이터
class AppMainCoordinator : AppMainCooridnatorProtocol {
    
    
  
    
    var appMainRouter : Router
    
    var childCoordinators = [Coordinator]()
    
    
    weak var finishCoordinator : CoordinatorFinishDelegate?
    
    required init(_ navigationController: UINavigationController) {
        self.appMainRouter = Router(navigationController: navigationController , navigationBarHidden : true)
//        finishCoordinator = self
      
    }
    
    func start() {
        tabBarStart()
    }
    
    
    func tabBarStart() {
        
        let tabBarCoordinator = TabBarMasterCoordinator(self)
        childCoordinators.append(tabBarCoordinator)
        tabBarCoordinator.start()
    }
    
    
    
    

}


