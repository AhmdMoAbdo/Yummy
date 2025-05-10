//
//  SearchEndpoint.swift
//  Yummy
//
//  Created by Ahmed Abdo on 09/05/2025.
//

import Foundation

enum SearchEndpoint: EndPoint {
    case search(query: String)
}

extension SearchEndpoint {
    var path: String {
        return "search.php"
    }
    
    var queryParameters: [String : String?] {
        switch self {
        case let .search(query):
            ["s": query]
        }
    }
    
    var headers: [String : String] { [:] }
    
    var bodyParmaters: [String : Any?] { [:] }
}
