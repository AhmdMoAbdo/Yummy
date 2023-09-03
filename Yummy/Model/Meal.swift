//
//  Meal.swift
//  Yummy
//
//  Created by Ahmed on 21/08/2023.
//

import Foundation
import RealmSwift

class Meal: Object,Codable,Identifiable{
    @Persisted var idMeal: String?
    @Persisted var strMeal: String?
    @Persisted var strCategory: String?
    @Persisted var strArea: String?
    @Persisted var strInstructions: String?
    @Persisted var strMealThumb: String?
    @Persisted var strTags: String?
    @Persisted var strYoutube: String?
    @Persisted var strIngredient1: String?
    @Persisted var strIngredient2: String?
    @Persisted var strIngredient3: String?
    @Persisted var strIngredient4: String?
    @Persisted var strIngredient5: String?
    @Persisted var strIngredient6: String?
    @Persisted var strIngredient7: String?
    @Persisted var strIngredient8: String?
    @Persisted var strIngredient9: String?
    @Persisted var strIngredient10: String?
    @Persisted var strIngredient11: String?
    @Persisted var strIngredient12: String?
    @Persisted var strIngredient13: String?
    @Persisted var strIngredient14: String?
    @Persisted var strIngredient15: String?
    @Persisted var strIngredient16: String?
    @Persisted var strIngredient17: String?
    @Persisted var strIngredient18: String?
    @Persisted var strIngredient19: String?
    @Persisted var strIngredient20: String?
    @Persisted var strMeasure1: String?
    @Persisted var strMeasure2: String?
    @Persisted var strMeasure3: String?
    @Persisted var strMeasure4: String?
    @Persisted var strMeasure5: String?
    @Persisted var strMeasure6: String?
    @Persisted var strMeasure7: String?
    @Persisted var strMeasure8: String?
    @Persisted var strMeasure9: String?
    @Persisted var strMeasure10: String?
    @Persisted var strMeasure11: String?
    @Persisted var strMeasure12: String?
    @Persisted var strMeasure13: String?
    @Persisted var strMeasure14: String?
    @Persisted var strMeasure15: String?
    @Persisted var strMeasure16: String?
    @Persisted var strMeasure17: String?
    @Persisted var strMeasure18: String?
    @Persisted var strMeasure19: String?
    @Persisted var strMeasure20: String?
    @Persisted var fav: Bool?
    @Persisted var sat: Bool?
    @Persisted var sun: Bool?
    @Persisted var mon: Bool?
    @Persisted var tue: Bool?
    @Persisted var wed: Bool?
    @Persisted var thu: Bool?
    @Persisted var fri: Bool?
}
