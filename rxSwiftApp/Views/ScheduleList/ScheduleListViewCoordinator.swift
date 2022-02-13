//
//  ScheduleListViewCoordinator.swift
//  rxSwiftApp
//
//  Created by Hwik on 2022/02/12.
//

import Foundation
class ScheduleListViewCoordinator : Coordinator {

    weak var parentCoordinator : TabViewCoordinator?
    
    var childCoordinator: [Coordinator] = []
    
    func start() {
        let view = ScheduleListViewController()
        let viewModel = ScheduleListViewModel(coordinator: self)
        view.viewModel = viewModel
        parentCoordinator?.tabBaseRouter.push(view, isAnimated: true, onNavigationBack: nil)
    }
    
    
}
