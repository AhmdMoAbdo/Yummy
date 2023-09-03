//
//  ApiHandler.swift
//  Yummy
//
//  Created by Ahmed on 21/08/2023.
//

import Foundation
import Alamofire

protocol APIService{
    func getMeals<T:Codable>(url: String, completionHandler: @escaping (T)->())
}

class APIHandler: APIService{
    func getMeals<T:Codable>(url: String, completionHandler: @escaping (T)->()){
        AF.request(url,method: .get).responseDecodable(of: T.self) { incomingResponse in
            switch incomingResponse.result{
            case .success(let data):
                completionHandler(data)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
