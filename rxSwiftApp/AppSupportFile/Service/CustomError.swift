//
//  CustomError.swift
//  rxSwiftApp
//
//  Created by Hwik on 2022/01/04.
//

import Foundation
enum CustomError: String, Error {
    case authorize = "Unable to authenticate user. An error occurred during authorization, please check your connection and try again."
    case unavailableServer = "Server is unavailable"
    case badRequest = "Bad Request"
}
