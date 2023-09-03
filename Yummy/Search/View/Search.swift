//
//  Search.swift
//  Yummy
//
//  Created by Ahmed on 25/08/2023.
//

import SwiftUI

struct Search: View {
    @Environment(\.dismiss) private var dismiss
    @State var caseNumber = 0
    @StateObject var searchViewModel = SearchViewModel(network: APIHandler())
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(colors: [.gray.opacity(0.3),.white], startPoint: .top, endPoint: .bottom).ignoresSafeArea()
                VStack{
                    TitleAndBackButton(dismiss: dismiss)
                    SearchBar(caseNumber: $caseNumber, searchViewModel: searchViewModel)
                    if caseNumber == 0{
                        Spacer()
                        ImageMessage(imageName: "FindMeal", message: "Lookup new meals")
                            .padding(.bottom, 100)
                    }else if caseNumber == 1{
                        Spacer()
                        IconAnimation(lottieFile: "fork",animationLoop: .loop)
                            .frame(width: 200,height: 200)
                            .padding(.bottom, 100)
                    }else if caseNumber == 2{
                        Spacer()
                        ImageMessage(imageName: "EmptyPlate", message: "No Meals Found")
                            .padding(.bottom, 100)
                    }else{
                        FoundMealsList(searchViewModel: searchViewModel).padding(.top, 16)
                    }
                    Spacer()
                }
            }.ignoresSafeArea(.all, edges: .bottom)
        }.toolbar(.hidden, for: .tabBar, .navigationBar)
            .onAppear{
                searchViewModel.done = {
                    withAnimation {
                        if searchViewModel.mealsArr.count == 0{
                            caseNumber = 2
                        }else{
                            caseNumber = 3
                        }
                    }
                }
            }
    }
}

struct ImageMessage: View{
    var imageName: String
    var message: String
    var body: some View{
        VStack{
            Image(imageName)
                .resizable()
                .frame(width: 150, height: 150)
            Text(message)
                .font(.system(size: 22))
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
        }
        .opacity(0.6)
        .frame(width: 150)
    }
}

struct Search_Previews: PreviewProvider {
    static var previews: some View {
        Search()
    }
}

struct TitleAndBackButton: View {
    var dismiss: DismissAction
    var body: some View {
        HStack{
            Image(systemName: "chevron.backward.circle.fill")
                .resizable()
                .frame(width: 30,height: 30)
                .foregroundColor(.black)
                .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 12))
                .onTapGesture {
                    dismiss()
                }
            PageTitle(title: "Search")
            Spacer()
        }.padding(.top, 8)
    }
}

struct SearchBar: View {
    @Binding var caseNumber: Int
    @State var searchText: String = ""
    @ObservedObject var searchViewModel: SearchViewModel
    var body: some View {
        ZStack{
            TextField("Keyword", text: $searchText)
                .frame(height: 25)
                .padding(10)
                .background(Color.gray.opacity(0.5))
                .cornerRadius(10)
                .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                .font(.system(size: 22))
            HStack{
                Spacer()
                Image(systemName: "magnifyingglass")
                    .padding(.trailing, 32)
                    .onTapGesture {
                        withAnimation {
                            searchViewModel.getMeals(keyWord: searchText)
                            caseNumber = 1
                        }
                    }
            }
        }
    }
}

struct FoundMealsList: View{
    @ObservedObject var searchViewModel: SearchViewModel
    @StateObject var favViewModel = FavoriteViewModel()
    var body: some View{
        ScrollView{
            VStack(spacing: 8){
                ForEach(searchViewModel.mealsArr){meal in
                    NavigationLink{
                        MealDetails(meal: meal)
                    }label: {
                        MealCell(favViewModel: favViewModel, meal: meal)
                    }
                }
            }.padding(.bottom, 16)
        }
    }
}
