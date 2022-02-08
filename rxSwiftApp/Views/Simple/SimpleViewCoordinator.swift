//
//  SimpleViewCoordinator.swift
//  rxSwiftApp
//
//  Created by Hwik on 2022/01/03.
//

import Foundation


class SimpleViewCoordinator : Coordinator {

    weak var parentCoordinator : TabViewCoordinator?
    
    var childCoordinator: [Coordinator] = []
    
    func start() {
        let view = SimpleViewController()
        let viewModel = SimpleViewModel()
        view.viewModel = viewModel
        parentCoordinator?.tabBaseRouter.push(view, isAnimated: true, onNavigationBack: nil)
    }
}
