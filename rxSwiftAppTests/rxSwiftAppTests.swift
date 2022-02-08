
//  pineUnitTest.swift
//  pineUnitTest
//
//  Created by Hwik on 2021/11/18.
//
import UIKit
import XCTest

@testable import RxSwift
@testable import rxSwiftApp

class rxSwiftAppTests: XCTestCase {
    
    // 1
      override func setUpWithError() throws {
      }

      // 2
      override func tearDownWithError() throws {
      }

   
//    func test_Function(){
//        print("1")
//    }
    
    
    func test_FMS_GET_SERVICEAREA_Success(){
        let apiServer = MockNetworkingAPI()
        let expectation = XCTestExpectation(description: "APIPrivoderTaskExpectation")
        apiServer.request(API_URL.FMS_GET_SERVICEAREA.rawValue){ response in
            do{
                let serviceAreaResult = try JSONDecoder().decode(ServiceAreaResult.self, from: response.get().data ?? Data())
                XCTAssertEqual(serviceAreaResult.resultCode, HWIK_RESULT.COMM_SUCCESS.rawValue , "서비스 지역 조회 성공")
                expectation.fulfill()
            }catch{
                XCTAssert(false, "서비스 지역 조회 실패")
                expectation.fulfill()
            }
        }
    }
    
    func test_FMS_GET_SERVICEAREA_Fail(){
        let apiServer = MockNetworkingAPI()
        let expectation = XCTestExpectation(description: "APIPrivoderTaskExpectation")
        apiServer.request(""){ response in
            do{
                let serviceAreaResult = try JSONDecoder().decode(ServiceAreaResult.self, from: response.get().data ?? Data())
                XCTAssertEqual(serviceAreaResult.resultCode, HWIK_RESULT.COMM_SUCCESS.rawValue , "서비스 지역 조회 성공")
                expectation.fulfill()
            }catch{
                XCTAssert(true, "서비스 지역 조회 실패 처리 성공")
                expectation.fulfill()
            }
        }
    }

    func test_FMS_GET_SERVICEAREA_Success_FAIL(){
        let apiServer = MockNetworkingAPI()
        let expectation = XCTestExpectation(description: "APIPrivoderTaskExpectation")
        apiServer.request(API_URL.FMS_GET_SERVICEAREA.rawValue){ response in
            do{
                let serviceAreaResult = try JSONDecoder().decode(Pois.self, from: response.get().data ?? Data())
                XCTAssertEqual(serviceAreaResult.id, HWIK_RESULT.COMM_SUCCESS.rawValue , "일부러 실패")
                expectation.fulfill()
            }catch{
                XCTAssert(false, "일부러 실패")
                expectation.fulfill()
            }
        }
    }
}


//서비스지역
struct ServiceArea: Codable {
    var geofenceTypeCD: String
    var geofenceTypeCDName: String
    var geofences: [Geofence]
}


/* 서비스 지역 조회 결과 */
struct ServiceAreaResult: Codable {
    var resultCode: String
    var resultMessage: String
    var detailMessage: String?
    var data: ServiceAreaGroup?
}

/* 서비스 지역 조회 data */
struct ServiceAreaGroup: Codable {
    var serviceAvailable: ServiceArea
    var serviceDisable: ServiceArea
    var returnDisable: ServiceArea
}



struct Geofence: Codable {
    var serviceRegionID: Int
    var serviceRegionName: String
    var geofenceID: Int
    var details: [GeofenceDetail]
    
    

    
    
}
struct GeofenceDetail: Codable {
    var lat: Double
    var lon: Double
}

enum HWIK_RESULT: String {
    case COMM_SUCCESS                    = "SC0001"
    case FMS0011_EQUIPMENT_ID_NOT_EXISTS                 = "FMS0011" //존재하지 않는 기기입니다.
    case FMS0012_NOT_USE_TIME            = "FMS0012" //지금은 이용시간이 아닙니다.
    case FMS0013_MAINTERNANCE            = "FMS0013" //점검중인 기기 입니다. 주변에 다른 기기를 이용해주세요.
    case FMS0014_BATTERY_NOT_ENOUGH      = "FMS0014" //배터리가 부족합니다. 주변에 다른 기기를 이용해주세요.
    case FMS0015_RESERVED                = "FMS0015" //예약된 기기입니다. 주변에 다른 기기를 이용해주세요.
    case FMS0016_RENTALED                = "FMS0016" //해당 기기는 이미 대여중인 기기 입니다.
    case FMS0019_UNUSABLE                = "FMS0019" //현재 이용할 수 없는 기기 입니다. 주변에 다른 기기를 이용해주세요.
    
    
    
    
    case FMS0051_EQUIPMENT_TOO_FAR       = "FMS0051" //킥보드(전기자전거)와 거리가 너무 멉니다.
    case FMS0052_EQUIPMENT_NOT_USABLE    = "FMS0052" //사용 가능한 킥보드가 아닙니다.
    
    
    
    case RNT0001_UNMATCHED_MEMBERNUMBER  = "RNT0001" //회원정보를 확인해주세요. (요청멤버와 토큰 멤버가 다름)
    case RNT0003_NEED_DRIVER_LICENSE_REGISTER = "RNT0003" //운전면허가 등록되어있지 않습니다.
    case RNT0005_TOO_FAR_EQUIPMENT       = "RNT0005" //이용하려는 기기와 너무 멀리 떨어져 있습니다.
    case RNT0007_PAYMENT_FAIL            = "RNT0007" //결제 실패로 미납요금이 발생하였습니다.
    case RNT0008_INTERNAL_ERROR          = "RNT0008" //등록 또는 수정 요청으로 적용된 행이 0건입니다.
    case RNT0009_NOT_EXISTS_GOODS        = "RNT0009" //이용가능한 상품이 없습니다.
    case RNT0010_INTERFACE_ERROR         = "RNT0010" //인터페이스 오류
    case RNT0012_NOT_RETURN_AREA         = "RNT0012" //반납불가 구역입니다.
    case RNT0013_ADDTION_FARE            = "RNT0013" //추가금액결제(서비스외 지역)
    case RNT0015_NOT_EXISTS_RENTAL       = "RNT0015" //대여중인 정보가 없습니다.
    case RNT0016_NOT_EXISTS_NONPAYMENT   = "RNT0016" //결제내역을 확인해주세요. (미납내역이 없을 경우)
    case RNT0018_FAIL_NONPAYMENT         = "RNT0018" //요금 결제에 실패하였습니다.(미납내역 재결제)
    case RNT0019_ALREADY_RENTAL          = "RNT0019" //회원님은 이미 대여중인 상태입니다. 동일 현상 반복 시 고객센터로 문의 바랍니다.
    case RNT0021_HELMET_NOT_RETURN       = "RNT0021" //헬멧 반납이 확인 되지 않았습니다.
    case RNT0022_NOT_EXISTS_RENT         = "RNT0022" //대여내역이 존재하지 않습니다.
    case RNT0023_NOTHING_RECORD_POINT    = "RNT0023" //적립할 수 있는 포인트가 없습니다.
    case RNT0024_ALREADY_RECORD_POINT    = "RNT0024" //이미 포인트 적립되었습니다.
    case RNT0025_HELMET_LOCKER_NOT_CLOSED = "RNT0025" //헬멧 락커가 닫히지 않았습니다.
    case RNT0026_HELMET_RENTAL_IMPOSSIBLE = "RNT0026" //헬멧을 대여할 수 없는 기기입니다.
    
    case PMT0002_NEED_CARD_REGISTER      = "RNT0002" //등록된 카드정보가 없습니다.
    case PMT0008_MANY_CARD_REGISTER      = "PMT0008" //등록된 카드정보가 여러건입니다.
    
    case SPOT0005_OUT_OF_RANGE           = "SPOT0005" //The user is out of range
    case SPOT0006_INVALID_QR             = "SPOT0006" //Invalid QR Code"

    case BUY0016_AVAILABLE_VOUCHERS = "BUY0016" //이용 가능한 이용권이 있는경우
    case BUY0015_NONE_VOUCHERS = "BUY0015" //이용 가능한 상품이 없는경우
}
