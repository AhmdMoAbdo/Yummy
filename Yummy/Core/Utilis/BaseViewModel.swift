//
//  BaseViewModel.swift
//  Yummy
//
//  Created by Ahmed Abdo on 27/04/2025.
//

import Foundation

class BaseViewModel: ObservableObject {
    // MARK: - Favorite handling
    func checkMealIsFav(meal: Meal) -> Bool {
        return DBManager.shared.isMealInFav(meal)
    }
    
    func addMealToFav(meal: Meal) {
        DBManager.shared.addMealToFavorite(meal)
        objectWillChange.send()
    }
    
    func deleteMealFromFav(meal: Meal) {
        DBManager.shared.deleteMealFromFavorite(meal)
        objectWillChange.send()
    }
    
    // MARK: - Week Plan Handling
    func checkMealIsAlreadyInPlan(day: WeekDays, meal: Meal) -> Bool {
        return DBManager.shared.isMealAddedForASpeificDay(meal: meal, day: day)
    }
    
    func addMealToDayPlan(day: WeekDays, meal: Meal) {
        DBManager.shared.addMealToASpecificDay(meal: meal, day: day)
        objectWillChange.send()
    }
    
    func deleteMealFromDayPlan(day: WeekDays, meal: Meal) {
        DBManager.shared.deleteMealFromWeekPlan(meal: meal, day: day)
        objectWillChange.send()
    }
    
    // MARK: - Force updating view if required
    func forceRefreshView() {
        objectWillChange.send()
    }
}
