//
//  HomeMealsService.swift
//  Yummy
//
//  Created by Ahmed Abdo on 09/05/2025.
//

import Foundation

class HomeMealsService: APIService<HomeMealsEndpoint> {
    // MARK: - Properties
    private var dispatchGroup = DispatchGroup()
    private var allMealsList: [Meal] = []
    
    // MARK: - Getting all Meals to be displayed in home screen
    func getHomeMeals(completion: @escaping ([Meal]) -> Void) {
        for _ in 1...24 {
            dispatchGroup.enter()
            getSingleMeal { [weak self] mealsResponse in
                guard let self, let meal = mealsResponse?.meals?.first else { return }
                allMealsList.append(meal)
                dispatchGroup.leave()
            }
        }
        dispatchGroup.notify(queue: .main) { [weak self] in
            guard let self else { return }
            completion(allMealsList)
        }
    }
    
    // MARK: - Getting a single meal
    private func getSingleMeal(completion: @escaping (MealsResponse?) -> Void) {
        sendRequest(to: .homeMeal) { (response: MealsResponse?) in
            completion(response)
        }
    }
}
