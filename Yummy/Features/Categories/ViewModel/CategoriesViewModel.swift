//
//  CategoriesViewModel.swift
//  Yummy
//
//  Created by Ahmed on 24/08/2023.
//

import Foundation

class CategoriesViewModel: BaseViewModel {
    // MARK: - Properties
    @Published var isLoading: Bool = true
    private var dispatchGroup = DispatchGroup()
    private var service = MealCategoriesService()
    private var availableCategories: [CategoriesSubFilterCellModel] = []
    private var availableCountries: [CategoriesSubFilterCellModel] = []
    private var availableIngredients: [CategoriesSubFilterCellModel] = []
    var presentationFilterList: [CategoriesSubFilterCellModel] = []
    var mealsArr: [Meal] = []
    var selectedFilter: CategoriesMainFilter = .categories
    var selectedItemIndex: Int = 0
    
    // MARK: - Initializer(s)
    override init() {
        super.init()
        preapreFilterItemsLists()
    }
    
    // MARK: - Preparing intial filter lists for all Main Filter Categories
    func preapreFilterItemsLists() {
        getAllCategories()
        getAllIngredients()
        getAllCountries()
    }
    
    /// Getting all available  categories
    private func getAllCategories() {
        service.getAllCategories { [weak self] response in
            guard let self else { return }
            availableCategories = (response?.categories ?? []).map { CategoriesSubFilterCellModel(title: $0.strCategory ?? "", imageName: $0.strCategoryThumb ?? "") }
            updateFilter()
        }
    }
    
    /// Getting all available  ingredients
    private func getAllIngredients() {
        service.getAllIngredients { [weak self] response in
            guard let self else { return }
            availableIngredients = (response?.meals ?? []).map {
                CategoriesSubFilterCellModel(title: $0.strIngredient ?? "", imageName: Shortcuts.getIngredientImage(ingredientName: $0.strIngredient ?? ""))
            }
        }
    }
    
    /// Getting all available  countries
    private func getAllCountries() {
        service.getAllCountries { [weak self] response in
            guard let self else { return }
            availableCountries = (response?.meals ?? []).map { CategoriesSubFilterCellModel(title: $0.strArea ?? "", imageName: Flags.getFlag(mealSource: $0.strArea ?? "")) }
        }
    }
    
    // MARK: - Filter Meals
    func updateFilter(_ filter: CategoriesMainFilter? = nil, filterItemIndex: Int? = nil) {
        isLoading = true
        if let filter {
            selectedFilter = filter
        }
        applyFilter(by: filterItemIndex ?? 0)
        service.getFilteredList(
            type: selectedFilter,
            subFilter: presentationFilterList[selectedItemIndex].title
        ) { [weak self] meals in
            guard let self else { return }
            mealsArr = meals
            isLoading = false
        }
    }
    
    /// Apply the Category filter
    private func applyFilter(by filterItemIndex: Int) {
        selectedItemIndex = filterItemIndex
        switch selectedFilter {
        case .categories:
            presentationFilterList = availableCategories
            
        case .ingredients:
            presentationFilterList = availableIngredients
            
        case .countries:
            presentationFilterList = availableCountries
        }
    }
}
