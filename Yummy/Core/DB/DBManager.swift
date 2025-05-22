//
//  DBManager.swift
//  Yummy
//
//  Created by Ahmed on 27/08/2023.
//

import Foundation
import SwiftData

class DBManager {
    // MARK: - Singleton instance
    static var shared = DBManager()
    
    // MARK: - Properties
    let container: ModelContainer
    let modelContext: ModelContext
    
    // MARK: - Initializer(s)
    private init() {
        do {
            container = try ModelContainer(for: Meal.self)
            modelContext = ModelContext(container)
        } catch {
            fatalError("Failed to create ModelContainer: \(error)")
        }
    }
    
    // MARK: - Favorites Handling
    /// Fetching Favorites list
    func getFavoriteMeals() -> [Meal] {
        return fetchMeals(predicate: #Predicate { $0.fav == true })
    }
    
    /// Check wether a meal is already added as a favorite or not
    func isMealInFav(_ meal: Meal) -> Bool {
        return !(fetchMeals(predicate: #Predicate { $0.fav == true && $0.idMeal == meal.idMeal }).isEmpty)
    }
    
    /// Add Meal to Favorite
    func addMealToFavorite(_ meal: Meal) {
        let availableMeal = fetchMeals(predicate: #Predicate { $0.idMeal == meal.idMeal })
        if availableMeal.isEmpty {
            meal.fav = true
            modelContext.insert(meal)
        } else {
            availableMeal.first?.fav = true
        }
        try? modelContext.save()
    }
    
    /// Deleting a meal from favorite
    func deleteMealFromFavorite(_ meal: Meal) {
        let meals = fetchMeals(predicate: #Predicate { $0.fav == true && $0.idMeal == meal.idMeal })
        if isMealSavedForAnyDay(meal) {
            guard let foundMeal = meals.first else { return }
            foundMeal.fav = false
            modelContext.insert(foundMeal)
        } else {
            modelContext.delete(meal)
        }
        try? modelContext.save()
    }
    
    /// Check whether the meal is saved for any day before deciding to either update the fav state to false or completley reomve the meal
    private func isMealSavedForAnyDay(_ meal: Meal) -> Bool {
        return meal.sat ?? false || meal.sun ?? false || meal.mon ?? false || meal.tue ?? false || meal.wed ?? false || meal.thu ?? false || meal.fri ?? false
    }
    
    // MARK: - WeekPlan Handling
    /// Fetching meals of a specific day
    func getMealsOfASpecifcDay(_ day: WeekDays) -> [Meal] {
        fetchMeals(predicate: day.getFetchingPredicate())
    }
    
    /// Check wether a meal is already added for a specifc day or not
    func isMealAddedForASpeificDay(meal: Meal, day: WeekDays) -> Bool {
        switch day {
        case .sat:
            return !(fetchMeals(predicate: #Predicate { $0.idMeal == meal.idMeal && $0.sat == true }).isEmpty)

        case .sun:
            return !(fetchMeals(predicate: #Predicate { $0.idMeal == meal.idMeal && $0.sun == true }).isEmpty)

        case .mon:
            return !(fetchMeals(predicate: #Predicate { $0.idMeal == meal.idMeal && $0.mon == true }).isEmpty)

        case .tue:
            return !(fetchMeals(predicate: #Predicate { $0.idMeal == meal.idMeal && $0.tue == true }).isEmpty)

        case .wed:
            return !(fetchMeals(predicate: #Predicate { $0.idMeal == meal.idMeal && $0.wed == true }).isEmpty)

        case .thu:
            return !(fetchMeals(predicate: #Predicate { $0.idMeal == meal.idMeal && $0.thu == true }).isEmpty)

        case .fri:
            return !(fetchMeals(predicate: #Predicate { $0.idMeal == meal.idMeal && $0.fri == true }).isEmpty)
        }
    }
    
    /// Add Meal To Weak Plan
    func addMealToASpecificDay(meal: Meal, day: WeekDays) {
        let availableMeal = fetchMeals(predicate: #Predicate { $0.idMeal == meal.idMeal })
        if availableMeal.isEmpty {
            updateSpecificDay(for: meal, day: day, wasAdded: true)
            modelContext.insert(meal)
        } else {
            updateSpecificDay(for: availableMeal.first, day: day, wasAdded: true)
        }
        try? modelContext.save()
    }
        
    /// Deleting a meal from a specfic day
    func deleteMealFromWeekPlan(meal: Meal, day: WeekDays) {
        let availableMeal = fetchMeals(predicate: #Predicate { $0.idMeal == meal.idMeal })
        let otherDays = WeekDays.allCases.filter { $0 != day }
        var atLeastAnotherDayIsAdded = false
        for otherDay in otherDays {
            if isMealAddedForASpeificDay(meal: meal, day: otherDay) {
                atLeastAnotherDayIsAdded = true
                break
            }
        }
        if atLeastAnotherDayIsAdded || isMealInFav(meal) {
            guard let foundMeal = availableMeal.first else { return }
            updateSpecificDay(for: foundMeal, day: day, wasAdded: false)
            modelContext.insert(foundMeal)
        } else {
            modelContext.delete(meal)
        }
        try? modelContext.save()
    }
    
    /// Updating meal existance for a specific day
    private func updateSpecificDay(for meal: Meal?, day: WeekDays, wasAdded: Bool) {
        guard let meal else { return }
        switch day {
        case .sat:
            meal.sat = wasAdded
            
        case .sun:
            meal.sun = wasAdded
            
        case .mon:
            meal.mon = wasAdded
            
        case .tue:
            meal.tue = wasAdded
            
        case .wed:
            meal.wed = wasAdded
            
        case .thu:
            meal.thu = wasAdded
            
        case .fri:
            meal.fri = wasAdded
        }
    }

    /// Fetch meals of a specific predicate
    func fetchMeals(predicate: Predicate<Meal>?) -> [Meal] {
        let descriptor =  FetchDescriptor<Meal>(predicate: predicate)
        return (try? modelContext.fetch(descriptor)) ?? []
    }
}
