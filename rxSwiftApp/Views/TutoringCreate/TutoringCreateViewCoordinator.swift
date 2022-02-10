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
        let view = TutoringCreateViewController()
        let viewModel = TutoringCreateViewModel(coordinator: self)
        view.viewModel = viewModel
        parentCoordinator?.tabBaseRouter.push(view, isAnimated: true, onNavigationBack: nil)
    }
}
