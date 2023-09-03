//
//  MealDetails.swift
//  Yummy
//
//  Created by Ahmed on 22/08/2023.
//

import SwiftUI
import YouTubePlayerKit
import Kingfisher
import AVFoundation
import _AVKit_SwiftUI

struct MealDetails: View {
    @Environment(\.dismiss) private var dismiss
    var meal: Meal
    @StateObject var detailsViewModel = MealDetailsViewModel()
    @State var showVideo = false
    @State var showImage = false

    var body: some View {
        ZStack(alignment: .top){
            LinearGradient(colors: [.gray.opacity(0.3),.white], startPoint: .top, endPoint: .bottom).ignoresSafeArea()
            VStack{
                TopThird(showImage: $showImage, showVideo: $showVideo, meal: meal)
                ScrollView{
                    IngredientsSection(detailsViewModel: detailsViewModel)
                    InstructionsSection(detailsViewModel: detailsViewModel).padding(.bottom, 30)
                }
                Spacer()
            }
            
            if showVideo {
                ZStack(alignment: .center){
                    Rectangle()
                        .fill(Color.black.opacity(0.75))
                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                        .onTapGesture {
                            showVideo = false
                        }
                    YouTubePlayerView(YouTubePlayer(stringLiteral: meal.strYoutube ?? ""))
                        .frame(width: UIScreen.main.bounds.width, height: 300)
                }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            }
            
            if showImage {
                ZStack(alignment: .center){
                    Rectangle()
                        .fill(Color.black.opacity(0.75))
                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                    KFImage(URL(string: meal.strMealThumb ?? ""))
                        .resizable()
                        .scaledToFit()
                }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                    .onTapGesture {
                        withAnimation {
                            showImage = false
                        }
                    }
            }
            HStack(alignment: .center){
                BackButton(color: .white)
                    .onTapGesture {
                        withAnimation {
                            if showVideo{
                                showVideo = false
                            }else if showImage {
                                showImage = false
                            }else{
                                dismiss()
                            }
                        }
                    }
                Spacer()
            }
        }
        .toolbar(.hidden, for: .tabBar, .navigationBar)
        .ignoresSafeArea()
        .onAppear{
            detailsViewModel.prepareIngredientsArrays(meal: meal)
            detailsViewModel.prepareInstructions(meal: meal)
        }
    }
}

//struct MealDetails_Previews: PreviewProvider {
//    static var previews: some View {
//        IngredientList()
//    }
//}

struct TopThird: View{
    @Binding var showImage: Bool
    @Binding var showVideo: Bool
    @State var alertPresented = false
    @State var dayAlertPresent = false
    @State var daySelected: WeekDays = .sat
    @StateObject var weekPLanViewModel = WeekPlanViewModel()
    @StateObject var favViewModel = FavoriteViewModel()
    @State var isFav: Bool = false
    var meal:Meal
    var body: some View{
        ZStack{
            KFImage(URL(string: meal.strMealThumb ?? ""))
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/2.5)
            
            Rectangle()
                .fill(Color.black.opacity(0.5))
                .onTapGesture {
                    withAnimation {
                        showImage = true
                    }
                }
            
            VStack(alignment:.leading){
                Spacer()
                
                Image(systemName: "play.circle.fill")
                    .resizable()
                    .frame(width: 45,height: 45)
                    .foregroundColor(.orange)
                    .background(Color.white)
                    .cornerRadius(25)
                    .padding(.leading, 24)
                    .onTapGesture {
                        withAnimation {
                            showVideo = true
                        }
                    }
//                    }.sheet(isPresented: $showVideo) {
//                        WebView(url: (URL(string: meal.strYoutube ?? "") ?? URL(string: ""))!)
//                    }

                HStack(alignment: .center){
                    Text(meal.strMeal ?? "")
                        .lineLimit(3)
                        .frame(width: 250,alignment: .leading)
                        .font(.system(size: 30))
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .padding(.leading,28)
                    
                    Spacer()
                    
                    VStack(spacing: 8){
                        Menu {
                            ForEach(WeekDays.allCases, id: \.self){ day in
                                DaysMenuItem(alreadyInPlan: weekPLanViewModel.checkMealIsAlreadyInPlan(day: day, meal: meal), daySelected: $daySelected, dayAlertPresent: $dayAlertPresent, weekPLanViewModel: weekPLanViewModel, day: day, meal: meal)
                            }
                        } label: {
                            Image(systemName: "calendar")
                                .resizable()
                                .frame(width: 37,height: 37)
                                .foregroundColor(.orange)
                        }.alert("Warning", isPresented: $dayAlertPresent) {
                            Button("OK") {}
                            }message: {
                                Text(weekPLanViewModel.checkMealIsAlreadyInPlan(day: daySelected, meal: meal) ? "Added to \(weekPLanViewModel.getFullDayName(day: daySelected))'s plan" : "Removed from \(weekPLanViewModel.getFullDayName(day: daySelected))'s plan")
                            }
                        
                        Image(systemName: "heart.square.fill")
                            .resizable()
                            .frame(width: 40,height: 40)
                            .foregroundColor(.orange)
                            .background(isFav ? Color.red : Color.clear)
                            .cornerRadius(12)
                            .onTapGesture {
                                withAnimation {
                                    isFav.toggle()
                                    isFav ? favViewModel.addMealToFav(meal: meal) : favViewModel.deleteMealFromFav(meal: meal)
                                    alertPresented = true
                                }
                            }.alert("Warning", isPresented: $alertPresented) {
                                Button("OK") {}
                                }message: {
                                    Text(isFav ? "Added to Favorite" : "Removed From Favorite")
                                }
                    } .padding(.trailing, 24)
                }
                
                HStack{
                    Image(systemName: "fork.knife")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.orange)
                        .frame(width: 20,height: 20)
                        .padding(.leading,40)
                    
                    Text(meal.strCategory ?? "")
                        .font(.system(size: 18))
                        .foregroundColor(.white)
                        .fontWeight(.medium)
                    
                    Spacer()
                    
                    Image(systemName: "location")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.orange)
                        .frame(width: 20,height: 20)
                    
                    Text(meal.strArea ?? "")
                        .font(.system(size: 18))
                        .foregroundColor(.white)
                        .fontWeight(.medium)
                        
                    Spacer()
                    
                }.padding(EdgeInsets(top: -10, leading: 0, bottom: 16, trailing: 0))
            }
        }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/2.5)
            .cornerRadius(10)
            .onAppear{
                isFav = favViewModel.checkMealIsFav(meal: meal)
            }
    }
}

struct DaysMenuItem: View{
    @State var alreadyInPlan: Bool
    @Binding var daySelected: WeekDays
    @Binding var dayAlertPresent: Bool
    @ObservedObject var weekPLanViewModel: WeekPlanViewModel
    var day: WeekDays
    var meal: Meal
    var body: some View{
        Button {
            withAnimation {
                alreadyInPlan.toggle()
                alreadyInPlan ? weekPLanViewModel.addMealToDayPlan(day: day, meal: meal) : weekPLanViewModel.deleteMealFromDayPlan(day: day, meal: meal)
                dayAlertPresent = true
                daySelected = day
            }
        } label: {
            HStack{
                if alreadyInPlan {
                    Image(systemName: "checkmark.seal.fill")
                }
                Text(day.rawValue)
            }.onAppear{
                alreadyInPlan = weekPLanViewModel.checkMealIsAlreadyInPlan(day: day, meal: meal)
            }
        }
    }
}

struct MealDetailsSectionHeader: View {
    var title: String
    var imageName: String
    var body: some View {
        HStack(alignment:.center){
            Image(systemName: imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 23, height: 23)
                .padding(.leading,16)
                .foregroundColor(.black)
            Text(title)
                .padding(.leading,0)
                .font(.system(size: 20))
                .fontWeight(.bold)
        }
    }
}




