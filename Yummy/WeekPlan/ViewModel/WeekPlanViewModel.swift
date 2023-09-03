//
//  WeekPlanViewModel.swift
//  Yummy
//
//  Created by Ahmed on 28/08/2023.
//

import Foundation

class WeekPlanViewModel: ObservableObject{
    
    @Published var dayPlanArr: [Meal] = []
        
    func checkMealIsAlreadyInPlan(day: WeekDays, meal: Meal) -> Bool {
        return RealmManger.dbManger.checkMealIsAlreadyPickedForTheDay(day: day, meal: meal)
    }
    
    func getDayPlan(day: WeekDays){
        dayPlanArr = []
        dayPlanArr = RealmManger.dbManger.getDayMeals(day: day)
    }
    
    func addMealToDayPlan(day: WeekDays, meal: Meal){
        RealmManger.dbManger.addMealToWeekPlan(day: day, meal: meal)
    }
    
    func deleteMealFromDayPlan(day: WeekDays, meal: Meal){
        RealmManger.dbManger.deleteMealFromWeekPlan(day: day, meal: meal)
        for (idx,mealInArr) in dayPlanArr.enumerated(){
            if meal.strMeal == mealInArr.strMeal {
                dayPlanArr.remove(at: idx)
                break
            }
        }
    }
    
    func getMealIndex(meal: Meal) -> Int {
        for (idx,mealInArr) in dayPlanArr.enumerated() {
            if meal.strMeal == mealInArr.strMeal{
                return idx
            }
        }
        return 0
    }
    
    func getFullDayName(day: WeekDays) -> String{
        switch day{
        case .sat:
            return "Saturday"
        case .sun:
            return "Sunday"
        case .mon:
            return "Monday"
        case .tue:
            return "Tuesday"
        case .wed:
            return "Wednesday"
        case .thu:
            return "Thursday"
        case .fri:
            return "Friday"
        }
    }
}
