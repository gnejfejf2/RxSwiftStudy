//
//  APIURLEnum.swift
//  HwikPinePass (iOS)
//
//  Created by Hwik on 2021/09/10.
//

import Foundation

enum API_URL: String {
    //직사각형 내 장비 조회
    case FMS_GET_EQUIPMENTS = "/v2/fms-api/e/equipments"
    //서비스 지역 조회
    case FMS_GET_SERVICEAREA = "/v2/fms-api/e/services/geofences"
    //대여 가능여부 조회
    case FMS_GET_RENTAL_POSSIBLE = "/v2/fms-api/e/area/rental"
    //반납 지역 가능 여부 조회
    case FMS_RETURN_AREA_POSSIBLE = "/v2/fms-api/e/member/location"
    //고장부품 목록 조회
    case FMS_GET_DEFECT_PARTS = "/v2/fms-api/e/defect-parts"
    //장비 찾기 알람 작동 요청
    case FMS_POST_EQUIPMENTS_BEEP =  "/v2/fms-api/e/equipments/:equipmentID/beep"
    //고장부위 신고
    case FMS_POST_EQUIPMENTS_DEFECT_REPORTS = "/v2/fms-api/e/equipments/:equipmentID/defect-reports"
    //여기 없어요 신고
    case FMS_POST_EQUIPMENTS_NOT_HERE = "/v2/fms-api/e/equipments/:equipmentID/find-report"
    //스팟목록
    case SPOT_GET_LIST = "/v2/spot/e/spots"
    //스팟상세 조회
    case SPOT_GET_DETAIL = "/v2/spot/e/spot/"
    //미납요금 조회
    case RENTAL_GET_NONPAYMENTS = "/v2/rental/e/nonpayments/:memberNumber"
    //서비스 정보 조회
    case MEMBER_GET_SERVICE_INFO = "/v2/member/e/service/info"
    //리프레쉬 토큰 처리
    case MEMBER_POST_REFRESH_TOKEN = "/v2/member/e/auth/refreshtoken"
    //토큰 유효성 확인
    case MEMBER_GET_AUTH_VALIDATION = "/v2/member/e/auth/validation"
    //카드 등록 확인
    case MEMBER_GET_PAYMENTCARD = "/v2/payment/e/card"
    
    //이용 대여 등록
    case RENTAL_POST_RENTALS = "/v2/rental/e/rentals"
    case RENTAL_GET_RENTALS_STATUS = "/v2/rental/e/rentals/:memberNumber/status"
    case RENTAL_PUT_RENTALS_RETURN = "/v2/rental/e/rentals/return"
    case RENTAL_POST_SPOT_RETURN = "/v2/rental/e/spots"
    case RENTAL_POST_NONPAYMENT_PAYMENT = "/v2/rental/e/nonpayments/payment"
    case RENTAL_POST_RENTAL_HELMET = "/v2/rental/e/helmets"
    
    case RENTAL_POST_RENTAL_HELMET_DOOR = "/v2/rental/e/helmet/door/unlock"
    
    //대여시 사용가능한 이용권 목록 조회
    case RENTAL_GET_USABLE_RECORDS = "/v2/buy/e/buy/usable-records/:memberNumber"
    
    case RENTAL_GET_RENTAL_CKECK_HELMET = "/v2/rental/e/helmets/:rentalID/return"
    
    case SEND_POST_PUSH_FCM_TOKEN = "/v2/send/e/push/token"
    case SEND_POST_PUSH_RECEIVE_AGREEMENT = "/v2/send/e/push/receiveAgreement"
    
    case NTC_GET_NOTICE_MAIN = "/v2/ntc/e/notices/main"
    case GOODS_GET_CURRENT_RENTAL_FARE = "/v2/goods/e/rental-fare/base-goods/:serviceRegionID/:modelID/current"
    
    case BANNER_GET_BANNERS = "/v2/banner/e/banners"
    
    ///휙파인 POI 검색
    case POI_GET_SEARCH = "/v2/poi/e/poi/inavi/pois"
    ///휙파인 카테고리 목서버
    case POI_CAREGORY_SEARCH = "/v2/poi/e/poi/best/category"
    ///POI Detail
    case POI_DETAIL_GET = "/v2/poi/e/poi/inavi/pois/details"
    ///루트 검색에서 사용할 서비스 지역조회
    case SERVICE_AREA_GET = "/v2/poi/e/geo/poi-service-area"
    ///루트 검색에서 사용할 서비스 지역조회
    case SERVICE_AREA_VERSION_GET = "/v2/poi/e/geo/poi-service-area/version"
    ///루트 검색 GeoReverse
    case ROUTE_REVERSEGEO_GET = "/v2/poi/e/geo/reverse-geocoding"
    ///추천경로조회
    case ROUTE_RECOMMENDROUTE_POST = "/v2/rut/e/routes/recommend-route"
    ///추천경로조회
    case ROUTE_RECOMMENDROUTE_SORT_GET = "/v2/rut/e/routes/recommend-route/rtSrchId/orderCd"
    ///경로 좌표 획득
    case ROUTE_PATHPOINT_GET = "/v2/rut/e/routes/recommend-route/sctn-crdnts/multi/:key"
}

// GQL URL
enum GQL_URL: String {
    case POST_AUTH_QUERY = "/v2/navigation-drawer/e/auth/query"
    case POST_UNAUTH_QUERY = "/v2/navigation-drawer/e/unauth/query"
}
