//
//  HomeViewModel.swift
//  Yummy
//
//  Created by Ahmed on 21/08/2023.
//

import Foundation

class HomeViewModel: ObservableObject{
    
    var network: APIService
    @Published var forYouMeals: [Meal] = []
    @Published var trendingMeals: [Meal] = []
    @Published var newDishMeals: [Meal] = []
    var done: ()->() = {}
    var tempHomeMealsArr: [Meal] = []{
        didSet{
            if tempHomeMealsArr.count == 24 {
                for (index,meal) in tempHomeMealsArr.enumerated(){
                    if index < 8 {
                        forYouMeals.append(meal)
                    }else if index >= 8 && index < 16{
                        trendingMeals.append(meal)
                    }else{
                        newDishMeals.append(meal)
                    }
                }
                done()
            }
        }
    }
    
    init(network: APIService) {
        self.network = network
        getHomeMeals()
    }
    
    func getHomeMeals(){
        let url = "https://www.themealdb.com/api/json/v1/1/random.php"
        for _ in 1 ... 24 {
            network.getMeals(url: url) {[weak self] (response:MealsResponse) in
                self?.tempHomeMealsArr.append((response.meals![0]))
            }
        }
    }
    
    func getForYouMealIndex(meal: Meal) -> Int {
        for (indx,mealInArr) in forYouMeals.enumerated(){
            if mealInArr.strMeal == meal.strMeal {
                return indx
            }
        }
        return 0
    }
    
    func moveArrForward(){
        let firstMeal = forYouMeals[0]
        forYouMeals.remove(at: 0)
        forYouMeals.append(firstMeal)
    }
}
