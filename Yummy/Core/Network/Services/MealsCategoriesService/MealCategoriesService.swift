//
//  MealCategoriesService.swift
//  Yummy
//
//  Created by Ahmed Abdo on 09/05/2025.
//

import Foundation

class MealCategoriesService: APIService<MealsCategoriesEndpoint> {
    private var dispatchGroup = DispatchGroup()
    private var detailsService = MealDetailsService()
    private var mealsArr: [Meal] = []
    
    func getAllCategories(completion: @escaping (CategoriesResponse?) -> Void) {
        sendRequest(to: .getAllCategories) { (response: CategoriesResponse?) in
            completion(response)
        }
    }
    
    func getAllIngredients(completion: @escaping (IngredientResponse?) -> Void) {
        sendRequest(to: .getAllIngredients) { (response: IngredientResponse?) in
            completion(response)
        }
    }
    
    func getAllCountries(completion: @escaping (CountriesResponse?) -> Void) {
        sendRequest(to: .getAllCountries) { (response: CountriesResponse?) in
            completion(response)
        }
    }
    
    func getFilteredList(type: CategoriesMainFilter, subFilter: String, completion: @escaping ([Meal]) -> Void) {
        mealsArr = []
        sendRequest(to: .getCategorizedMeal(mainFilter: type, subFilter: subFilter)) { [weak self] (response: MealsResponse?) in
            guard let self else { return }
            for meal in response?.meals ?? [] {
                dispatchGroup.enter()
                detailsService.getMealDetails(mealID: meal.idMeal ?? "") { [weak self] response in
                    guard let self else { return }
                    if let fullMealDetails = response?.meals?.first {
                        mealsArr.append(fullMealDetails)
                    }
                    dispatchGroup.leave()
                }
            }
            dispatchGroup.notify(queue: .main) { [weak self] in
                guard let self else { return }
                completion(mealsArr)
            }
        }
    }
}
