//
//  Categories.swift
//  Yummy
//
//  Created by Ahmed on 23/08/2023.
//

import SwiftUI
import Kingfisher

var categoriesVM = CategoriesViewModel(network: APIHandler())

struct Categories: View {
    @State var selectedFilter = 0
    @State var selectedFilterItemName = "Beef"
    @StateObject var categoriesViewModel = categoriesVM
    @State var loading = false
    
    var body: some View {
        ZStack{
            LinearGradient(colors: [.gray.opacity(0.5),.white], startPoint: .top, endPoint: .bottom).ignoresSafeArea()
            VStack{
                PageHeader(pageTitle: "Menu", animationName: "category")
                FilterPicker(selectedFilter: $selectedFilter, selectedFilterItemName: $selectedFilterItemName, categoriesViewModel: categoriesViewModel, loading: $loading)
                SelectedFilterList(categoriesViewModel: categoriesViewModel, selectedFilter: $selectedFilter, selectedFilterItemName: $selectedFilterItemName, loading: $loading)
                if loading{
                    Spacer()
                    IconAnimation(lottieFile: "fork",animationLoop: .loop)
                        .frame(width: 200,height: 200)
                        .padding(.bottom, 100)
                }else{
                    MealsList(categoriesViewModel: categoriesViewModel)
                }
                Spacer()
            }
        }
        .toolbar(.hidden, for: .navigationBar,.tabBar)
        .ignoresSafeArea(.all,edges: .bottom)
        .onAppear{
            categoriesViewModel.done = {loading = false}
        }
    }
}

struct Categories_Previews: PreviewProvider {
    static var previews: some View {
        Categories()
    }
}

struct FilterPicker: View {
    @StateObject var segmentedHandler = SegmentedChangeHandler(viewModel: categoriesVM)
    @Binding var selectedFilter: Int
    @Binding var selectedFilterItemName: String
    @StateObject var categoriesViewModel: CategoriesViewModel
    @Binding var loading: Bool
    var body: some View {
        Picker("Filter by", selection: $segmentedHandler.selectedFilter){
            Text("Categories").tag(0)
            Text("Ingredients").tag(1)
            Text("Countries").tag(2)
        }.pickerStyle(.segmented)
        .padding(EdgeInsets(top: -8, leading: 16, bottom: 0, trailing: 16))
        .onAppear{
            segmentedHandler.filterChanged = {name, num in
                withAnimation {
                    selectedFilter = num
                    selectedFilterItemName = name
                    loading = true
                }
            }
        }
    }
}

struct SelectedFilterList: View{
    @ObservedObject var categoriesViewModel: CategoriesViewModel
    @Binding var selectedFilter: Int
    @Binding var selectedFilterItemName: String
    @Binding var loading: Bool
    var body: some View{
        ScrollView(.horizontal){
            HStack(spacing: 0){
                if selectedFilter == 0{
                    ForEach(categoriesViewModel.categoriesToDisplay){category in
                        SelectedFilterListItem(selectedFilterItemName: $selectedFilterItemName, selectedFilterNumber: $selectedFilter, categoriesViewModel: categoriesViewModel, loading: $loading, itemToDisplay: category)
                    }
                }else if selectedFilter == 1{
                    ForEach(categoriesViewModel.ingredientsToDisplay){ingredient in
                        SelectedFilterListItem(selectedFilterItemName: $selectedFilterItemName, selectedFilterNumber: $selectedFilter, categoriesViewModel: categoriesViewModel, loading: $loading, itemToDisplay: ingredient)                    }
                }else{
                    ForEach(categoriesViewModel.countriesToDisplay){country in
                        SelectedFilterListItem(selectedFilterItemName: $selectedFilterItemName, selectedFilterNumber: $selectedFilter, categoriesViewModel: categoriesViewModel, loading: $loading, itemToDisplay: country)                    }
                }
            }
            .padding(EdgeInsets(top: 0, leading: 4, bottom: 0, trailing: 16))
        }.scrollIndicators(.hidden)
    }
}

struct SelectedFilterListItem: View{
    @Binding var selectedFilterItemName: String
    @Binding var selectedFilterNumber: Int
    @ObservedObject var categoriesViewModel: CategoriesViewModel
    @Binding var loading: Bool
    var itemToDisplay: FilterdListModel
    var body: some View {
        ZStack(alignment: .bottom){
            
            KFImage(URL(string: itemToDisplay.imageName))
                .resizable()
                .scaledToFill()
                .frame(width: 160,height: 100)
                
                
                HStack{
                    Spacer()
                    Text(itemToDisplay.title)
                        .padding(4)
                        .foregroundColor(.white)
                        .font(.system(size: 18))
                        .fontWeight(.bold)
                    Spacer()
                }.background(Color.black.opacity(0.5))
        }.frame(width: 130)
            .background(Color.white)
            .cornerRadius(20)
            .shadow(radius: selectedFilterItemName == itemToDisplay.title ? 0 : 5)
            .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(.orange, lineWidth: selectedFilterItemName == itemToDisplay.title ? 4.5 : 0)
                )
            .padding(EdgeInsets(top: 8, leading: 12, bottom: 8, trailing: 0))
            .onTapGesture {
                withAnimation {
                    categoriesViewModel.getFilteredMeals(filterNumber: selectedFilterNumber, filterItem: itemToDisplay.title)
                    selectedFilterItemName = itemToDisplay.title
                    loading = true
                }
            }
    }
}

struct MealsList: View{
    @ObservedObject var categoriesViewModel: CategoriesViewModel
    @StateObject var favViewModel = FavoriteViewModel()
    var body: some View{
        ScrollView{
            VStack(spacing: 12){
                ForEach(categoriesViewModel.mealsArr){meal in
                    NavigationLink{
                        MealDetails(meal: meal)
                    }label: {
                        MealCell(favViewModel: favViewModel, meal: meal)
                    }.navigationViewStyle(.stack)
                }
            }.padding(.bottom, 98)
        }.onAppear{
            favViewModel.getFavMeals()
        }
    }
}

