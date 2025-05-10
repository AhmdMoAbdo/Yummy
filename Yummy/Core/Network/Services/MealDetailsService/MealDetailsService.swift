//
//  MealDetailsService.swift
//  Yummy
//
//  Created by Ahmed Abdo on 09/05/2025.
//

import Foundation

class MealDetailsService: APIService<MealDetailsEndpoint> {
    func getMealDetails(mealID: String, completion: @escaping (MealsResponse?) -> Void) {
        sendRequest(to: .mealDetails(mealID: mealID)) { (response: MealsResponse?) in
            completion(response)
        }
    }
}
