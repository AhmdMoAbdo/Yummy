//
//  MealDetailsEndpoint.swift
//  Yummy
//
//  Created by Ahmed Abdo on 09/05/2025.
//

import Foundation

enum MealDetailsEndpoint: EndPoint {
    case mealDetails(mealID: String)
}

extension MealDetailsEndpoint {
    var path: String {
        return "lookup.php"
    }
    
    var queryParameters: [String : String?] {
        switch self {
        case .mealDetails(mealID: let mealID):
            return["i": mealID]
        }
    }
    
    var headers: [String : String] { [:] }
    
    var bodyParmaters: [String : Any?] { [:] }
}
