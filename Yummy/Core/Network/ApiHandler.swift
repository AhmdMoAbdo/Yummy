//
//  ApiHandler.swift
//  Yummy
//
//  Created by Ahmed on 21/08/2023.
//

import Foundation

class APIService<T: EndPoint> {
    func sendRequest<U: Codable>(to endpoint: T, completionHandler: @escaping (U?) -> Void) {
        guard let urlRequest = endpoint.urlRequest else { return }
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard let data = data else {
                completionHandler(nil)
                return
            }
            let decodedData = try? JSONDecoder().decode(U.self, from: data)
            DispatchQueue.main.async {
                completionHandler(decodedData)
            }
        }.resume()
    }
}
