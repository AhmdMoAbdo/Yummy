//
//  MealDetailsViewModel.swift
//  Yummy
//
//  Created by Ahmed Abdo on 09/05/2025.
//

import Foundation

class MealDetailsViewModel: BaseViewModel {
    // MARK: - Properties
    @Published var meal: Meal
    
    // MARK: - Initializer(s)
    init(meal: Meal) {
        self._meal = .init(wrappedValue: meal)
        super.init()
        updateMealToMatchCachcedMeal()
    }
    
    // MARK: - Updating currentley displayed meal to match that in the DB
    func updateMealToMatchCachcedMeal() {
        let savedMeal = DBManager.shared.fetchMeals(predicate: #Predicate { $0.idMeal == meal.idMeal })
        guard let foundMeal = savedMeal.first else { return }
        meal.fav = foundMeal.fav
        meal.sat = foundMeal.sat
        meal.sun = foundMeal.sun
        meal.mon = foundMeal.mon
        meal.tue = foundMeal.tue
        meal.wed = foundMeal.wed
        meal.thu = foundMeal.thu
        meal.fri = foundMeal.fri
    }
    
    // MARK: - Check if meal is already added to a specific day's plan
    func checkMealIsAlreadyInPlan(day: WeekDays) -> Bool {
        return day.getFetchingCondition(for: meal)
    }
    
    // MARK: - Update a specific day's plan
    func updateMealPlanState(day: WeekDays) {
        let isAdded = checkMealIsAlreadyInPlan(day: day)
        if isAdded {
            super.deleteMealFromDayPlan(day: day, meal: meal)
        } else {
            super.addMealToDayPlan(day: day, meal: meal)
        }
        switch day {
        case .sat:
            meal.sat = !isAdded
            
        case .sun:
            meal.sun = !isAdded
            
        case .mon:
            meal.mon = !isAdded
            
        case .tue:
            meal.tue = !isAdded
            
        case .wed:
            meal.wed = !isAdded
            
        case .thu:
            meal.thu = !isAdded
            
        case .fri:
            meal.fri = !isAdded
        }
    }
    
    // MARK: - Day plan update alert message
    func getPlanAlertMessage(day: WeekDays?) -> String {
        guard let day else { return "" }
        return checkMealIsAlreadyInPlan(day: day) ? "Removed from \(day.getFullDayName())'s plan" : "Added to \(day.getFullDayName())'s plan"
    }
    
    // MARK: - Update Fav. state
    func updateFavState() {
        let isFav = meal.fav ?? false
        if isFav {
            super.deleteMealFromFav(meal: meal)
        } else {
            super.addMealToFav(meal: meal)
        }
        meal.fav = !isFav
    }
}
