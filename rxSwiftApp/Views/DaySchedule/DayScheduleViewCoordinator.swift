//
//  SimpleViewCoordinator.swift
//  rxSwiftApp
//
//  Created by Hwik on 2022/01/03.
//

import Foundation


class DayScheduleViewCoordinator : Coordinator {

    weak var parentCoordinator : TabViewCoordinator?
    
    var childCoordinator: [Coordinator] = []
    
    func start() {
        let view = DayScheduleViewController()
        let viewModel = DayScheduleViewModel(coordinator: self)
        view.viewModel = viewModel
        parentCoordinator?.tabBaseRouter.push(view, isAnimated: true, onNavigationBack: nil)
    }
    
    
}
