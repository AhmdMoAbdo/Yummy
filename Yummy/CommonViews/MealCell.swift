//
//  MealCell.swift
//  Yummy
//
//  Created by Ahmed on 28/08/2023.
//

import SwiftUI
import Kingfisher

struct MealCell: View{
    @ObservedObject var favViewModel: FavoriteViewModel
    @State var isFav: Bool = false
    @State var alertPresented = false
    var meal: Meal
    var body: some View{
        ZStack(alignment: .leading){
            KFImage(URL(string: meal.strMealThumb ?? ""))
                .resizable()
                .scaledToFill()
                .frame(width:UIScreen.main.bounds.width - 32 ,height: 180)
            
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.black.opacity(0.555))
            
            HStack(alignment: .top){
                VStack(alignment: .leading){
                    HStack{
                        Text(meal.strMeal ?? "")
                            .font(.system(size: 22))
                            .fontWeight(.bold)
                            .multilineTextAlignment(.leading)
                        Spacer()
                    }
                    
                    Spacer()
                    
                    TypeOrOrigin(title: meal.strCategory ?? "", imageName: "fork.knife")
                    TypeOrOrigin(title: meal.strArea ?? "", imageName: "location")
                    
                }.foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.width/2.5)
                    
                Spacer()
                
                Image(systemName: "heart.square.fill")
                    .resizable()
                    .frame(width: 40,height: 40)
                    .foregroundColor(.orange)
                    .background(isFav ? Color.red : Color.clear)
                    .cornerRadius(12)
                    .onTapGesture {
                        withAnimation {
                            alertPresented = true
                        }
                    }.alert("Warning", isPresented: $alertPresented) {
                        Button(isFav ? "Delete" : "Add", role: isFav ? .destructive : nil) {
                            withAnimation {
                                isFav.toggle()
                                isFav ? favViewModel.addMealToFav(meal: meal) : favViewModel.deleteMealFromFav(meal: meal)
                            }
                        }
                        Button("Cancel", role: .cancel) {}
                        }message: {
                            Text(isFav ? "Remove this meal from favorite?" : "Add this meal to favorites?" )
                        }
            }.padding(16)
        }
        .frame(width:UIScreen.main.bounds.width - 32 ,height: 180)
        .cornerRadius(20)
        .shadow(radius: 5)
        .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
        .onAppear{
            isFav = favViewModel.checkMealIsFav(meal: meal)
        }
    }
}

struct TypeOrOrigin: View {
    var title: String
    var imageName: String
    var textColor: Color = .white
    var body: some View {
        HStack(){
            Image(systemName: imageName)
                .resizable()
                .scaledToFit()
                .foregroundColor(.orange)
                .frame(width: 20,height: 20)
            
            Text(title)
                .font(.system(size: 18))
                .foregroundColor(textColor)
                .fontWeight(.regular)
        }
    }
}
