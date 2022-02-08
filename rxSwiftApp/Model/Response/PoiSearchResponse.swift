//
//  poiSearchResponse.swift
//  rxSwiftApp
//
//  Created by Hwik on 2022/01/04.
//

import Foundation
// MARK: - MainPOIModel
struct PoiSearchResponse: Hashable , Codable {
    let resultCode, resultMessage, detailMessage: String
    let data: [Pois]?
}
