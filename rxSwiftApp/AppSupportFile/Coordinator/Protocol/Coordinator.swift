//
//  Coordinator.swift
//  rxSwiftApp
//
//  Created by Hwik on 2022/01/02.
//

import UIKit

protocol Coordinator : AnyObject {
    
    var childCoordinator : [Coordinator] { get set }
    
    func start()

}
