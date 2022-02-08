//
//  BeerModel.swift
//  rxSwiftApp
//
//  Created by Hwik on 2022/01/04.
//

struct Beer: Codable, Equatable {
    var id: Int?
    var name: String?
    var description: String?
    var imageURL: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case imageURL = "image_url"
    }
}
