
//
//  MockService.swift
//  pineUnitTest
//
//  Created by Hwik on 2021/11/19.
//

import Foundation
import UIKit
import Alamofire

@testable import rxSwiftApp

class MockNetworkingAPI  {
    
    typealias completionHandler = ((Result<AFDataResponse<Any>, CustomError>) -> Void)
    
    func getItemFromJson(_ api : API_URL) -> Data {
        
        if(api == .FMS_GET_SERVICEAREA){
            return readDataFromJson(fileName: "ServiceArea")
        }else if(api == .RENTAL_GET_USABLE_RECORDS){
            return readDataFromJson(fileName: "UsableRecords")
        }else{
            return Data()
        }
        
    }

    func request(_ url: String, method: HTTPMethod = .get, parameters: Parameters? = nil, encoding: ParameterEncoding = JSONEncoding.default,
                 interceptor: RequestInterceptor? = nil, sessionChecking : Bool = true , completion: @escaping completionHandler) {
        if(url == API_URL.FMS_GET_SERVICEAREA.rawValue){
            completion(.success(AFDataResponse(request: nil, response: nil, data: readDataFromJson(fileName: "ServiceArea"), metrics: nil, serializationDuration: .greatestFiniteMagnitude, result: .success(readDataFromJson(fileName: "ServiceArea")))))
        }else if(url == API_URL.RENTAL_GET_USABLE_RECORDS.rawValue){
           // return readDataFromJson(fileName: "UsableRecords")
        }else{
            completion(.failure(.unavailableServer))
        }
    }
    
    func readDataFromJson(fileName : String) -> Data{
        let t = type(of: self)
        let bundle = Bundle(for: t.self)
        let path = bundle.path(forResource: fileName, ofType: "json")
        let url = URL(fileURLWithPath: path ?? "")
        
      
        
        
        return try! Data(contentsOf: url)
    }
    
}

//class FailedNetworkingAPI: NetworkingService {
//    func request(_: BeerAPI) -> AnyPublisher<[Beer], MoyaError> {
//        return Fail(error: MoyaError.requestMapping(""))
//            .eraseToAnyPublisher()
//    }
//}
