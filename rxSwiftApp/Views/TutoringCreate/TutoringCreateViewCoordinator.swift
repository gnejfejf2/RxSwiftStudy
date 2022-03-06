//
//  TutoringViewCoordinator.swift
//  rxSwiftApp
//
//  Created by Hwik on 2022/02/09.
//

import Foundation
class TutoringCreateViewCoordinator : Coordinator {

    weak var parentCoordinator : TabViewCoordinator?
    
    var childCoordinator: [Coordinator] = []
    
    func start() {
        
        let viewModel = TutoringCreateViewModel(coordinator: self)
        let view = TutoringCreateViewController(viewModel: viewModel)
     
        parentCoordinator?.tabBaseRouter.push(view, isAnimated: true, onNavigationBack: nil)
    }
}
