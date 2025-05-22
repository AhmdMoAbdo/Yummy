//
//  Response.swift
//  Yummy
//
//  Created by Ahmed on 21/08/2023.
//

import Foundation

struct MealsResponse: Codable{
    var meals: [Meal]?
}

struct CountriesResponse: Codable {
    var meals: [Country]?
}

struct IngredientResponse: Codable {
    var meals: [Ingredient]?
}

struct CategoriesResponse: Codable {
    var categories: [Category]?
}
