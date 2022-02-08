//
//  TabBarProtocol.swift
//  rxSwiftApp
//
//  Created by Hwik on 2022/01/02.
//

import UIKit

protocol TabBarMasterProtocol {
    
    var appMainCoordinator : AppMainCoordinator { get }
    
    var tabBarController: UITabBarController { get }

    
    func prepareTabBarController(withTabControllers tabControllers: [UIViewController])
}
