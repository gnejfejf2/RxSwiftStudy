//
//  TapCoordinator.swift
//  rxSwiftApp
//
//  Created by Hwik on 2022/01/03.
//

import UIKit

protocol TabViewCoordinator : Coordinator {
    var tabBarCoordinator : TabBarMasterCoordinator { get }
    
    var navigatonController : UINavigationController { get }
    
    var tabBarPage : TabBarPage { get }
    
    var tabBaseRouter : Router { get }
}
