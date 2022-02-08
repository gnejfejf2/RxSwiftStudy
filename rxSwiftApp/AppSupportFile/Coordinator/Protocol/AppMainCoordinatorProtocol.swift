//
//  AppMainCoordinatorProtocol.swift
//  rxSwiftApp
//
//  Created by Hwik on 2022/01/02.
//
//
//  MainCoordinator.swift
//  HwikPineApp
//
//  Created by Hwik on 2021/09/28.
//

import UIKit

protocol AppMainCooridnatorProtocol : AnyObject{
    var appMainRouter : Router { get }
    
    func start()

    func tabBarStart()
}


