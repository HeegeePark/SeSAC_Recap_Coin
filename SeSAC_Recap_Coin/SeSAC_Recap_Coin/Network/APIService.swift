//
//  APIService.swift
//  SeSAC_Recap_Coin
//
//  Created by 박희지 on 2/27/24.
//

import Alamofire
import Foundation

// TODO: NetworkError 정의하고 에러 핸들링하기
final class APIService {
    static let shared = APIService()
    
    private init() { }
    
    typealias completionHandler<T> = ((Result<T, Error>) -> Void)
    
    func request<T: Decodable>(router: APIRouter, model: T.Type, _ completionHandler: @escaping completionHandler<T>) {
        AF.request(router).responseDecodable(of: model) { response in
            switch response.result {
            case .success(let success):
                completionHandler(.success(success))
            case .failure(let failure):
                if let data = response.data {
                    do {
                        let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: data)
                        print("Error Code: \(errorResponse.status.error_code)")
                        print("Error Message: \(errorResponse.status.error_message)")
                        
                    } catch {
                        print("Error decoding error response: \(error)")
                    }
                }
            }
        }
    }
}
