//
//  Search.swift
//  Yummy
//
//  Created by Ahmed on 25/08/2023.
//

import SwiftUI

struct Search: View {
    // MARK: - Properties
    @Environment(\.dismiss) private var dismiss
    @State var searchText: String = ""
    @StateObject var viewModel = SearchViewModel()
    
    // MARK: - Drawing View
    var body: some View {
        ZStack {
            AppBackgroundGradient()
            VStack {
                PageHeader(
                    pageTitle: Constants.Search.pageHeader,
                    hasSearch: false
                )
                makeSearchBar()
                if viewModel.isLoading {
                    FullScreenLoader()
                } else {
                    if viewModel.mealsArr.isEmpty {
                        EmptyStateView(
                            imageName: viewModel.didFetchMealsBefore ? Constants.Images.searchNotItemsFound : Constants.Images.searchFindMeal,
                            message: viewModel.didFetchMealsBefore ? Constants.Search.noMealsFound : Constants.Search.findNewMeals
                        )
                    } else {
                        makeMealsList()
                    }
                }
            }
        }
        .ignoresSafeArea(.all, edges: .bottom)
        .toolbar(.hidden, for: .tabBar, .navigationBar)
    }
    
    // MARK: - Search Bar
    private func makeSearchBar() -> some View {
        HStack {
            TextField(Constants.Search.searchHint, text: $searchText)
                .frame(height: 25)
                .font(.system(size: 22))
                .padding(12)
            
            Spacer()
            
            Image(systemName: Constants.Images.searchIcon)
                .padding(.trailing, 12)
                .onTapGesture {
                    withAnimation {
                        viewModel.searchMeals(using: searchText)
                    }
                }
        }
        .background(Color.gray.opacity(0.5))
        .cornerRadius(10)
        .padding(.horizontal, 16)
        .padding(.bottom, 8)
    }
    
    // MARK: - Meals List
    private func makeMealsList() -> some View {
        List {
            ForEach(viewModel.mealsArr.indices, id: \.self) { index in
                MealCell(
                    meal: viewModel.mealsArr[index],
                    isFav: viewModel.checkMealIsFav(meal: viewModel.mealsArr[index])
                ) { isFav, meal in
                    isFav ? viewModel.addMealToFav(meal: meal) : viewModel.deleteMealFromFav(meal: meal)
                }
                .stealthListRow()
            }
            
            Color.clear.frame(height: (Shortcuts.window?.safeAreaInsets.bottom ?? 0) > 0 ? Shortcuts.window?.safeAreaInsets.bottom ?? 0 : 8)
                .stealthListRow(bottomInset: 16)
        }
        .listStyle(.plain)
        .listRowSpacing(8)
        .scrollIndicators(.never)
    }
}

// MARK: - Preview
#Preview {
    Search()
}
