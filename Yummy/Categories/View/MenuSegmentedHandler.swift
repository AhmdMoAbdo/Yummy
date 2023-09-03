//
//  MenuSegmentedHandler.swift
//  Yummy
//
//  Created by Ahmed on 28/08/2023.
//

import Foundation

class SegmentedChangeHandler: ObservableObject{
    var viewModel: CategoriesViewModel
    var selectedFilter = 0{
        didSet{
            switch selectedFilter{
            case 0:
                viewModel.getFilteredMeals(filterNumber: 0, filterItem: viewModel.categoriesToDisplay[0].title)
                filterChanged(viewModel.categoriesToDisplay[0].title, 0)
            case 1:
                viewModel.getFilteredMeals(filterNumber: 1, filterItem: viewModel.ingredientsToDisplay[0].title)
                filterChanged(viewModel.ingredientsToDisplay[0].title, 1)
            default:
                viewModel.getFilteredMeals(filterNumber: 2, filterItem: viewModel.countriesToDisplay[0].title)
                filterChanged(viewModel.countriesToDisplay[0].title, 2)
            }
        }
    }
    var filterChanged: (String,Int)->() = { _,_ in}
    
    init(viewModel: CategoriesViewModel, selectedFilter: Int = 0) {
        self.viewModel = viewModel
        self.selectedFilter = selectedFilter
    }
}
