//
//  WeekPlanViewModel.swift
//  Yummy
//
//  Created by Ahmed on 28/08/2023.
//

import Foundation

class WeekPlanViewModel: BaseViewModel {
    // MARK: - Properties
    @Published var dayPlanArr: [Meal] = []
    @Published var mealToBeDeleted: Meal?
    
    // MARK: - Getting the meals of a specific day
    func getDayPlan(day: WeekDays) {
        dayPlanArr = DBManager.shared.getMealsOfASpecifcDay(day)
    }
    
    // MARK: - Deleting a meal from a specific day plan
    override func deleteMealFromDayPlan(day: WeekDays, meal: Meal) {
        guard let mealToBeDeleted else { return }
        super.deleteMealFromDayPlan(day: day, meal: mealToBeDeleted)
        dayPlanArr.removeAll { $0.strMeal == meal.strMeal }
        self.mealToBeDeleted = nil
    }
}
