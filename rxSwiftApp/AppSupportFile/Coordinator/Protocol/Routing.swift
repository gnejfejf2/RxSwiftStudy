//
//  Routing.swift
//  rxSwiftApp
//
//  Created by Hwik on 2022/01/02.
//

import Foundation

typealias FunctionCloure = (() -> ())

protocol Routing {
    func push(_ drawable : Drawable , isAnimated : Bool ,  onNavigationBack closure : FunctionCloure?)
    func pop(_ isAnimated : Bool)
    func popToRoot(_ isAnimated : Bool)
    func presentPopUp(_ drawable: Drawable, isAnimated: Bool, onDismiss closure : FunctionCloure?)
    func present(_ drawable : Drawable , isAnimated : Bool , onDismiss : FunctionCloure?)
    func dismiss(isAnimated: Bool , onDismiss closure : FunctionCloure?)
}
