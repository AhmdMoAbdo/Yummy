//
//  Categories.swift
//  Yummy
//
//  Created by Ahmed on 23/08/2023.
//

import SwiftUI
import Kingfisher


struct Categories: View {
    // MARK: - Properties
    @State var selectedFilter = 0
    @StateObject var viewModel = CategoriesViewModel()
    
    // MARK: - Drawing View
    var body: some View {
        ZStack {
            AppBackgroundGradient()
            VStack{
                PageHeader(
                    pageTitle: Constants.Categories.pageHeader,
                    animationName: Constants.LottieAnimation.category
                )
                makeMainFilterSegmentedView()
                makeSubFilterList()
                if viewModel.isLoading {
                    FullScreenLoader()
                } else {
                    makeFilteredMealsList()
                }
            }
        }
        .toolbar(.hidden, for: .navigationBar, .tabBar)
        .ignoresSafeArea(.all, edges: .bottom)
        .onAppear {
            viewModel.forceRefreshView()
        }
    }
    
    // MARK: - Segmented Filter View
    private func makeMainFilterSegmentedView() -> some View {
        Picker("", selection: $selectedFilter) {
            ForEach(CategoriesMainFilter.allCases, id: \.rawValue) { filter in
                Text(filter.getTitle())
                    .tag(filter.rawValue)
            }
        }
        .pickerStyle(.segmented)
        .padding(.horizontal, 16)
        .padding(.top, -8)
        .onChange(of: selectedFilter) { oldValue, newValue in
            guard let filter = CategoriesMainFilter(rawValue: newValue) else { return }
            viewModel.updateFilter(filter)
        }
    }
    
    // MARK: - SubFilter list
    private func makeSubFilterList() -> some View {
        ScrollView(.horizontal) {
            LazyHStack(spacing: 0) {
                ForEach(viewModel.presentationFilterList.indices, id: \.self) { itemIndex in
                    SubFilterListCell(
                        itemToDisplay: viewModel.presentationFilterList[itemIndex],
                        isSelected: viewModel.selectedItemIndex == itemIndex
                    ) {
                        viewModel.updateFilter(filterItemIndex: itemIndex)
                    }
                    .contentShape(Rectangle())
                }
            }
            .frame(height: 116)
            .padding(EdgeInsets(top: 0, leading: 4, bottom: 0, trailing: 16))
        }
        .scrollIndicators(.hidden)
    }
    
    // MARK: - Meals List
    private func makeFilteredMealsList() -> some View {
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
            
            Color.clear.frame(height: Shortcuts.tabbarHeight)
                .stealthListRow(bottomInset: 16)
        }
        .listStyle(.plain)
        .listRowSpacing(8)
        .scrollIndicators(.never)
    }
}

// MARK: - Preview
#Preview {
    Categories()
}
