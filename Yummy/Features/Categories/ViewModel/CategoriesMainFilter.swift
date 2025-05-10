//
//  CategoriesMainFilter.swift
//  Yummy
//
//  Created by Ahmed Abdo on 06/05/2025.
//

import Foundation

enum CategoriesMainFilter: Int, CaseIterable {
    case categories
    case ingredients
    case countries
    
    func getTitle() -> String {
        switch self {
        case .categories:
            return Constants.Categories.filterCategories
            
        case .ingredients:
            return Constants.Categories.filterIngredients
            
        case .countries:
            return Constants.Categories.filterCountries
        }
    }
    
    func getRelevantQuery() -> String {
        switch self {
        case .categories:
            return "c"
            
        case .ingredients:
            return "i"
            
        case .countries:
            return "a"
        }
    }
}
