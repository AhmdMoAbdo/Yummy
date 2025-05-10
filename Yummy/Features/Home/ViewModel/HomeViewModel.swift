//
//  HomeViewModel.swift
//  Yummy
//
//  Created by Ahmed on 21/08/2023.
//

import Foundation

class HomeViewModel: ObservableObject {
    // MARK: - Published variable(s)
    var forYouMeals: [Meal] = []
    var trendingMeals: [Meal] = []
    var newDishMeals: [Meal] = []
    @Published var isLoading: Bool = true
    
    // MARK: - Properties
    private var service = HomeMealsService()
    
    // MARK: - Initializer(s)
    init() {
        getHomeMeals()
    }
    
    // MARK: - Getting all meals to be displayed in home screen
    private func getHomeMeals() {
        service.getHomeMeals { [weak self] meals in
            guard let self else { return }
            prepareMeals(allMealsList: meals)
            isLoading = false
        }
    }
    
    /// Preparing loaded meals into 3 arrays representing 3 home sections
    private func prepareMeals(allMealsList: [Meal]) {
        let singleArrayCount = (allMealsList.count + 2) / 3
        forYouMeals = Array(allMealsList[0..<singleArrayCount])
        trendingMeals = Array(allMealsList[singleArrayCount..<(singleArrayCount * 2)])
        newDishMeals = Array(allMealsList[(singleArrayCount * 2)..<allMealsList.count])
    }
    
    // MARK: - Get the index of a specific meal in the for you sectionÔ
    func getForYouMealIndex(meal: Meal) -> Int {
        forYouMeals.firstIndex(where: { $0.strMeal == meal.strMeal }) ?? 0
    }
    
    // MARK: - Change array order for carousel effect in for you section
    func animateForYouArray() {
        let firstMeal = forYouMeals[0]
        forYouMeals.remove(at: 0)
        forYouMeals.append(firstMeal)
        objectWillChange.send()
    }
}
