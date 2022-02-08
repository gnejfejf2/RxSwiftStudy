import Moya

import Alamofire
import RxSwift

typealias ApiParameter = [String : Any]

protocol NetworkingService {
//    func request(_ api: NetworkAPI) -> Single<Response>
    
   // func Request<T: Decodable>(_ api: NetworkAPI) -> Observable<Result<T>>
    
    func request(_ api: NetworkAPI) -> Single<Response>
   
    
    var jsonDecoder: JSONDecoder { get }
    
    
}
//
final class NetworkingAPI: NetworkingService {
    static let shared : NetworkingAPI = {
        if(true){
                return NetworkingAPI()
        }else{
                return NetworkingAPI()
        }
    }()
    
    var jsonDecoder: JSONDecoder {
      let decoder = JSONDecoder()
      return decoder
    }
    
    let provider: MoyaProvider<NetworkAPI>

    init(provider: MoyaProvider<NetworkAPI> = MoyaProvider<NetworkAPI>()) {
        self.provider = provider
    }

    
    
 
    
    
    func request(_ api: NetworkAPI) -> Single<Response> {
       
        return provider.rx
            .request(api)
            .flatMap {
                if $0.statusCode == 401{
                    throw TokenError.tokenExpired
                }else{
                   return Single.just($0)
                }
            }
            .retry(when: { (error : Observable<TokenError>) in
                error.flatMap { error -> Single<Response> in
                    NetworkingAPI.shared.renewalToken()
                }
            })
            .filterSuccessfulStatusCodes()
            .retry(3)
           // .asObservable()
           // .map{ try JSONDecoder().decode(TestModel.self, from: $0.data)  }
        
            
        
        
        
        //            //eraseToAnyPublisher은 지금까지의 데이터 스트림이 어떠했던 최종적인 형태의 Publisher
        //            .eraseToAnyPublisher()
    }
    
    func renewalToken() -> Single<Response> {
        return request(.renewalToken)
    }
//
//
////            //eraseToAnyPublisher은 지금까지의 데이터 스트림이 어떠했던 최종적인 형태의 Publisher
////            .eraseToAnyPublisher()
//    }
}

struct TestModel :  Codable {
    var test : String
}

enum NetworkAPI{
    
    case banner
    
    case renewalToken
    
}


extension NetworkAPI : TargetType {
    //BaseURL
    var baseURL: URL {
        return URL(string: "http://13.209.4.105")!
    }
    var headers: [String: String]? {
        return [
            "Content-Type": "application/json;charset=utf-8",
            "x-api-key": "bYhBnoGSsq7GQ80YYf9k9eUpMDufNprC47Jyjwj0"
        ]
    }
    
    //경로
    var path: String {
       return "/indexTest1.php"
    }
    //통신을 get , post , put 등 무엇으로 할지 이곳에서 결정한다 값이 없다면 디폴트로 Get을 요청
    var method : Moya.Method {
        return .post
    }
    //요청시 파라미터를 넣음
    var task: Task {
        switch self {
        case .renewalToken :
            return .requestParameters(parameters: ["refreshToken": "refreshToken"], encoding: URLEncoding.queryString)
        default :
            return .requestPlain
            
        }
    }

}
