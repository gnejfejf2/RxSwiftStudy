//
//  SideMenuCoordinator.swift
//  rxSwiftApp
//
//  Created by Hwik on 2022/02/09.
//

import Foundation


class SideMenuViewCoordinator : Coordinator {

    weak var parentCoordinator : TabViewCoordinator?
    
    var childCoordinator: [Coordinator] = []
    
    func start() {
        let view =  SideMenuViewController()
        let viewModel = SideMenuViewModel(coordinator: self)
        view.viewModel = viewModel
        //커스텀 네비게이션이랑 사이드메뉴 뷰컨트롤러 연결
        let menu = CustomSideMenuNavigation(rootViewController: view)
        
        parentCoordinator?.tabBaseRouter.sideMenuPresent(menu, isAnimated: true, onDismiss: nil)
       
    }
    
    func tutoringCreateViewOpen(){
        let coordinator = TutoringCreateViewCoordinator()
        coordinator.parentCoordinator = parentCoordinator
        parentCoordinator?.tabBaseRouter.dismiss(isAnimated: true, onDismiss: { coordinator.start() })
    }
    
}
