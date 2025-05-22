//
//  MealsCategoriesEndpoint.swift
//  Yummy
//
//  Created by Ahmed Abdo on 09/05/2025.
//

import Foundation

enum MealsCategoriesEndpoint: EndPoint {
    case getAllCategories
    case getAllCountries
    case getAllIngredients
    case getCategorizedMeal(mainFilter: CategoriesMainFilter, subFilter: String)
}

extension MealsCategoriesEndpoint {
    var path: String {
        switch self {
        case .getAllCategories:
            return "categories.php"
            
        case .getAllCountries:
            return "list.php"
            
        case .getAllIngredients:
            return "list.php"
            
        case .getCategorizedMeal:
            return "filter.php"
        }
    }
    
    var queryParameters: [String : String?] {
        switch self {
        case .getAllCategories:
            return [:]
            
        case .getAllCountries:
            return ["a": "list"]
            
        case .getAllIngredients:
            return ["i": "list"]
            
        case .getCategorizedMeal(let mainFilter, let subFilter):
            return [mainFilter.getRelevantQuery(): subFilter]
        }
    }
    
    var headers: [String : String] { [:] }
    
    var bodyParmaters: [String : Any?] { [:] }
}
