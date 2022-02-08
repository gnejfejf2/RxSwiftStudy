//
//  Pois.swift
//  rxSwiftApp
//
//  Created by Hwik on 2022/01/04.
//

import Foundation
// MARK: - Pois
struct Pois: Hashable  , Codable  {
    static func == (lhs: Pois, rhs: Pois) -> Bool {
        return lhs.id == rhs.id
    }
    let id : String = UUID().uuidString
    let seq : Int?
    let poiID : String
    let poiName: String
    let lat, lon : Double
    let landAddress, roadAddress, inaviCategoryCD, inaviCategoryName: String?
    let hwikCategoryCD, hwikCategoryName, tel : String?
    let Distance : Int?
    let Images, MenuImages: [ImageModel]?
    let BriefDescription, ResultType : String?

    enum CodingKeys: String, CodingKey {
        case seq
        case poiID
        case poiName
        case lat
        case lon
        case landAddress
        case roadAddress
        case inaviCategoryCD
        case inaviCategoryName
        case hwikCategoryCD
        case hwikCategoryName
        case tel
        case Distance
        case Images
        case MenuImages
        case BriefDescription
        case ResultType
      
    }
    
    struct ImageModel : Codable , Hashable {
        
        var imagePath : String?
    }

}
