//
//  SearchService.swift
//  Yummy
//
//  Created by Ahmed Abdo on 09/05/2025.
//

import Foundation

class SearchService: APIService<SearchEndpoint> {
    func searchFor(query: String, completion: @escaping (MealsResponse?) -> Void) {
        sendRequest(to: .search(query: query)) { (response: MealsResponse?) in
            completion(response)
        }
    }
}
