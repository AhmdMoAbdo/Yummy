//
//  IngredientsView.swift
//  Yummy
//
//  Created by Ahmed on 28/08/2023.
//

import SwiftUI
import Kingfisher

struct IngredientsSection: View {
    @ObservedObject var detailsViewModel: MealDetailsViewModel
    @State var tiles = true
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                MealDetailsSectionHeader(title: "Ingredients:", imageName: "cart.fill")
                Spacer()
                Image(systemName: tiles ? "list.bullet" : "slider.horizontal.below.square.and.square.filled")
                    .padding(.trailing, 16)
                    .onTapGesture {
                        withAnimation {
                            tiles.toggle()
                        }
                    }
            }
            if tiles{
                IngredientTileScroll(detailsViewModel: detailsViewModel)
            }else{
                IngredientList(detailsViewModel: detailsViewModel)
                    .padding(EdgeInsets(top: 16, leading: 0, bottom: 16, trailing: 0))
                    .background(Color.white)
                    .cornerRadius(20)
                    .padding(EdgeInsets(top: -4, leading: 16, bottom: 0, trailing: 16))
                    .shadow(radius: 5)
            }
        }.padding(.top,8)
    }
}

struct IngredientList: View{
    @ObservedObject var detailsViewModel: MealDetailsViewModel
    var body: some View{
        VStack(spacing: 8){
            ForEach(detailsViewModel.topIngredientsArr){ ingredient in
                IngredientListCell(ingredient: ingredient)
            }
            ForEach(detailsViewModel.bottomIngredientsArr){ ingredient in
                IngredientListCell(ingredient: ingredient)
            }
        }
    }
}

struct IngredientListCell: View{
    var ingredient: MealIngredient
    var body: some View{
        HStack{
            Image(systemName: "oval.fill")
                .resizable()
                .frame(width: 15,height: 10)
                .foregroundColor(.orange)
                .padding(.leading, 16)
            Text("\(ingredient.ingredientName) - \(ingredient.amount)")
                .font(.system(size: 18))
                .fontWeight(.medium)
            Spacer()
        }
    }
}

struct IngredientTileScroll: View {
    @ObservedObject var detailsViewModel: MealDetailsViewModel
    var body: some View {
        ScrollView(.horizontal){
            VStack(alignment: .leading, spacing: 12){
                HStack(spacing: 0){
                    ForEach(detailsViewModel.topIngredientsArr){ ingredient in
                        IngredientCell(ingredient: ingredient)
                    }
                }.padding(.trailing, 16)
                HStack(spacing: 0){
                    ForEach(detailsViewModel.bottomIngredientsArr){ ingredient in
                        IngredientCell(ingredient: ingredient)
                    }
                }.padding(EdgeInsets(top: 0, leading: 0, bottom: 8, trailing: 16))
            }.padding(.top, 12)
        }.padding(.top,-16)
            .scrollIndicators(.hidden)
    }
}

struct IngredientCell: View {
    var ingredient: MealIngredient
    var body: some View {
        ZStack(alignment:.bottom){
            KFImage(URL(string: ingredient.thumbnail))
                .resizable()
                .scaledToFit()
                .frame(width: 100,height: 150)
                            
            ZStack{
                HStack{
                    Spacer()
                    VStack{
                        Text(ingredient.ingredientName)
                            .font(.system(size: 16))
                            .fontWeight(.heavy)
                            .frame(alignment: .center)
                            .multilineTextAlignment(.center)
                        Text(ingredient.amount)
                            .font(.system(size: 14))
                            .fontWeight(.regular)
                            .multilineTextAlignment(.center)
                    }
                    Spacer()
                }
            }.background(Color.black.opacity(0.5))
                .foregroundColor(.white)
                .frame(minWidth: 100)
        }
        .frame(width: 125, height: 150)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 5)
        .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 0))
    }
}
