//
//  FavoriteViewModel.swift
//  Yummy
//
//  Created by Ahmed on 27/08/2023.
//

import Foundation

class FavoriteViewModel: ObservableObject{
    
    @Published var favMeals: [Meal] = []
    
    func getFavMeals(){
        favMeals = RealmManger.dbManger.getFavouriteMeals()
    }
    
    func checkMealIsFav(meal: Meal) -> Bool {
        return RealmManger.dbManger.checkMealIsInFav(meal: meal)
    }
    
    func addMealToFav(meal: Meal){
        RealmManger.dbManger.addMealToFav(meal: meal)
    }
    
    func deleteMealFromFav(meal: Meal){
        RealmManger.dbManger.deleteMealFromFav(meal: meal)
        for (idx,mealInArr) in favMeals.enumerated(){
            if meal.strMeal == mealInArr.strMeal {
                favMeals.remove(at: idx)
                break
            }
        }
    }
    
    func getMealIndex(meal: Meal) -> Int {
        for (idx,mealInArr) in favMeals.enumerated() {
            if meal.strMeal == mealInArr.strMeal{
                return idx
            }
        }
        return 0
    }
}
