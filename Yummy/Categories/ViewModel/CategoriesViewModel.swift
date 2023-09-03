//
//  CategoriesViewModel.swift
//  Yummy
//
//  Created by Ahmed on 24/08/2023.
//

import Foundation

class CategoriesViewModel: ObservableObject{
    
    var network: APIService
    var availableCategories: [Category] = []
    var availableCountries: [Country] = []
    var availableIngredients: [Ingredient] = []
    @Published var ingredientsToDisplay: [FilterdListModel] = []
    @Published var countriesToDisplay: [FilterdListModel] = []
    @Published var categoriesToDisplay: [FilterdListModel] = []
    @Published var mealsArr: [Meal] = []{
        didSet{
            if !mealsArr.isEmpty{
                done()
            }
        }
    }
    var done:()->() = {}
    
    
    init(network: APIService) {
        self.network = network
        getAllCountries()
        getAllCategories()
        getAllIngredients()
        getFilteredMeals(filterNumber: 0, filterItem: "Beef")
    }
    
    func getAllCategories(){
        let url = "https://www.themealdb.com/api/json/v1/1/categories.php"
        network.getMeals(url: url) { [weak self] (response: CategoriesResponse) in
            self?.availableCategories = response.categories ?? []
            self?.prepareCatergoriesToDisplayArr()
        }
    }
    
    func prepareCatergoriesToDisplayArr(){
        var tempArr: [FilterdListModel] = []
        for category in availableCategories{
            tempArr.append(FilterdListModel(title: category.strCategory ?? "", imageName: category.strCategoryThumb ?? ""))
        }
        categoriesToDisplay = tempArr
    }
    
    func getAllIngredients(){
        let url = "https://www.themealdb.com/api/json/v1/1/list.php?i=list"
        network.getMeals(url: url) { [weak self] (response: IngredientResponse) in
            self?.availableIngredients = response.meals ?? []
            self?.prepareIngredientsToDisplayArr()
        }
    }
    
    func prepareIngredientsToDisplayArr(){
        var tempArr: [FilterdListModel] = []
        for ingredient in availableIngredients {
            tempArr.append(FilterdListModel(title: ingredient.strIngredient ?? "", imageName: getIngredientImage(ingredientName: ingredient.strIngredient ?? "")))
            if tempArr.count == 50 {
                break
            }
        }
        ingredientsToDisplay = tempArr
    }
    
    func getIngredientImage(ingredientName: String) -> String{
        let urlIngredientName = ingredientName.replacingOccurrences(of: " ", with: "%20")
        return "https://www.themealdb.com/images/ingredients/\(urlIngredientName).png"
    }
    
    func getAllCountries(){
        let url = "https://www.themealdb.com/api/json/v1/1/list.php?a=list"
        network.getMeals(url: url) { [weak self] (response: CountriesResponse) in
            self?.availableCountries = response.meals ?? []
            self?.prepareCountriesToDisplayArr()
        }
    }
    
    func prepareCountriesToDisplayArr(){
        var tempArr: [FilterdListModel] = []
        for country in availableCountries {
            tempArr.append(FilterdListModel(title: country.strArea ?? "", imageName: Flags.getFlag(mealSource: country.strArea ?? "")))
        }
        countriesToDisplay = tempArr
    }
    
    func getFilteredMeals(filterNumber: Int, filterItem: String){
        mealsArr = []
        let filterWord = filterItem.replacingOccurrences(of: " ", with: "%20")
        var urlQuery = ""
        switch filterNumber{
        case 0:
            urlQuery = "c=\(filterWord)"
        case 1:
            urlQuery = "i=\(filterWord)"
        default:
            urlQuery = "a=\(filterWord)"
        }
        let url = "https://www.themealdb.com/api/json/v1/1/filter.php?\(urlQuery)"
        network.getMeals(url: url) { [weak self] (response: MealsResponse) in
            for meal in response.meals ?? [] {
                let mealUrl = "https://www.themealdb.com/api/json/v1/1/lookup.php?i=\(meal.idMeal ?? "")"
                self?.network.getMeals(url: mealUrl) { (incomingResponse: MealsResponse) in
                    self?.mealsArr.append(incomingResponse.meals?[0] ?? Meal())
                }
            }
        }
    }
}

class FilterdListModel: Codable,Identifiable{
    var title: String
    var imageName: String
    
    init(title: String, imageName: String) {
        self.title = title
        self.imageName = imageName
    }
}
