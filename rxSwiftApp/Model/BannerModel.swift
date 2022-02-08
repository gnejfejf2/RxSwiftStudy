//
//  BannerModel.swift
//  rxSwiftApp
//
//  Created by Hwik on 2022/01/25.
//

import Foundation
protocol BannerModelProtocol {

    var homeBannerImageThumbUrl : String { get }
    var homeBannerImageLink : String { get }
}

typealias Banners = [BannerModel]


struct BannerModel :  Codable{

    //var id : String = UUID().uuidString
    var homeBannerImageThumbUrl : String
    var homeBannerImageLink : String

}


extension Banners : Codable{
    
}

extension BannerModel {
    init(usingModel model : BannerModel){
    
        self.homeBannerImageThumbUrl = model.homeBannerImageThumbUrl
        self.homeBannerImageLink = model.homeBannerImageLink
    }
}
