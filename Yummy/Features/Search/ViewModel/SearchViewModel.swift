//
//  SearchViewModel.swift
//  Yummy
//
//  Created by Ahmed on 25/08/2023.
//

import Foundation

class SearchViewModel: BaseViewModel {
    // MARK: - Properties
    @Published var isLoading: Bool = false
    private var service = SearchService()
    var mealsArr: [Meal] = []
    var didFetchMealsBefore = false
    
    // MARK: - Searching meals
    func searchMeals(using keyWord: String) {
        didFetchMealsBefore = true
        service.searchFor(query: keyWord) { [weak self] response in
            guard let self else { return }
            mealsArr = response?.meals ?? []
            isLoading = false
        }
    }
}
