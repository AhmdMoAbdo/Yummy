//
//  SearchViewModel.swift
//  Yummy
//
//  Created by Ahmed on 25/08/2023.
//

import Foundation

class SearchViewModel: ObservableObject{
    
    @Published var mealsArr: [Meal] = []
    var network: APIService
    var done: ()->() = {}
    
    init(network: APIService) {
        self.network = network
    }
    
    func getMeals(keyWord: String){
        let searchWord = keyWord.replacingOccurrences(of: " ", with: "%20")
        mealsArr = []
        let url = "https://www.themealdb.com/api/json/v1/1/search.php?s=\(searchWord)"
        network.getMeals(url: url) { [weak self] (response:MealsResponse) in
            self?.mealsArr = response.meals ?? []
            self?.done()
        }
    }
}
