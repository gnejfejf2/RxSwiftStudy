//
//  CoordinatorFinishDelegate.swift
//  rxSwiftApp
//
//  Created by Hwik on 2022/01/02.
//

import Foundation

protocol CoordinatorFinishDelegate: AnyObject {
    func coordinatorDidFinish(childCoordinator: Coordinator)
}
