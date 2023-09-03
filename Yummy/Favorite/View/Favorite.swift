//
//  Favorite.swift
//  Yummy
//
//  Created by Ahmed on 25/08/2023.
//

import SwiftUI

struct Favorite: View {
    @StateObject var favViewModel = FavoriteViewModel()
    var body: some View {
        ZStack{
            LinearGradient(colors: [.gray.opacity(0.3),.white], startPoint: .top, endPoint: .bottom).ignoresSafeArea()
            VStack{
                FavPageHeader(pageTitle: "Favorites", animationName: "RBFav")
                if favViewModel.favMeals.isEmpty{
                    Spacer()
                    ImageMessage(imageName: "EmptyPlate", message: "No Favorite Meals Found").padding(.bottom, 100)
                }else{
                    FavMealsList(favViewModel: favViewModel).padding(.top, -8)
                }
                Spacer()
            }
            .toolbar(.hidden, for: .navigationBar,.tabBar)
            .ignoresSafeArea(.all,edges: .bottom)
            .onAppear{
                favViewModel.getFavMeals()
            }
        }
    }
}

struct Favorite_Previews: PreviewProvider {
    static var previews: some View {
        Favorite()
    }
}

struct FavMealsList: View{
    @ObservedObject var favViewModel: FavoriteViewModel
    @State var alertPresented = false
    var body: some View{
        List{
            ForEach(favViewModel.favMeals){meal in
                ZStack{
                    MealCell(favViewModel: favViewModel, meal: meal)
                        .swipeActions{
                            Button {
                                withAnimation {
                                    alertPresented = true
                                }
                            } label: {
                                Label("Delete", systemImage: "trash.circle.fill")
                            }
                            .tint(Color.red)
                        }
                        .padding(.bottom, favViewModel.getMealIndex(meal: meal) == favViewModel.favMeals.count - 1 ? 98 : 0 )
                    NavigationLink(destination: MealDetails(meal: meal)) {
                        Rectangle().opacity(0.0)
                            .frame(width: UIScreen.main.bounds.width * 5,height: 180)
                    }
                }
                .padding(.bottom, favViewModel.getMealIndex(meal: meal) == favViewModel.favMeals.count - 1 ? -98 : 0 )
                .alert("Warning", isPresented: $alertPresented) {
                    Button("Delete", role: .destructive) {
                        withAnimation {
                            favViewModel.deleteMealFromFav(meal: meal)
                        }
                    }
                    Button("Cancel", role: .cancel) {}
                    }message: {
                        Text("Remove this meal from favorite?")
                    }
            }
            .listRowSeparator(.hidden)
            .listRowInsets(EdgeInsets(top: 6, leading: 0, bottom: 6, trailing: 0))
            .listRowBackground(Color.clear)
        }
        .listStyle(.plain)
    }
}

struct FavPageHeader: View {
    var pageTitle: String
    var animationName: String
    var body: some View {
        HStack{
            IconAnimation(lottieFile: animationName)
                .frame(width: 40,height: 40)
                .padding(EdgeInsets(top: 5, leading: 8, bottom: 5, trailing: 4))
            PageTitle(title: pageTitle)
            Spacer()
            SearchImage()
        }
    }
}
