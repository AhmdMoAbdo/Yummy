//
//  MealIngredient.swift
//  Yummy
//
//  Created by Ahmed on 22/08/2023.
//

import Foundation

class MealIngredient: Identifiable{
    var ingredientName:String
    var amount:String
    var thumbnail:String
    
    init(ingredientName: String, amount: String, thumbnail: String) {
        self.ingredientName = ingredientName
        self.amount = amount
        self.thumbnail = thumbnail
    }
}
